import 'package:app/core/uscase/base_usecase.dart';
import 'package:app/core/utils/result.dart';
import 'package:app/features/vendor/domain/repositories/vendor_repository.dart';

class DeleteVendorUseCase implements UseCase<void, String> {
  final VendorRepository _repository;

  DeleteVendorUseCase(this._repository);

  @override
  Future<Result<void>> call({required String params}) {
    return _repository.deleteVendor(params);
  }
}
