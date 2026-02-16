import 'package:app/core/uscase/base_usecase.dart';
import 'package:app/core/utils/phone_utils.dart';
import 'package:app/core/utils/result.dart';
import 'package:app/features/auth/domain/entities/profile_entity.dart';
import 'package:app/features/auth/domain/entities/signup_params.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase implements UseCase<ProfileEntity, SignupParams> {
  final AuthRepository _repository;

  const SignupUseCase(this._repository);

  @override
  Future<Result<ProfileEntity>> call({required SignupParams params}) async {
    final normalisedPhone = PhoneUtils.normalise(params.phone);

    return _repository.signUp(
      email: params.email.trim(),
      password: params.password,
      metadata: {'full_name': params.fullName.trim(), 'phone': normalisedPhone},
    );
  }
}
