import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/features/vendor/data/datasources/vendor_remote_datasource.dart';
import 'package:app/features/vendor/data/repositories/vendor_repository_impl.dart';
import 'package:app/features/vendor/domain/entities/vendor_entity.dart';
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
final getVendorUsecaseProvider = Provider<GetVendor>((ref) {
  return GetVendor(ref.watch(vendorRepositoryProvider));
});

final createVendorUsecaseProvider = Provider<CreateVendor>((ref) {
  return CreateVendor(ref.watch(vendorRepositoryProvider));
});

final updateVendorUsecaseProvider = Provider<UpdateVendor>((ref) {
  return UpdateVendor(ref.watch(vendorRepositoryProvider));
});

final updateBankDetailsUsecaseProvider = Provider<UpdateBankDetails>((ref) {
  return UpdateBankDetails(ref.watch(vendorRepositoryProvider));
});

// Async state
final vendorProvider = FutureProvider.autoDispose.family<VendorEntity?, String>(
  (ref, ownerId) {
    return ref.watch(getVendorUsecaseProvider).call(ownerId);
  },
);
