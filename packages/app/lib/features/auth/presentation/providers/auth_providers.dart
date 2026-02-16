import 'package:app/core/utils/result.dart';
import 'package:app/features/auth/domain/entities/profile_entity.dart';
import 'package:app/features/auth/domain/entities/signup_params.dart';
import 'package:app/features/auth/domain/usecases/sign_in.dart';
import 'package:app/features/auth/presentation/providers/auth_providers_di.dart';
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

class AuthNotifier extends AsyncNotifier<ProfileEntity?> {
  @override
  Future<ProfileEntity?> build() async => null;

  /// Sign up with email and password.
  Future<void> signup(SignupParams params) async {
    state = const AsyncLoading();

    final nextState = await AsyncValue.guard(() async {
      final useCase = ref.read(signupUseCaseProvider);
      final result = await useCase.call(params: params);

      return result.fold(
        onSuccess: (profile) => profile,
        onError: (failure) => throw Exception(failure.message),
      );
    });

    if (!ref.mounted) return;
    state = nextState;
  }

  /// Sign in with email and password.
  Future<void> signIn(SignInParams params) async {
    state = const AsyncLoading();

    final nextState = await AsyncValue.guard(() async {
      final useCase = ref.read(signInUseCaseProvider);
      final result = await useCase.call(params: params);

      return result.fold(
        onSuccess: (profile) => profile,
        onError: (failure) => throw Exception(failure.message),
      );
    });

    if (!ref.mounted) return;
    state = nextState;
  }

  /// Sign out the current user.
  Future<void> signOut() async {
    state = const AsyncLoading();

    final nextState = await AsyncValue.guard(() async {
      final useCase = ref.read(signOutUseCaseProvider);
      final result = await useCase.call();

      return result.fold(
        onSuccess: (_) => null,
        onError: (failure) => throw Exception(failure.message),
      );
    });

    if (!ref.mounted) return;
    state = nextState;
  }

  /// Get profile for a specific user ID.
  Future<void> getProfile(String userId) async {
    state = const AsyncLoading();

    final nextState = await AsyncValue.guard(() async {
      final useCase = ref.read(getProfileUseCaseProvider);
      final result = await useCase.call(userId);

      return result.fold(
        onSuccess: (profile) => profile,
        onError: (failure) => throw Exception(failure.message),
      );
    });

    if (!ref.mounted) return;
    state = nextState;
  }

  /// Update the current user's profile.
  Future<void> updateProfile(ProfileEntity profile) async {
    state = const AsyncLoading();

    final nextState = await AsyncValue.guard(() async {
      final useCase = ref.read(updateProfileUseCaseProvider);
      final result = await useCase.call(profile: profile);

      return result.fold(
        onSuccess: (updatedProfile) => updatedProfile,
        onError: (failure) => throw Exception(failure.message),
      );
    });

    if (!ref.mounted) return;
    state = nextState;
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
