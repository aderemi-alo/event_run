import 'package:app/features/vendor/domain/entities/vendor_entity.dart';
import 'package:app/features/vendor/domain/repositories/vendor_repository.dart';

class GetVendor {
  final VendorRepository _repository;

  GetVendor(this._repository);

  Future<VendorEntity?> call(String ownerId) {
    return _repository.getVendorByOwner(ownerId);
  }
}
