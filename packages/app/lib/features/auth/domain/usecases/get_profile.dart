import 'package:app/core/utils/result.dart';
import 'package:app/features/auth/domain/entities/profile_entity.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';

class GetProfile {
  final AuthRepository _repository;

  GetProfile(this._repository);

  Future<Result<ProfileEntity>> call(String userId) {
    return _repository.getProfile(userId);
  }
}
