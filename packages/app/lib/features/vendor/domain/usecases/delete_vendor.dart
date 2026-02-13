import 'package:app/core/utils/result.dart';
import 'package:app/features/vendor/domain/repositories/vendor_repository.dart';

class DeleteVendorUseCase {
  final VendorRepository _repository;

  DeleteVendorUseCase(this._repository);

  Future<Result<void>> call(String vendorId) {
    return _repository.deleteVendor(vendorId);
  }
}
