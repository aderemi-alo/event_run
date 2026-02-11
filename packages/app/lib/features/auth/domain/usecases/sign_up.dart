import 'package:app/core/utils/phone_utils.dart';
import 'package:app/core/utils/result.dart';
import 'package:app/features/auth/domain/entities/profile_entity.dart';
import 'package:app/features/auth/domain/entities/signup_params.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';

/// Orchestrates the signup flow:
///   1. Normalises the phone number to E.164 (+234XXXXXXXXXX)
///   2. Delegates to [AuthRepository] for the actual Supabase call
///
/// Business rules live here, not in the UI or datasource.
class SignupUseCase {
  final AuthRepository _repository;

  const SignupUseCase(this._repository);

  Future<Result<ProfileEntity>> call(SignupParams params) async {
    // ── Normalise phone ──
    final normalisedPhone = PhoneUtils.normalise(params.phone);

    // ── Delegate to repository ──
    return _repository.signUp(
      email: params.email.trim(),
      password: params.password,
      metadata: {
        'full_name': params.fullName.trim(),
        // 'phone': normalisedPhone,
      },
    );
  }
}
