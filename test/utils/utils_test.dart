import 'package:fa_dart_core/fa_dart_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('checkIfNotEmpty', () {
    test('checkIfNotEmpty should return false when string is null', () {
      final String? myString = null;
      final result = checkIfNotEmpty(myString);
      expect(result, false);
    });
    test('checkIfNotEmpty should return false when string is empty', () {
      final String myString = '';
      final result = checkIfNotEmpty(myString);
      expect(result, false);
    });
    test("checkIfNotEmpty should return false when string is 'null'", () {
      final String myString = 'null';
      final result = checkIfNotEmpty(myString);
      expect(result, false);
    });
    test("checkIfNotEmpty should return true when string is not null/empty",
        () {
      final String myString = "Hello";
      final result = checkIfNotEmpty(myString);
      expect(result, true);
    });
  });

  group('checkIfListIsNotEmpty', () {
    test('checkIfListIsNotEmpty should return false when the list is null', () {
      final List? myList = null;
      final result = checkIfListIsNotEmpty(myList);
      expect(result, false);
    });

    test('checkIfListIsNotEmpty should return false when the list is empty',
        () {
      final List myList = [];
      final result = checkIfListIsNotEmpty(myList);
      expect(result, false);
    });

    test(
        'checkIfListIsNotEmpty should return true when the list is not null/empty',
        () {
      final List<int> myList = <int>[1];
      final result = checkIfListIsNotEmpty(myList);
      expect(result, true);
    });
  });
}
