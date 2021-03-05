bool checkIfNotEmpty(String? value) {
  return value != null && value.isNotEmpty && value != "null";
}

bool checkIfListIsNotEmpty(List? list) {
  return list != null && list.isNotEmpty;
}

bool ifContainsKeyAndNotEmpty(Map map, String key) {
  assert(map != null && key != null);
  return map.containsKey(key) &&
      map[key] != null &&
      (map[key] as Map).isNotEmpty;
}
