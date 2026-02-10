import 'package:event_run/features/auth/domain/repositories/auth_repository.dart';

/// Use case for logging out the current user
class LogoutUseCase {
  LogoutUseCase(this._authRepository);

  final AuthRepository _authRepository;

  /// Execute logout
  Future<void> execute() async {
    await _authRepository.logout();
  }
}
