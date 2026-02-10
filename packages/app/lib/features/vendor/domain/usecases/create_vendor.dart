import 'package:event_run/features/vendor/domain/entities/vendor_entity.dart';
import 'package:event_run/features/vendor/domain/repositories/vendor_repository.dart';

class CreateVendor {
  final VendorRepository _repository;

  CreateVendor(this._repository);

  Future<VendorEntity> call({required VendorEntity vendor}) {
    return _repository.createVendor(vendor: vendor);
  }
}
