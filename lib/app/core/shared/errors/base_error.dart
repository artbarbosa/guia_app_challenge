class BaseError implements Exception {
  final String message;
  final dynamic exception;
  final StackTrace? stackTrace;

  BaseError(
    this.message, {
    this.exception,
    this.stackTrace,
  });

  @override
  String toString() {
    return 'BaseError: $message ${exception != null ? '| Exception: $exception' : ''}';
  }
}
