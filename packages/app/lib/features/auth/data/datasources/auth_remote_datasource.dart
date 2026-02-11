import 'package:app/core/error/exceptions.dart';
import 'package:app/features/auth/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Concrete datasource that wraps Supabase Auth calls.
///
/// Throws [ServerException] or [AppAuthException] on errors.
class AuthRemoteDatasource {
  final SupabaseClient _client;

  const AuthRemoteDatasource(this._client);

  Future<ProfileModel> signUp({
    required String email,
    required String password,
    required Map<String, dynamic> metadata,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: metadata,
      );

      if (response.user == null) {
        throw const AppAuthException(
          message: 'Sign up failed: No user returned',
        );
      }

      // Fetch profile from profiles table
      return await getProfile(response.user!.id);
    } on AuthException catch (e) {
      throw AppAuthException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<ProfileModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const AppAuthException(
          message: 'Sign in failed: No user returned',
        );
      }

      // Fetch profile from profiles table
      return await getProfile(response.user!.id);
    } on AuthException catch (e) {
      throw AppAuthException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } on AuthException catch (e) {
      throw AppAuthException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<ProfileModel> getProfile(String userId) async {
    try {
      final response = await _client
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      return ProfileModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<ProfileModel> updateProfile({required ProfileModel profile}) async {
    try {
      final response = await _client
          .from('profiles')
          .update({
            'full_name': profile.fullName,
            'avatar_url': profile.avatarUrl,
          })
          .eq('id', profile.id)
          .select()
          .single();

      return ProfileModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw AppAuthException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> deleteAccount() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) {
        throw const AppAuthException(message: 'No user logged in');
      }

      // Delete profile first (due to foreign key constraint)
      await _client.from('profiles').delete().eq('id', user.id);

      // Then delete auth user
      await _client.auth.admin.deleteUser(user.id);
    } on AuthException catch (e) {
      throw AppAuthException(message: e.message);
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
