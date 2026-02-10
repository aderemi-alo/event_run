import 'package:event_run/features/auth/domain/entities/profile_entity.dart';
import 'package:event_run/features/auth/domain/repositories/auth_repository.dart';

class GetProfile {
  final AuthRepository _repository;

  GetProfile(this._repository);

  Future<ProfileEntity?> call(String userId) {
    return _repository.getProfile(userId);
  }
}
