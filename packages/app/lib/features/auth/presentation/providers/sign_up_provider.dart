import 'package:app/core/utils/result.dart';
import 'package:app/features/auth/domain/entities/profile_entity.dart';
import 'package:app/features/auth/domain/entities/signup_params.dart';
import 'package:app/features/auth/presentation/providers/providers_di.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Signup screen state — uses [AsyncNotifier] so the UI can
/// react to loading / success / error with minimal boilerplate.
final signupProvider =
    AutoDisposeAsyncNotifierProvider<SignupNotifier, ProfileEntity?>(
      SignupNotifier.new,
    );

class SignupNotifier extends AutoDisposeAsyncNotifier<ProfileEntity?> {
  @override
  Future<ProfileEntity?> build() async => null;

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
}
