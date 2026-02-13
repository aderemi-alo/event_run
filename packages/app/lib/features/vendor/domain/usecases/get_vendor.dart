import 'package:app/core/utils/result.dart';
import 'package:app/features/vendor/domain/entities/vendor_entity.dart';
import 'package:app/features/vendor/domain/repositories/vendor_repository.dart';

class GetVendor {
  final VendorRepository _repository;

  GetVendor(this._repository);

  Future<Result<VendorEntity?>> call(String idType, String id) async {
    {
      if (idType == 'owner') {
        return await _repository.getVendorByOwner(id);
      } else if (idType == 'vendor') {
        return await _repository.getVendorById(id);
      } else {
        throw Exception('Invalid id type: $idType');
      }
    }
  }
}
