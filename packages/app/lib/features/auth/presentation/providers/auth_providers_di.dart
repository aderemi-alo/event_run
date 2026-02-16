import 'package:app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app/features/auth/domain/entities/profile_entity.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/features/auth/domain/usecases/get_profile.dart';
import 'package:app/features/auth/domain/usecases/reset_password.dart';
import 'package:app/features/auth/domain/usecases/sign_in.dart';
import 'package:app/features/auth/domain/usecases/sign_out.dart';
import 'package:app/features/auth/domain/usecases/sign_up.dart';
import 'package:app/features/auth/domain/usecases/update_profile.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ── Infrastructure ──
final supabaseClientProvider = Provider<SupabaseClient>(
  (_) => Supabase.instance.client,
);

final authDatasourceProvider = Provider<AuthRemoteDatasource>(
  (ref) => AuthRemoteDatasource(ref.watch(supabaseClientProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.watch(authDatasourceProvider)),
);

// ── Use Cases ──
final signupUseCaseProvider = Provider<SignupUseCase>(
  (ref) => SignupUseCase(ref.watch(authRepositoryProvider)),
);

final signInUseCaseProvider = Provider<SignIn>(
  (ref) => SignIn(ref.watch(authRepositoryProvider)),
);

final signOutUseCaseProvider = Provider<SignOut>(
  (ref) => SignOut(ref.watch(authRepositoryProvider)),
);

final getProfileUseCaseProvider = Provider<GetProfile>(
  (ref) => GetProfile(ref.watch(authRepositoryProvider)),
);

final updateProfileUseCaseProvider = Provider<UpdateProfile>(
  (ref) => UpdateProfile(ref.watch(authRepositoryProvider)),
);

final resetPasswordUseCaseProvider = Provider<ResetPassword>(
  (ref) => ResetPassword(ref.watch(authRepositoryProvider)),
);

final authNotifierProvider =
    AsyncNotifierProvider<AuthNotifier, ProfileEntity?>(AuthNotifier.new);
