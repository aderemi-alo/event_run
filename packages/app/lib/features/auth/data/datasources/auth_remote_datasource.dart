import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:event_run/core/constants/supabase_constants.dart';
import 'package:event_run/core/error/exceptions.dart';
import 'package:event_run/features/auth/data/models/profile_model.dart';

abstract class AuthRemoteDatasource {
  Future<void> signIn({required String email, required String password});
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  });
  Future<void> signOut();
  Future<ProfileModel?> getProfile(String userId);
  Future<ProfileModel> updateProfile({required ProfileModel profile});
  Future<void> resetPassword({required String email});
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final SupabaseClient _client;

  AuthRemoteDatasourceImpl(this._client);

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      await _client.auth.signInWithPassword(email: email, password: password);
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      await _client.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<ProfileModel?> getProfile(String userId) async {
    try {
      final response = await _client
          .from(SupabaseConstants.profilesTable)
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (response == null) return null;
      return ProfileModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ProfileModel> updateProfile({required ProfileModel profile}) async {
    try {
      final response = await _client
          .from(SupabaseConstants.profilesTable)
          .update(profile.toJson())
          .eq('id', profile.id)
          .select()
          .single();

      return ProfileModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
