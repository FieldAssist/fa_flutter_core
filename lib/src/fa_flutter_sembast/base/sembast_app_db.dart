import '../../../fa_flutter_core.dart';

abstract class SembastHelper {
  /// Intialize Database.
  /// Open a new or existing database.
  Future<void> initializeDatabase(String databaseName);

  //------------ StoreFactory Functions -------------

  /// Find multiple records.
  /// Returns an empty array if none found.
  Future<List<RecordSnapshot<K, V>>> find<K, V>(
    StoreRef<K, V> mapStoreFactory, {
    Finder? finder,
  });

  /// Find a single record.
  ///
  /// Returns null if not found.
  Future<RecordSnapshot<K, V>?> findFirst<K, V>(
    StoreRef<K, V> mapStoreFactory, {
    Finder? finder,
  });

  /// Create a record reference.
  ///
  /// Key cannot be null.
  RecordRef<K, V> record<K, V>(
    StoreRef<K, V> mapStoreFactory,
    K key,
  );

  /// Create a reference to multiple records
  ///
  RecordsRef<K, V> records<K, V>(
    StoreRef<K, V> mapStoreFactory,
    Iterable<K> keys,
  );

  /// Delete records matching a given finder.
  ///
  /// Return the count updated. Delete all if no finder
  Future<int> deletStoreFactory<K, V>(StoreRef<K, V> mapStoreFactory);

  /// Delete the store and its content
  Future<void> dropStoreFactory<K, V>(
    StoreRef<K, V> mapStoreFactory,
  );

  //------------ Record Functions ------------

  /// Save a record, create if needed.
  ///
  /// if [merge] is true and the field exists, data is merged
  ///
  /// Returns the updated value.
  Future<V> put<K, V>(
    RecordRef<K, V> recordRef,
    V value, {
    bool? merge,
  });

  /// Get a record value from the database.
  Future<V?> get<K, V>(RecordRef<K, V> recordRef);

  /// Delete the record. Returns the key if deleted, null if not found.
  Future<K?> delete<K, V>(RecordRef<K, V> recordRef);

  //------------Records Functions ------------

  /// Save multiple records, creating the one needed.
  ///
  /// if [merge] is true and the field exists, data is merged.
  ///
  /// The list of [values] must match the list of keys.
  ///
  /// Returns the updated values.
  Future<List<V>> putList<K, V>(
    RecordsRef<K, V> recordsRef,
    List<V> values, {
    bool? merge,
  });

  /// Get all records values
  Future<List<V?>> getList<K, V>(RecordsRef<K, V> recordsRef);

  /// Delete records
  Future<List<K?>> deleteList<K, V>(RecordsRef<K, V> recordsRef);

  /// Get the database instance.
  @Deprecated("Temporary fix to get the database instance.")
  Database getDb();
}
