import 'package:app/core/utils/result.dart';
import 'package:app/features/auth/domain/entities/profile_entity.dart';
import 'package:app/features/auth/domain/entities/signup_params.dart';
import 'package:app/features/auth/presentation/providers/providers_di.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Comprehensive auth provider that manages all authentication operations.
///
/// Provides methods for:
/// - Sign up
/// - Sign in
/// - Sign out
/// - Get profile
/// - Update profile
/// - Reset password
final authProvider =
    AutoDisposeAsyncNotifierProvider<AuthNotifier, ProfileEntity?>(
      AuthNotifier.new,
    );

class AuthNotifier extends AutoDisposeAsyncNotifier<ProfileEntity?> {
  @override
  Future<ProfileEntity?> build() async => null;

  /// Sign up with email and password.
  Future<void> signup(SignupParams params) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final useCase = ref.read(signupUseCaseProvider);
      final result = await useCase.call(params);

      return result.fold(
        onSuccess: (profile) => profile,
        onError: (failure) => throw Exception(failure.message),
      );
    });
  }

  /// Sign in with email and password.
  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final useCase = ref.read(signInUseCaseProvider);
      final result = await useCase.call(email: email, password: password);

      return result.fold(
        onSuccess: (profile) => profile,
        onError: (failure) => throw Exception(failure.message),
      );
    });
  }

  /// Sign out the current user.
  Future<void> signOut() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final useCase = ref.read(signOutUseCaseProvider);
      final result = await useCase.call();

      return result.fold(
        onSuccess: (_) => null,
        onError: (failure) => throw Exception(failure.message),
      );
    });
  }

  /// Get profile for a specific user ID.
  Future<void> getProfile(String userId) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final useCase = ref.read(getProfileUseCaseProvider);
      final result = await useCase.call(userId);

      return result.fold(
        onSuccess: (profile) => profile,
        onError: (failure) => throw Exception(failure.message),
      );
    });
  }

  /// Update the current user's profile.
  Future<void> updateProfile(ProfileEntity profile) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final useCase = ref.read(updateProfileUseCaseProvider);
      final result = await useCase.call(profile: profile);

      return result.fold(
        onSuccess: (updatedProfile) => updatedProfile,
        onError: (failure) => throw Exception(failure.message),
      );
    });
  }

  /// Send password reset email.
  Future<void> resetPassword(String email) async {
    final useCase = ref.read(resetPasswordUseCaseProvider);
    final result = await useCase.call(email: email);

    result.fold(
      onSuccess: (_) => null,
      onError: (failure) => throw Exception(failure.message),
    );
  }
}
