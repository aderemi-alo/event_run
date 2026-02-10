import 'package:event_run/features/auth/domain/repositories/auth_repository.dart';

class SignUp {
  final AuthRepository _repository;

  SignUp(this._repository);

  Future<void> call({
    required String email,
    required String password,
    required String fullName,
  }) {
    return _repository.signUp(
      email: email,
      password: password,
      fullName: fullName,
    );
  }
}
