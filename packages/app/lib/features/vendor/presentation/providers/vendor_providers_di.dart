import 'package:app/features/vendor/domain/usecases/delete_vendor.dart';
import 'package:app/features/vendor/presentation/providers/vendor_provider.dart';
import 'package:app/features/vendor/presentation/providers/vendor_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/features/vendor/data/datasources/vendor_remote_datasource.dart';
import 'package:app/features/vendor/data/repositories/vendor_repository_impl.dart';
import 'package:app/features/vendor/domain/repositories/vendor_repository.dart';
import 'package:app/features/vendor/domain/usecases/get_vendor.dart';
import 'package:app/features/vendor/domain/usecases/create_vendor.dart';
import 'package:app/features/vendor/domain/usecases/update_vendor.dart';
import 'package:app/features/vendor/domain/usecases/update_bank_details.dart';

// Datasource
final vendorRemoteDatasourceProvider = Provider<VendorRemoteDatasource>((ref) {
  return VendorRemoteDatasourceImpl(Supabase.instance.client);
});

// Repository
final vendorRepositoryProvider = Provider<VendorRepository>((ref) {
  return VendorRepositoryImpl(ref.watch(vendorRemoteDatasourceProvider));
});

// Usecases
final getVendorUseCaseProvider = Provider<GetVendor>((ref) {
  return GetVendor(ref.watch(vendorRepositoryProvider));
});

final createVendorUseCaseProvider = Provider<CreateVendorUseCase>((ref) {
  return CreateVendorUseCase(ref.watch(vendorRepositoryProvider));
});

final updateVendorUseCaseProvider = Provider<UpdateVendorUseCase>((ref) {
  return UpdateVendorUseCase(ref.watch(vendorRepositoryProvider));
});

final deleteVendorUseCaseProvider = Provider<DeleteVendorUseCase>((ref) {
  return DeleteVendorUseCase(ref.watch(vendorRepositoryProvider));
});

final updateBankDetailsUseCaseProvider = Provider<UpdateBankDetails>((ref) {
  return UpdateBankDetails(ref.watch(vendorRepositoryProvider));
});

final vendorProvider = NotifierProvider<VendorNotifier, VendorState>(
  VendorNotifier.new,
);
