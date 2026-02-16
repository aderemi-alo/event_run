import 'package:app/core/utils/result.dart';

/// A standard interface for all Use Cases.
/// [ResultType] is the return type of the success data.
/// [Params] is the type of the parameters passed to the use case.
abstract interface class UseCase<T, P> {
  Future<Result<T>> call({required P params});
}

/// A helper class for Use Cases that don't need any parameters.
class NoParams {
  const NoParams();
}
