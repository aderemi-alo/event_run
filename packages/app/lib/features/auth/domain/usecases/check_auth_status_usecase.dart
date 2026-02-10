import 'package:event_run/features/auth/domain/entities/vendor.dart';
import 'package:event_run/features/auth/domain/repositories/auth_repository.dart';

/// Use case for checking authentication status
class CheckAuthStatusUseCase {
  CheckAuthStatusUseCase(this._authRepository);

  final AuthRepository _authRepository;

  /// Check if user is authenticated and return user if so
  Future<Vendor?> execute() async {
    final isAuthenticated = await _authRepository.isAuthenticated();

    if (isAuthenticated) {
      return await _authRepository.getCurrentUser();
    }

    return null;
  }

  /// Check if onboarding has been completed
  Future<bool> hasCompletedOnboarding() async {
    return await _authRepository.hasCompletedOnboarding();
  }

  /// Mark onboarding as complete
  Future<void> completeOnboarding() async {
    await _authRepository.completeOnboarding();
  }
}
