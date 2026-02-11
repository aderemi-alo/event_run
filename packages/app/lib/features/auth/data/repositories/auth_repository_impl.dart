import 'package:app/core/error/exceptions.dart';
import 'package:app/core/error/failures.dart';
import 'package:app/core/utils/result.dart';
import 'package:app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:app/features/auth/data/models/profile_model.dart';
import 'package:app/features/auth/domain/entities/profile_entity.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';

/// Implementation of [AuthRepository] that uses [AuthRemoteDatasource].
///
/// Catches exceptions from the datasource and converts them to [Failure]s
/// wrapped in [Result].
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Future<Result<ProfileEntity>> signUp({
    required String email,
    required String password,
    required Map<String, dynamic> metadata,
  }) async {
    try {
      final profile = await _datasource.signUp(
        email: email,
        password: password,
        metadata: metadata,
      );
      return Success(profile);
    } on AppAuthException catch (e) {
      return Error(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<ProfileEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final profile = await _datasource.signIn(
        email: email,
        password: password,
      );
      return Success(profile);
    } on AppAuthException catch (e) {
      return Error(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await _datasource.signOut();
      return const Success(null);
    } on AppAuthException catch (e) {
      return Error(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<ProfileEntity>> getProfile(String userId) async {
    try {
      final profile = await _datasource.getProfile(userId);
      return Success(profile);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<ProfileEntity>> updateProfile({
    required ProfileEntity profile,
  }) async {
    try {
      final updatedProfile = await _datasource.updateProfile(
        profile: profile as ProfileModel,
      );
      return Success(updatedProfile);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<void>> resetPassword({required String email}) async {
    try {
      await _datasource.resetPassword(email: email);
      return const Success(null);
    } on AppAuthException catch (e) {
      return Error(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<void>> deleteAccount() async {
    try {
      await _datasource.deleteAccount();
      return const Success(null);
    } on AppAuthException catch (e) {
      return Error(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
