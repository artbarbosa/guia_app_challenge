import 'package:app_challenge/app/modules/motel/domain/errors/motel_errors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MotelError Tests', () {
    test('Should create a MotelError instance correctly', () {
      final error = MotelError(
        message: 'Test error',
        exception: Exception('Inner exception'),
        stackTrace: StackTrace.current,
      );

      expect(error, isA<MotelError>());
      expect(error.message, 'Test error');
      expect(error.exception, isA<Exception>());
      expect(error.toString(), contains('Test error'));
    });

    test('Should create a MotelDatasourceError instance correctly', () {
      final error = MotelDatasourceError(
        message: 'Datasource error',
        exception: Exception('Datasource exception'),
        stackTrace: StackTrace.current,
      );

      expect(error, isA<MotelDatasourceError>());
      expect(error, isA<MotelError>());
      expect(error.message, 'Datasource error');
      expect(error.exception, isA<Exception>());
      expect(error.toString(), contains('Datasource error'));
    });

    test('Should create a MotelRepositoryError instance correctly', () {
      final error = MotelRepositoryError(
        message: 'Repository error',
        exception: Exception('Repository exception'),
        stackTrace: StackTrace.current,
      );

      expect(error, isA<MotelRepositoryError>());
      expect(error, isA<MotelError>());
      expect(error.message, 'Repository error');
      expect(error.exception, isA<Exception>());
      expect(error.toString(), contains('Repository error'));
    });

    test('BaseError should include message and exception in toString()', () {
      final error = MotelError(
        message: 'Custom error',
        exception: Exception('Inner error'),
      );

      final errorString = error.toString();
      expect(errorString, contains('BaseError: Custom error'));
      expect(errorString, contains('Exception: Inner error'));
    });

    test('BaseError should return only message if exception is null', () {
      final error = MotelError(message: 'Error without exception');

      final errorString = error.toString();
      expect(errorString, contains('BaseError: Error without exception'));
      expect(errorString, isNot(contains('Exception:')));
    });
  });
}
