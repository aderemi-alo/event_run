import 'package:app/core/utils/phone_utils.dart';
import 'package:app/core/utils/result.dart';
import 'package:app/features/vendor/domain/entities/create_vendor_params.dart';
import 'package:app/features/vendor/domain/entities/vendor_entity.dart';
import 'package:app/features/vendor/domain/repositories/vendor_repository.dart';

class CreateVendorUseCase {
  final VendorRepository _repository;

  const CreateVendorUseCase(this._repository);

  Future<Result<VendorEntity>> call({
    required CreateVendorParams params,
  }) async {
    final normalized = CreateVendorParams(
      businessName: params.businessName,
      email: params.email,
      phone: PhoneUtils.normalise(params.phone),
      address: params.address,
      city: params.city,
      state: params.state,
      bankName: params.bankName,
      accountName: params.accountName,
      accountNumber: params.accountNumber,
      plan: params.plan,
      ownerId: params.ownerId,
      logoUrl: params.logoUrl,
    );

    return _repository.createVendor(params: normalized);
  }
}
