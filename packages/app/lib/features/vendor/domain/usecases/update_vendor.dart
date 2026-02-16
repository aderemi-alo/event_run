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
      params.copyWith(phone: PhoneUtils.normalise(params.phone!));
    }

    return _repository.updateVendor(params: params);
  }
}
