import 'package:fa_flutter_core/fa_flutter_core.dart';
import 'package:path/path.dart';

class SembastHelperImpl implements SembastHelper {
  late Database _db;

  @override
  Future<void> initializeDatabase(String databaseName) async {
    try {
      if (isWeb) {
        final factory = databaseFactoryWeb;
        _db = await factory.openDatabase(databaseName);
      } else {
        final dir = await getApplicationDocumentsDirectory();
        await dir.create(recursive: true);
        final dbPath = join(dir.path, '$databaseName.db');
        _db = await databaseFactoryIo.openDatabase(dbPath);
      }
    } catch (e, s) {
      throw Exception("Error in initialising sembast_db");
    }
  }

  @override
  Future<int> deletStoreFactory<K, V>(
    StoreRef<K, V> mapStoreFactory,
  ) async {
    final length = await mapStoreFactory.delete(_db);
    return length;
  }

  @override
  Future<void> dropStoreFactory<K, V>(
    StoreRef<K, V> mapStoreFactory,
  ) async {
    await mapStoreFactory.drop(_db);
  }

  @override
  Future<List<RecordSnapshot<K, V>>> find<K, V>(
    StoreRef<K, V> mapStoreFactory, {
    Finder? finder,
  }) async {
    final values = await mapStoreFactory.find(_db, finder: finder);
    return values;
  }

  @override
  Future<RecordSnapshot<K, V>?> findFirst<K, V>(
    StoreRef<K, V> mapStoreFactory, {
    Finder? finder,
  }) async {
    final firstValue = await mapStoreFactory.findFirst(_db, finder: finder);
    return firstValue;
  }

  @override
  Future<V?> get<K, V>(
    RecordRef<K, V> recordRef,
  ) async {
    final value = await recordRef.get(_db);
    return value;
  }

  @override
  Future<V> put<K, V>(
    RecordRef<K, V> recordRef,
    V value, {
    bool? merge,
  }) async {
    final updatedValue = await recordRef.put(_db, value, merge: merge);
    return updatedValue;
  }

  @override
  RecordRef<K, V> record<K, V>(StoreRef<K, V> mapStoreFactory, K key) {
    return mapStoreFactory.record(key);
  }

  @override
  Future<K?> delete<K, V>(RecordRef<K, V> recordRef) async {
    final key = await recordRef.delete(_db);
    return key;
  }

  @override
  RecordsRef<K, V> records<K, V>(
    StoreRef<K, V> mapStoreFactory,
    Iterable<K> keys,
  ) {
    return mapStoreFactory.records(keys);
  }

  @override
  Future<List<V>> putList<K, V>(
    RecordsRef<K, V> recordsRef,
    List<V> values, {
    bool? merge,
  }) async {
    final updatedValues = await recordsRef.put(_db, values, merge: merge);
    return updatedValues;
  }

  @override
  Future<List<V?>> getList<K, V>(
    RecordsRef<K, V> recordsRef,
  ) async {
    final values = await recordsRef.get(_db);
    return values;
  }

  @override
  Future<List<K?>> deleteList<K, V>(RecordsRef<K, V> recordsRef) async {
    final values = await recordsRef.delete(_db);
    return values;
  }
}
