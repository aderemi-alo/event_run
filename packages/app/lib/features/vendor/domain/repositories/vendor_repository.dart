import 'package:app/features/vendor/domain/entities/vendor_entity.dart';

abstract class VendorRepository {
  Future<VendorEntity?> getVendorByOwner(String ownerId);
  Future<VendorEntity> createVendor({required VendorEntity vendor});
  Future<VendorEntity> updateVendor({required VendorEntity vendor});
  Future<void> updateBankDetails({
    required String vendorId,
    required String bankName,
    required String accountName,
    required String accountNumber,
  });
  Future<void> uploadLogo({required String vendorId, required String filePath});
}
