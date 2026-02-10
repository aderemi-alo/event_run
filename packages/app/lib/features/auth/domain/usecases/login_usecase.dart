import 'package:event_run/features/auth/domain/entities/vendor.dart';
import 'package:event_run/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'login_usecase.g.dart';

/// Use case for logging in a user
class LoginUseCase {
  LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  /// Execute login with email and password
  Future<Vendor> execute(String email, String password) async {
    // Validate inputs
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password are required');
    }

    // Call repository to login
    return await _authRepository.login(email, password);
  }
}

// @riverpod
// LoginUseCase loginUseCase(Ref ref) {
//   return LoginUseCase(ref.read(authRepositoryProvider));
// }
