import 'package:app/core/utils/result.dart';
import 'package:app/features/auth/domain/entities/profile_entity.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';

class UpdateProfile {
  final AuthRepository _repository;

  UpdateProfile(this._repository);

  Future<Result<ProfileEntity>> call({required ProfileEntity profile}) {
    return _repository.updateProfile(profile: profile);
  }
}
