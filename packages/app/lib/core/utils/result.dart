import 'package:app/core/error/failures.dart';

/// A generic Result type for handling success and failure states.
///
/// This replaces throwing exceptions in the domain layer and provides
/// a type-safe way to handle errors.
sealed class Result<T> {
  const Result();
}

/// Represents a successful result containing data of type [T].
final class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

/// Represents a failed result containing a [Failure].
final class Error<T> extends Result<T> {
  final Failure failure;
  const Error(this.failure);
}

/// Extension methods for Result to make it easier to work with.
extension ResultExtension<T> on Result<T> {
  /// Returns true if this is a Success.
  bool get isSuccess => this is Success<T>;

  /// Returns true if this is an Error.
  bool get isError => this is Error<T>;

  /// Returns the data if Success, otherwise null.
  T? get dataOrNull => this is Success<T> ? (this as Success<T>).data : null;

  /// Returns the failure if Error, otherwise null.
  Failure? get failureOrNull =>
      this is Error<T> ? (this as Error<T>).failure : null;

  /// Executes [onSuccess] if this is a Success, otherwise [onError].
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(Failure failure) onError,
  }) {
    return switch (this) {
      Success(data: final data) => onSuccess(data),
      Error(failure: final failure) => onError(failure),
    };
  }
}
