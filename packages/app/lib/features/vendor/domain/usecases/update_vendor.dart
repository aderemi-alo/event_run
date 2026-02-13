import 'package:app/core/utils/phone_utils.dart';
import 'package:app/core/utils/result.dart';
import 'package:app/features/vendor/domain/entities/update_vendor_params.dart';
import 'package:app/features/vendor/domain/entities/vendor_entity.dart';
import 'package:app/features/vendor/domain/repositories/vendor_repository.dart';

class UpdateVendorUseCase {
  final VendorRepository _repository;

  UpdateVendorUseCase(this._repository);

  Future<Result<VendorEntity>> call({required UpdateVendorParams params}) {
    if (params.phone != null) {
      params = UpdateVendorParams(
        vendorId: params.vendorId,
        phone: PhoneUtils.normalise(params.phone!),
        businessName: params.businessName,
        email: params.email,
        address: params.address,
        city: params.city,
        state: params.state,
        bankName: params.bankName,
        accountName: params.accountName,
        accountNumber: params.accountNumber,
        plan: params.plan,
        logoUrl: params.logoUrl,
      );
    }

    return _repository.updateVendor(params: params);
  }
}
