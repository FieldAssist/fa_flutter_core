import 'dart:async';
import 'dart:convert';

import '../../../fa_flutter_core.dart';

final AppLog _logger = AppLogImpl(packageName: 'fa_activity');

class ActivityRepositoryImpl implements ActivityRepository {
  ActivityRepositoryImpl({
    required this.appPrefs,
    required this.activityDao,
    this.uploader,
  });

  final AppPrefs appPrefs;
  final ActivityDao activityDao;

  @override
  ActivityUploader? uploader;

  /// Tail of the serialized mutation queue. See [_serialized].
  Future<void> _lock = Future<void>.value();

  int get _nowInMillis => DateTime.now().millisecondsSinceEpoch;

  /// Consistent label for log lines:
  /// `sfa:GeneralTrade/GTPinPage "App Opened" [3f6b1c9e]`.
  ///
  /// Names come from the enums, so a log line and the uploaded row read the
  /// same. The guid prefix is what lets one session be followed across the log
  /// — opened here, closed on a later screen, uploaded from the background
  /// isolate — and matched against a row the backend received.
  String _tag(ActivitySession session) {
    final guid = session.guid;
    final shortGuid = guid.length > 8 ? guid.substring(0, 8) : guid;
    final sub =
        session.subModuleName == null ? '' : '/${session.subModuleName}';
    return '${session.source.name}:${session.moduleName}$sub '
        '"${session.name}" [$shortGuid]';
  }

  @override
  ActivitySession? get currentSession =>
      _readSession(ActivityRepository.prefsCurrentActivity, 'current');

  @override
  ActivitySession? get appSession =>
      _readSession(ActivityRepository.prefsAppSession, 'application');

  /// Reads a session stored under [key], dropping it if it cannot be parsed.
  ///
  /// [label] only names the session in the error line.
  ActivitySession? _readSession(String key, String label) {
    final raw = appPrefs.getString(key);
    if (raw == null || raw.isEmpty) {
      return null;
    }
    try {
      return ActivitySession.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } catch (e) {
      // A malformed value would otherwise wedge tracking permanently.
      _logger.e('[Activity] Dropping unreadable $label session: $e',
          StackTrace.current);
      unawaited(appPrefs.remove(key));
      return null;
    }
  }

  @override
  Future<ActivitySession> track({
    required String name,
    required ActivityModule moduleEnum,
    ActivitySubModule? subModuleEnum,
    ActivitySource source = ActivitySource.sfa,
  }) =>
      _serialized(
        () => _trackUnlocked(
          name: name,
          moduleEnum: moduleEnum,
          subModuleEnum: subModuleEnum,
          source: source,
        ),
      );

  Future<ActivitySession> _trackUnlocked({
    required String name,
    required ActivityModule moduleEnum,
    ActivitySubModule? subModuleEnum,
    ActivitySource source = ActivitySource.sfa,
  }) async {
    final current = currentSession;
    final isSameScreen = current?.isSameScreenAs(
          name: name,
          moduleEnum: moduleEnum,
          subModuleEnum: subModuleEnum,
          source: source,
        ) ??
        false;

    if (current != null && isSameScreen) {
      // Already on this screen — let the open session keep accumulating.
      _logger.d(
        '[Activity] Continue ${_tag(current)} '
        '(${current.durationInMillis}ms so far)',
      );
      return current;
    }

    if (current != null) {
      _logger.d('[Activity] Switch ${_tag(current)} -> ${moduleEnum.label}'
          '${subModuleEnum == null ? '' : '/${subModuleEnum.label}'}');
    }

    return _startSessionUnlocked(
      name: name,
      moduleEnum: moduleEnum,
      subModuleEnum: subModuleEnum,
      source: source,
    );
  }

  /// Deliberately not [_serialized]: the lock guards read-modify-write of the
  /// current session in SharedPreferences, and this touches neither — it only
  /// appends one already-closed row. Queuing it behind a slow track() would
  /// delay a tap for no benefit.
  @override
  Future<ActivitySession> logEvent({
    required String name,
    required ActivityModule moduleEnum,
    ActivitySubModule? subModuleEnum,
    ActivitySource source = ActivitySource.sfa,
  }) async {
    final now = _nowInMillis;
    final event = ActivitySession(
      guid: const Uuid().v7(),
      name: name,
      moduleEnum: moduleEnum,
      startTime: now,
      endTime: now,
      subModuleEnum: subModuleEnum,
      source: source,
    );
    await activityDao.addPendingActivity(event);
    _logger.d('[Activity] Event ${_tag(event)} buffered');
    return event;
  }

  @override
  Future<ActivitySession> startSession({
    required String name,
    required ActivityModule moduleEnum,
    ActivitySubModule? subModuleEnum,
    ActivitySource source = ActivitySource.sfa,
  }) =>
      _serialized(
        () => _startSessionUnlocked(
          name: name,
          moduleEnum: moduleEnum,
          subModuleEnum: subModuleEnum,
          source: source,
        ),
      );

  Future<ActivitySession> _startSessionUnlocked({
    required String name,
    required ActivityModule moduleEnum,
    ActivitySubModule? subModuleEnum,
    ActivitySource source = ActivitySource.sfa,
  }) async {
    await _endCurrentSessionUnlocked();

    final session = ActivitySession(
      guid: const Uuid().v7(),
      name: name,
      moduleEnum: moduleEnum,
      startTime: _nowInMillis,
      subModuleEnum: subModuleEnum,
      source: source,
    );
    await _saveCurrentSession(session);
    _logger.d('[Activity] Started ${_tag(session)}');
    return session;
  }

  @override
  Future<ActivitySession?> updateCurrentSession({
    String? name,
    ActivityModule? moduleEnum,
    ActivitySubModule? subModuleEnum,
    bool clearSubModuleEnum = false,
  }) =>
      _serialized(
        () => _updateCurrentSessionUnlocked(
          name: name,
          moduleEnum: moduleEnum,
          subModuleEnum: subModuleEnum,
          clearSubModuleEnum: clearSubModuleEnum,
        ),
      );

  Future<ActivitySession?> _updateCurrentSessionUnlocked({
    String? name,
    ActivityModule? moduleEnum,
    ActivitySubModule? subModuleEnum,
    bool clearSubModuleEnum = false,
  }) async {
    final current = currentSession;
    if (current == null) {
      _logger.w('[Activity] updateCurrentSession ignored, nothing open');
      return null;
    }

    final updated = current.copyWith(
      name: name ?? current.name,
      moduleEnum: moduleEnum ?? current.moduleEnum,
      subModuleEnum:
          clearSubModuleEnum ? null : (subModuleEnum ?? current.subModuleEnum),
    );
    await _saveCurrentSession(updated);
    // Same guid and startTime: the session was amended, not split.
    _logger.d('[Activity] Updated ${_tag(current)} -> ${_tag(updated)}');
    return updated;
  }

  @override
  Future<ActivitySession> startAppSession({
    String name = 'Application',
    ActivityModule moduleEnum = ActivityModule.embeddedGtFaOne,
    ActivitySubModule subModuleEnum = ActivitySubModule.embeddedGtFaOneSession,
    ActivitySource source = ActivitySource.sfa,
  }) =>
      _serialized(() async {
        final open = appSession;
        if (open != null) {
          // Already running — a second call must not restart the clock, or a
          // re-entered lifecycle callback would silently discard the elapsed
          // time.
          _logger.d(
            '[Activity] App session already open ${_tag(open)} '
            '(${open.durationInMillis}ms so far)',
          );
          return open;
        }

        final session = ActivitySession(
          guid: const Uuid().v7(),
          name: name,
          moduleEnum: moduleEnum,
          startTime: _nowInMillis,
          source: source,
          subModuleEnum: subModuleEnum,
        );
        await appPrefs.setString(
          ActivityRepository.prefsAppSession,
          jsonEncode(session.toJson()),
        );
        _logger.d('[Activity] App session started ${_tag(session)}');
        return session;
      });

  @override
  Future<ActivitySession?> endAppSession() => _serialized(() async {
        final open = appSession;
        if (open == null) {
          _logger.d('[Activity] endAppSession: no app session open');
          return null;
        }

        final closed = open.copyWith(endTime: _nowInMillis);
        await activityDao.addPendingActivity(closed);
        await appPrefs.remove(ActivityRepository.prefsAppSession);
        _logger.d(
          '[Activity] App session closed ${_tag(closed)} after '
          '${closed.durationInMillis}ms, buffered for upload',
        );
        return closed;
      });

  @override
  Future<ActivitySession?> endCurrentSession() =>
      _serialized(_endCurrentSessionUnlocked);

  Future<ActivitySession?> _endCurrentSessionUnlocked() async {
    final current = currentSession;
    if (current == null) {
      _logger.d('[Activity] endCurrentSession: nothing open');
      return null;
    }

    final closed = current.copyWith(endTime: _nowInMillis);
    await activityDao.addPendingActivity(closed);
    await appPrefs.remove(ActivityRepository.prefsCurrentActivity);
    _logger.d(
      '[Activity] Closed ${_tag(closed)} after ${closed.durationInMillis}ms, '
      'buffered for upload',
    );
    return closed;
  }

  @override
  Future<ActivitySession?> pauseCurrentSession() =>
      _serialized(_pauseCurrentSessionUnlocked);

  Future<ActivitySession?> _pauseCurrentSessionUnlocked() async {
    final closed = await _endCurrentSessionUnlocked();
    if (closed == null) {
      _logger.d('[Activity] Pause: nothing open, nothing stashed');
      return null;
    }

    await appPrefs.setString(
      ActivityRepository.prefsLastActivity,
      jsonEncode(closed.toJson()),
    );
    _logger.d('[Activity] Paused ${_tag(closed)}, stashed for resume');
    return closed;
  }

  @override
  Future<ActivitySession?> resumeLastSession() =>
      _serialized(_resumeLastSessionUnlocked);

  Future<ActivitySession?> _resumeLastSessionUnlocked() async {
    // Something already opened a session since the pause (a screen tracked
    // during startup, say) — that is more current than the stash.
    final current = currentSession;
    if (current != null) {
      await appPrefs.remove(ActivityRepository.prefsLastActivity);
      _logger.d(
        '[Activity] Resume skipped, ${_tag(current)} already open; '
        'stash discarded',
      );
      return current;
    }

    final raw = appPrefs.getString(ActivityRepository.prefsLastActivity);
    if (raw == null || raw.isEmpty) {
      _logger.d('[Activity] Resume: nothing stashed');
      return null;
    }

    ActivitySession last;
    try {
      last = ActivitySession.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (e) {
      _logger.e('[Activity] Dropping unreadable stashed session: $e',
          StackTrace.current);
      await appPrefs.remove(ActivityRepository.prefsLastActivity);
      return null;
    }

    await appPrefs.remove(ActivityRepository.prefsLastActivity);
    _logger.d('[Activity] Resuming ${_tag(last)} as a new session');
    return _startSessionUnlocked(
      name: last.name,
      moduleEnum: last.moduleEnum,
      subModuleEnum: last.subModuleEnum,
      source: last.source,
    );
  }

  @override
  Future<List<ActivitySession>> getPendingActivities() =>
      activityDao.getPendingActivities();

  @override
  Future<VoidResult> sync({bool includeCurrentSession = false}) async {
    final upload = uploader;
    if (upload == null) {
      // Expected in FA One standalone, and in GT's foreground: only the
      // headless background task registers an uploader.
      _logger.w('[Activity] Sync skipped, no uploader registered');
      return const VoidResult.failure(reason: 'No uploader registered.');
    }

    if (includeCurrentSession) {
      await _serialized(_rollOverCurrentSession);
    }

    // Deliberately outside the lock: uploading can be slow, and it only
    // touches pending rows, which it removes by explicit guid.
    final pending = await activityDao.getPendingActivities();
    if (pending.isEmpty) {
      _logger.d('[Activity] Sync: buffer empty, nothing to upload');
      return const VoidResult.success();
    }

    _logger.i('[Activity] Uploading ${pending.length} session(s)...');
    for (final activity in pending) {
      _logger.d('[Activity]   -> ${_tag(activity)}');
    }

    final startedAt = DateTime.now();
    try {
      await upload(pending);
      await activityDao.removePendingActivities(
        pending.map((activity) => activity.guid).toList(),
      );
      final elapsed = DateTime.now().difference(startedAt).inMilliseconds;
      _logger.i(
        '[Activity] Synced ${pending.length} session(s) in ${elapsed}ms, '
        'buffer cleared',
      );
      return const VoidResult.success();
    } catch (e) {
      // Left buffered for the next attempt.
      _logger.e(
        '[Activity] Upload FAILED, kept ${pending.length} session(s) '
        'buffered for the next run: $e',
        StackTrace.current,
      );
      return VoidResult.failure(reason: e.toString());
    }
  }

  @override
  Future<void> clear() => _serialized(() async {
        final dropped = (await activityDao.getPendingActivities()).length;
        await appPrefs.remove(ActivityRepository.prefsCurrentActivity);
        await appPrefs.remove(ActivityRepository.prefsLastActivity);
        await appPrefs.remove(ActivityRepository.prefsAppSession);
        await activityDao.clearPendingActivities();
        _logger.w(
          '[Activity] Cleared all activity state, '
          'discarding $dropped unsynced session(s)',
        );
      });

  Future<void> _saveCurrentSession(ActivitySession session) =>
      appPrefs.setString(
        ActivityRepository.prefsCurrentActivity,
        jsonEncode(session.toJson()),
      );

  /// Closes the open session so it can be shipped, then reopens an identical
  /// one. Without this a user parked on a single screen for hours would report
  /// nothing until they finally navigated away.
  Future<void> _rollOverCurrentSession() async {
    final current = currentSession;
    if (current == null) {
      return;
    }

    _logger.d('[Activity] Rolling over ${_tag(current)} so it can be shipped');
    await _endCurrentSessionUnlocked();
    await _startSessionUnlocked(
      name: current.name,
      moduleEnum: current.moduleEnum,
      subModuleEnum: current.subModuleEnum,
      source: current.source,
    );
  }

  /// Runs [action] after every previously queued action has finished.
  ///
  /// Callers fire tracking without awaiting it (route observers do), and two
  /// apps share this instance, so without a queue two navigations could
  /// interleave their read-modify-write of the current session and lose or
  /// duplicate one.
  ///
  /// Public methods take the lock; the `*Unlocked` variants are what they call
  /// internally, since re-entering would deadlock.
  Future<T> _serialized<T>(Future<T> Function() action) {
    final completer = Completer<T>();
    _lock = _lock.then((_) async {
      try {
        completer.complete(await action());
      } catch (e, s) {
        completer.completeError(e, s);
      }
    });
    return completer.future;
  }
}
