import 'package:fa_flutter_core/fa_flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('checkIfNotEmpty', () {
    test('checkIfNotEmpty should return false when string is null', () {
      final String myString = null;
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
}
