import 'package:app/core/utils/result.dart';
import 'package:app/features/inventory/domain/repositories/inventory_repository.dart';

class GetCategories {
  final InventoryRepository _repository;

  GetCategories(this._repository);

  Future<Result<List<String>>> call(String vendorId) {
    return _repository.getCategories(vendorId);
  }
}
