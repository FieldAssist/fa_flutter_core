abstract class AppPrefs {
  Future<void> initialise();

  // Getters
  bool? getBool(String key);

  int? getInt(String key);

  double? getDouble(String key);

  String? getString(String key);

  List<String>? getStringList(String key);

  //  Setters
  Future<void> setBool(String key, bool? value);

  Future<void> setInt(String key, int? value);

  Future<void> setDouble(String key, double? value);

  Future<void> setString(String key, String? value);

  Future<void> setStringList(String key, List<String>? value);

  // MISC
  Future<Map<String, dynamic>> getMap();

  Future<void> reload();

  Future<void> remove(String key);

  Future<void> clear();
}
