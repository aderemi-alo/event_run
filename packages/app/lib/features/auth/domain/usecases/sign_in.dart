import 'package:app/core/utils/result.dart';
import 'package:app/features/auth/domain/entities/profile_entity.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';

class SignIn {
  final AuthRepository _repository;

  SignIn(this._repository);

  Future<Result<ProfileEntity>> call({
    required String email,
    required String password,
  }) {
    return _repository.signIn(email: email, password: password);
  }
}
