import 'package:app_challenge/app/core/shared/errors/base_error.dart';
import 'package:app_challenge/app/core/shared/result_wrapper/result_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Result Tests', () {
    test('Success should return the correct value when using when()', () {
      const result = Success<int>(42);

      final output = result.when(
        success: (value) => 'Success: $value',
        failure: (error) => 'Failure: ${error.message}',
      );

      expect(output, 'Success: 42');
    });

    test('Failure should return the correct error when using when()', () {
      final error = BaseError('Something went wrong');
      final result = Failure<int>(error);

      final output = result.when(
        success: (value) => 'Success: $value',
        failure: (error) => 'Failure: ${error.message}',
      );

      expect(output, 'Failure: Something went wrong');
    });

    test('map() should transform the value in Success', () {
      const result = Success<int>(10);
      final mappedResult = result.map((value) => value * 2);

      expect(mappedResult, isA<Success<int>>());
      expect((mappedResult as Success).value, 20);
    });

    test('map() should maintain the error in Failure', () {
      final error = BaseError('Error occurred');
      final result = Failure<int>(error);
      final mappedResult = result.map((value) => value * 2);

      expect(mappedResult, isA<Failure<int>>());
      expect((mappedResult as Failure).error.message, 'Error occurred');
    });
  });
}
