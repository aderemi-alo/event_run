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
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: metadata,
    );

    if (response.user == null) {
      throw const AppAuthException(message: 'Sign up failed: No user returned');
    }

    // Fetch profile from profiles table
    return await getProfile(response.user!.id);
  }

  Future<ProfileModel> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user;

    if (user == null) {
      throw const AppAuthException(message: 'Sign in failed: No user returned');
    }

    // Fetch profile from profiles table
    return await getProfile(user.id);
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<ProfileModel> getProfile(String userId) async {
    final response = await _client
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();

    return ProfileModel.fromJson(response);
  }

  Future<ProfileModel> updateProfile({required ProfileModel profile}) async {
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
  }

  Future<void> resetPassword({required String email}) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  Future<void> deleteAccount() async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw const AuthException('No user logged in');
    }

    // Delete profile first (due to foreign key constraint)
    await _client.from('profiles').delete().eq('id', user.id);

    // Then delete auth user
    await _client.auth.admin.deleteUser(user.id);
  }
}
