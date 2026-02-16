import 'package:app/core/utils/phone_utils.dart';
import 'package:app/core/uscase/base_usecase.dart';
import 'package:app/core/utils/result.dart';
import 'package:app/features/vendor/domain/entities/create_vendor_params.dart';
import 'package:app/features/vendor/domain/entities/vendor_entity.dart';
import 'package:app/features/vendor/domain/repositories/vendor_repository.dart';

class CreateVendorUseCase implements UseCase<VendorEntity, CreateVendorParams> {
  final VendorRepository _repository;

  const CreateVendorUseCase(this._repository);

  @override
  Future<Result<VendorEntity>> call({
    required CreateVendorParams params,
  }) async {
    final normalized = params.copyWith(
      phone: PhoneUtils.normalise(params.phone),
    );

    return _repository.createVendor(params: normalized);
  }
}
