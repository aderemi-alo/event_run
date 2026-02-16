import 'package:app/core/uscase/base_usecase.dart';
import 'package:app/core/utils/result.dart';
import 'package:app/features/auth/domain/entities/profile_entity.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';

class SignIn implements UseCase<ProfileEntity, SignInParams> {
  final AuthRepository _repository;

  SignIn(this._repository);

  @override
  Future<Result<ProfileEntity>> call({required SignInParams params}) {
    return _repository.signIn(email: params.email, password: params.password);
  }
}

typedef SignInParams = ({String email, String password});
