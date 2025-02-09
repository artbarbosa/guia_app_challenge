import '../errors/base_error.dart';

sealed class Result<S> {
  const Result();

  T when<T>({
    required T Function(S value) success,
    required T Function(BaseError error) failure,
  }) {
    if (this is Success<S>) {
      return success((this as Success<S>).value);
    } else if (this is Failure<S>) {
      return failure((this as Failure<S>).error);
    }
    throw StateError("Invalid Result state.");
  }

  Result<T> map<T>(T Function(S value) transform) {
    if (this is Success<S>) {
      return Success(transform((this as Success<S>).value));
    } else {
      return Failure((this as Failure<S>).error);
    }
  }
}

final class Success<S> extends Result<S> {
  final S value;

  const Success(this.value);
}

final class Failure<S> extends Result<S> {
  final BaseError error;

  const Failure(this.error);
}
