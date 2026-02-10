import 'package:event_run/features/vendor/domain/repositories/vendor_repository.dart';

class UpdateBankDetails {
  final VendorRepository _repository;

  UpdateBankDetails(this._repository);

  Future<void> call({
    required String vendorId,
    required String bankName,
    required String accountName,
    required String accountNumber,
  }) {
    return _repository.updateBankDetails(
      vendorId: vendorId,
      bankName: bankName,
      accountName: accountName,
      accountNumber: accountNumber,
    );
  }
}
