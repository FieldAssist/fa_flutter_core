import 'package:fa_flutter_core/src/void_result/void_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VoidResult', () {
    test('VoidResult should call success when success', () {
      final result = VoidResult.success();
      result.when(success: () {
        expect(true, true);
      }, failure: (reason) {
        neverCalled();
      });
    });

    test('VoidResult should display correct reason when failed', () {
      final result = VoidResult.failure(reason: 'My Reason');
      result.when(success: () {
        neverCalled();
      }, failure: (reason) {
        expect(reason, 'My Reason');
      });
    });
  });
}
