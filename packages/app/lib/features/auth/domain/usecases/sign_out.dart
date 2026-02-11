import 'package:app/core/utils/result.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';

class SignOut {
  final AuthRepository _repository;

  SignOut(this._repository);

  Future<Result<void>> call() {
    return _repository.signOut();
  }
}
