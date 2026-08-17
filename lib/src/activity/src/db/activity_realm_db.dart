import 'package:realm/realm.dart';

abstract class ActivityRealmDb {
  Future<void> initialise(String databaseName);

  Realm get realm;

  Future<void> close();
}
