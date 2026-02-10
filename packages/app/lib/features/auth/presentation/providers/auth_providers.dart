import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:event_run/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:event_run/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:event_run/features/auth/domain/repositories/auth_repository.dart';
import 'package:event_run/features/auth/domain/usecases/sign_in.dart';
import 'package:event_run/features/auth/domain/usecases/sign_up.dart';
import 'package:event_run/features/auth/domain/usecases/sign_out.dart';
import 'package:event_run/features/auth/domain/usecases/get_profile.dart';
import 'package:event_run/features/auth/domain/usecases/update_profile.dart';
import 'package:event_run/features/auth/domain/usecases/reset_password.dart';
import 'package:event_run/features/auth/domain/entities/profile_entity.dart';

// Datasource
final authRemoteDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  return AuthRemoteDatasourceImpl(Supabase.instance.client);
});

// Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(authRemoteDatasourceProvider));
});

// Usecases
final signInUsecaseProvider = Provider<SignIn>((ref) {
  return SignIn(ref.watch(authRepositoryProvider));
});

final signUpUsecaseProvider = Provider<SignUp>((ref) {
  return SignUp(ref.watch(authRepositoryProvider));
});

final signOutUsecaseProvider = Provider<SignOut>((ref) {
  return SignOut(ref.watch(authRepositoryProvider));
});

final getProfileUsecaseProvider = Provider<GetProfile>((ref) {
  return GetProfile(ref.watch(authRepositoryProvider));
});

final updateProfileUsecaseProvider = Provider<UpdateProfile>((ref) {
  return UpdateProfile(ref.watch(authRepositoryProvider));
});

final resetPasswordUsecaseProvider = Provider<ResetPassword>((ref) {
  return ResetPassword(ref.watch(authRepositoryProvider));
});

// Async state providers
final profileProvider =
    FutureProvider.autoDispose.family<ProfileEntity?, String>((ref, userId) {
  return ref.watch(getProfileUsecaseProvider).call(userId);
});
