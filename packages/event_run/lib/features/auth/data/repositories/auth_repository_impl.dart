import 'package:event_run/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:event_run/features/auth/data/models/vendor_model.dart';
import 'package:event_run/features/auth/domain/entities/vendor.dart';
import 'package:event_run/features/auth/domain/repositories/auth_repository.dart';
import 'package:event_run/core/constants/mock_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'auth_repository_impl.g.dart';

/// Implementation of AuthRepository using local data source
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._localDataSource);

  final AuthLocalDataSource _localDataSource;

  @override
  Future<bool> isAuthenticated() async {
    return _localDataSource.isAuthenticated();
  }

  @override
  Future<bool> hasCompletedOnboarding() async {
    return _localDataSource.hasCompletedOnboarding();
  }

  @override
  Future<void> completeOnboarding() async {
    await _localDataSource.completeOnboarding();
  }

  @override
  Future<Vendor?> getCurrentUser() async {
    return _localDataSource.getCurrentUser();
  }

  @override
  Future<Vendor> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock login - in real app would call API
    // For now, return mock vendor
    final vendorModel = VendorModel.fromEntity(MockData.mockVendor);

    await _localDataSource.saveUser(vendorModel);
    return vendorModel;
  }

  @override
  Future<Vendor> signup(Vendor vendor, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock signup - in real app would call API
    final vendorModel = VendorModel.fromEntity(vendor);

    await _localDataSource.saveUser(vendorModel);
    await _localDataSource.completeOnboarding();

    return vendorModel;
  }

  @override
  Future<void> logout() async {
    await _localDataSource.removeUser();
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.read(authLocalDataSourceProvider));
}
