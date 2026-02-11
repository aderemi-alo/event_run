import 'package:app/features/vendor/domain/entities/vendor_entity.dart';
import 'package:app/features/vendor/domain/repositories/vendor_repository.dart';

class UpdateVendor {
  final VendorRepository _repository;

  UpdateVendor(this._repository);

  Future<VendorEntity> call({required VendorEntity vendor}) {
    return _repository.updateVendor(vendor: vendor);
  }
}
