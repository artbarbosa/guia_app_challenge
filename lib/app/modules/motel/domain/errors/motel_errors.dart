import '../../../../core/shared/errors/base_error.dart';

class MotelError extends BaseError {
  MotelError({
    required String message,
    dynamic exception,
    StackTrace? stackTrace,
  }) : super(
          message,
          exception: exception,
          stackTrace: stackTrace,
        );
}

class MotelDatasourceError extends MotelError {
  MotelDatasourceError({
    required super.message,
    super.exception,
    super.stackTrace,
  });
}

class MotelRepositoryError extends MotelError {
  MotelRepositoryError({
    required super.message,
    super.exception,
    super.stackTrace,
  });
}
