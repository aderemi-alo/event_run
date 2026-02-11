import 'package:app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:app/features/auth/data/models/profile_model.dart';
import 'package:app/features/auth/domain/entities/profile_entity.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Future<void> signIn({required String email, required String password}) {
    return _datasource.signIn(email: email, password: password);
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) {
    return _datasource.signUp(
      email: email,
      password: password,
      fullName: fullName,
    );
  }

  @override
  Future<void> signOut() {
    return _datasource.signOut();
  }

  @override
  Future<ProfileEntity?> getProfile(String userId) {
    return _datasource.getProfile(userId);
  }

  @override
  Future<ProfileEntity> updateProfile({required ProfileEntity profile}) {
    final model = ProfileModel(
      id: profile.id,
      email: profile.email,
      fullName: profile.fullName,
      avatarUrl: profile.avatarUrl,
      createdAt: profile.createdAt,
    );
    return _datasource.updateProfile(profile: model);
  }

  @override
  Future<void> resetPassword({required String email}) {
    return _datasource.resetPassword(email: email);
  }
}
