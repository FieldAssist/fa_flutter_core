import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../../../../fa_flutter_core.dart';
import '../base/app_prefs.dart';

class JsonAppPrefs implements AppPrefs {
  final LocalStorage _storage;

  JsonAppPrefs({@required String name}) : _storage = LocalStorage('name');

  @override
  Future<void> initialise() async {
    final result = await _storage.ready;
    if (result != true) {
      throw MyException("Error in initialising json_prefs");
    }
  }

  @override
  bool getBool(String key) {
    return _storage.getItem(key) as bool;
  }

  @override
  double getDouble(String key) {
    return _storage.getItem(key) as double;
  }

  @override
  int getInt(String key) {
    return _storage.getItem(key) as int;
  }

  @override
  String getString(String key) {
    return _storage.getItem(key) as String;
  }

  @override
  List<String> getStringList(String key) {
    return ((_storage.getItem(key) as List) ?? []).cast<String>();
  }

  @override
  Future<void> clear() async {
    await _storage.clear();
  }

  @override
  Future<void> reload() async {
    // TODO: implement reload
  }

  @override
  void remove(String key) {
    _storage.deleteItem(key);
  }

  @override
  void setBool(String key, bool value) {
    _storage.setItem(key, value);
  }

  @override
  void setDouble(String key, double value) {
    _storage.setItem(key, value);
  }

  @override
  void setInt(String key, int value) {
    _storage.setItem(key, value);
  }

  @override
  void setString(String key, String value) {
    _storage.setItem(key, value);
  }

  @override
  void setStringList(String key, List<String> value) {
    _storage.setItem(key, value);
  }

  @override
  Future<Map<String, dynamic>> getMap() {
    return _storage.stream.asBroadcastStream().first;
  }
}
