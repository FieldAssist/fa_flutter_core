import 'dart:io';

import 'package:realm/realm.dart';

import '../../../../fa_flutter_core.dart';

final AppLog _logger = AppLogImpl(packageName: 'fa_activity');

class ActivityRealmDbImpl implements ActivityRealmDb {
  static const schemaVersion = 1;

  Realm? _realm;

  @override
  Realm get realm {
    final realm = _realm;
    if (realm == null || realm.isClosed) {
      throw StateError(
        'ActivityRealmDb.initialise() must be awaited before use.',
      );
    }
    return realm;
  }

  @override
  Future<void> initialise(String databaseName) async {
    final existing = _realm;
    if (existing != null && !existing.isClosed) {
      return;
    }

    final config = Configuration.local(
      [ActivitySessionEntity.schema],
      path: await _databasePath(databaseName),
      schemaVersion: schemaVersion,
      shouldDeleteIfMigrationNeeded: true,
    );

    _realm = Realm(config);
    _logger.d('[ActivityDao] Realm opened at ${config.path}');
  }

  @override
  Future<void> close() async {
    final realm = _realm;
    if (realm == null || realm.isClosed) {
      return;
    }
    realm.close();
    _realm = null;
    _logger.d('[ActivityDao] Realm closed');
  }

  Future<String> _databasePath(String databaseName) async {
    final fileName = '$databaseName.realm';
    if (!Platform.isAndroid && !Platform.isIOS) {
      return fileName;
    }
    final directory = await getApplicationDocumentsDirectory();
    await directory.create(recursive: true);
    return '${directory.path}${Platform.pathSeparator}$fileName';
  }
}
