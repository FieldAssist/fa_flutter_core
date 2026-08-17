import 'package:realm/realm.dart';

import '../../../../fa_flutter_core.dart';

final AppLog _logger = AppLogImpl(packageName: 'fa_activity');

/// Realm-backed [ActivityDao].
///
/// The database handle comes from [ActivityRealmDb] rather than being opened
/// here, because a Realm is isolate-confined and its lifetime belongs to
/// whoever set the isolate up.
class ActivityDaoImpl implements ActivityDao {
  ActivityDaoImpl(this.activityRealmDb);

  final ActivityRealmDb activityRealmDb;

  /// Upper bound on locally buffered sessions. If uploads keep failing the
  /// oldest records are dropped rather than growing the database without limit.
  static const maxPendingActivities = 2000;

  Realm get _realm => activityRealmDb.realm;

  /// Oldest first. Realm results have no inherent order, so the sort is part of
  /// the query — [ActivityDao.getPendingActivities] promises this ordering and
  /// [_trimTo] relies on it to know which rows are the oldest.
  RealmResults<ActivitySessionEntity> get _oldestFirst =>
      _realm.query<ActivitySessionEntity>(r'TRUEPREDICATE SORT(startTime ASC)');

  @override
  Future<List<ActivitySession>> getPendingActivities() async =>
      _oldestFirst.map((entity) => entity.toModel()).toList();

  @override
  Future<void> savePendingActivities(List<ActivitySession> activities) async {
    final trimmed = activities.length > maxPendingActivities
        ? activities.sublist(activities.length - maxPendingActivities)
        : activities;

    if (trimmed.length < activities.length) {
      _logOverflow(activities.length - trimmed.length);
    }

    await _realm.writeAsync(() {
      _realm.deleteAll<ActivitySessionEntity>();
      _realm.addAll(trimmed.map(ActivitySessionEntityX.fromModel));
    });
  }

  @override
  Future<void> addPendingActivity(ActivitySession activity) async {
    final pending = await _realm.writeAsync(() {
      // `update: true` keys on the primary key, so re-adding the same session
      // overwrites it rather than creating a duplicate.
      _realm.add(ActivitySessionEntityX.fromModel(activity), update: true);
      return _trimTo(maxPendingActivities);
    });

    _logger.d('[ActivityDao] Buffered, $pending pending');
  }

  @override
  Future<void> removePendingActivities(List<String> guids) async {
    if (guids.isEmpty) {
      return;
    }

    // A guid can already be gone — `clear()` or an overflow trim may have run
    // while an upload was in flight — so missing rows are skipped, not an error.
    final rows = guids
        .map((guid) => _realm.find<ActivitySessionEntity>(guid))
        .nonNulls
        .toList();
    if (rows.isEmpty) {
      return;
    }

    await _realm.writeAsync(() => _realm.deleteMany(rows));
    _logger.d('[ActivityDao] Removed ${rows.length} uploaded session(s)');
  }

  @override
  Future<void> clearPendingActivities() =>
      _realm.writeAsync(() => _realm.deleteAll<ActivitySessionEntity>());

  /// Drops the oldest rows until at most [limit] remain, and returns how many
  /// are left. Must be called inside a write transaction.
  int _trimTo(int limit) {
    final pending = _oldestFirst;
    final excess = pending.length - limit;
    if (excess <= 0) {
      return pending.length;
    }

    // Materialized before deleting: `pending` is a live view that shrinks as
    // rows are removed.
    _realm.deleteMany(pending.take(excess).toList());
    _logOverflow(excess);
    return limit;
  }

  void _logOverflow(int dropped) {
    // Data loss — the only place it happens, so it must be visible.
    _logger.w(
      '[ActivityDao] Buffer over $maxPendingActivities, DROPPED $dropped '
      'oldest session(s). Uploads have been failing for a long time.',
    );
  }
}
