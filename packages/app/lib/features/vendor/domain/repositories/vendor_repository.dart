import 'package:app/core/utils/result.dart';
import 'package:app/features/vendor/domain/entities/create_vendor_params.dart';
import 'package:app/features/vendor/domain/entities/update_vendor_params.dart';
import 'package:app/features/vendor/domain/entities/vendor_entity.dart';

abstract class VendorRepository {
  Future<Result<VendorEntity?>> getVendorByOwner(String ownerId);
  Future<Result<VendorEntity?>> getVendorById(String vendorId);
  Future<Result<VendorEntity>> createVendor({
    required CreateVendorParams params,
  });
  Future<Result<VendorEntity>> updateVendor({
    required UpdateVendorParams params,
  });
  Future<Result<void>> deleteVendor(String vendorId);
  Future<void> updateBankDetails({
    required String vendorId,
    required String bankName,
    required String accountName,
    required String accountNumber,
  });
  Future<void> uploadLogo({required String vendorId, required String filePath});
}
