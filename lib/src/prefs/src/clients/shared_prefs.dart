import 'package:shared_preferences/shared_preferences.dart';

import '../base/app_prefs.dart';

class SharedAppPrefs implements AppPrefs {
  late SharedPreferences _prefs;

  @override
  Future<void> initialise() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  @override
  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  @override
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  @override
  String? getString(String key) {
    return _prefs.getString(key);
  }

  @override
  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  @override
  Future<void> setBool(String key, bool? value) async {
    if (value == null) {
      _prefs.remove(key);
      return;
    }
    await _prefs.setBool(key, value);
  }

  @override
  Future<void> setDouble(String key, double? value) async {
    if (value == null) {
      _prefs.remove(key);
      return;
    }
    await _prefs.setDouble(key, value);
  }

  @override
  Future<void> setInt(String key, int? value) async {
    if (value == null) {
      _prefs.remove(key);
      return;
    }
    await _prefs.setInt(key, value);
  }

  @override
  Future<void> setString(String key, String? value) async {
    if (value == null) {
      _prefs.remove(key);
      return;
    }
    await _prefs.setString(key, value);
  }

  @override
  Future<void> setStringList(String key, List<String>? value) async {
    if (value == null) {
      _prefs.remove(key);
      return;
    }
    await _prefs.setStringList(key, value);
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }

  @override
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  @override
  Future<void> reload() async {
    await _prefs.reload();
  }

  @override
  Future<Map<String, dynamic>> getMap() async {
    await Future.delayed(const Duration(milliseconds: 0));
    final map = <String, dynamic>{};
    _prefs.getKeys().forEach((e) {
      map.putIfAbsent(e, () => MapEntry(e, _prefs.get(e)));
    });
    return map;
  }
}
