import 'package:event_run/features/auth/domain/entities/vendor.dart';

/// Abstract repository for authentication
abstract class AuthRepository {
  /// Check if user is authenticated
  Future<bool> isAuthenticated();

  /// Check if user has completed onboarding
  Future<bool> hasCompletedOnboarding();

  /// Mark onboarding as complete
  Future<void> completeOnboarding();

  /// Get current authenticated user
  Future<Vendor?> getCurrentUser();

  /// Login with email and password
  Future<Vendor> login(String email, String password);

  /// Signup with vendor data
  Future<Vendor> signup(Vendor vendor, String password);

  /// Logout current user
  Future<void> logout();
}
