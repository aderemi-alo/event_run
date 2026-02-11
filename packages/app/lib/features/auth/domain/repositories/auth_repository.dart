import 'package:app/core/utils/result.dart';
import 'package:app/features/auth/domain/entities/profile_entity.dart';

/// Repository interface for authentication operations.
///
/// All methods return [Result] to handle success/failure states
/// without throwing exceptions.
abstract class AuthRepository {
  /// Signs up a new user with email and password.
  Future<Result<ProfileEntity>> signUp({
    required String email,
    required String password,
    required Map<String, dynamic> metadata,
  });

  /// Signs in with email & password.
  Future<Result<ProfileEntity>> signIn({
    required String email,
    required String password,
  });

  /// Signs the current user out.
  Future<Result<void>> signOut();

  /// Updates the user's profile.
  Future<Result<ProfileEntity>> updateProfile({required ProfileEntity profile});

  /// Gets the profile for a given user ID.
  Future<Result<ProfileEntity>> getProfile(String userId);

  /// Sends a password reset email.
  Future<Result<void>> resetPassword({required String email});

  /// Deletes the current user's account.
  Future<Result<void>> deleteAccount();
}
