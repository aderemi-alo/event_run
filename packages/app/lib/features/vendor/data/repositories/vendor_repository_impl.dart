import 'package:app/features/vendor/data/datasources/vendor_remote_datasource.dart';
import 'package:app/features/vendor/data/models/vendor_model.dart';
import 'package:app/features/vendor/domain/entities/vendor_entity.dart';
import 'package:app/features/vendor/domain/repositories/vendor_repository.dart';

class VendorRepositoryImpl implements VendorRepository {
  final VendorRemoteDatasource _datasource;

  VendorRepositoryImpl(this._datasource);

  @override
  Future<VendorEntity?> getVendorByOwner(String ownerId) {
    return _datasource.getVendorByOwner(ownerId);
  }

  @override
  Future<VendorEntity> createVendor({required VendorEntity vendor}) {
    final model = VendorModel(
      id: vendor.id,
      businessName: vendor.businessName,
      logoUrl: vendor.logoUrl,
      email: vendor.email,
      phone: vendor.phone,
      address: vendor.address,
      city: vendor.city,
      state: vendor.state,
      bankName: vendor.bankName,
      accountName: vendor.accountName,
      accountNumber: vendor.accountNumber,
      plan: vendor.plan,
      planExpiresAt: vendor.planExpiresAt,
      createdAt: vendor.createdAt,
      ownerId: vendor.ownerId,
    );
    return _datasource.createVendor(vendor: model);
  }

  @override
  Future<VendorEntity> updateVendor({required VendorEntity vendor}) {
    final model = VendorModel(
      id: vendor.id,
      businessName: vendor.businessName,
      logoUrl: vendor.logoUrl,
      email: vendor.email,
      phone: vendor.phone,
      address: vendor.address,
      city: vendor.city,
      state: vendor.state,
      bankName: vendor.bankName,
      accountName: vendor.accountName,
      accountNumber: vendor.accountNumber,
      plan: vendor.plan,
      planExpiresAt: vendor.planExpiresAt,
      createdAt: vendor.createdAt,
      ownerId: vendor.ownerId,
    );
    return _datasource.updateVendor(vendor: model);
  }

  @override
  Future<void> updateBankDetails({
    required String vendorId,
    required String bankName,
    required String accountName,
    required String accountNumber,
  }) {
    return _datasource.updateBankDetails(
      vendorId: vendorId,
      bankName: bankName,
      accountName: accountName,
      accountNumber: accountNumber,
    );
  }

  @override
  Future<void> uploadLogo({
    required String vendorId,
    required String filePath,
  }) {
    return _datasource.uploadLogo(vendorId: vendorId, filePath: filePath);
  }
}
