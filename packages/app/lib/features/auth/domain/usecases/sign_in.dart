import 'package:event_run/features/auth/domain/repositories/auth_repository.dart';

class SignIn {
  final AuthRepository _repository;

  SignIn(this._repository);

  Future<void> call({required String email, required String password}) {
    return _repository.signIn(email: email, password: password);
  }
}
