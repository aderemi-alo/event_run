import 'package:event_run/features/auth/domain/entities/profile_entity.dart';

abstract class AuthRepository {
  Future<void> signIn({required String email, required String password});
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  });
  Future<void> signOut();
  Future<ProfileEntity?> getProfile(String userId);
  Future<ProfileEntity> updateProfile({required ProfileEntity profile});
  Future<void> resetPassword({required String email});
}
