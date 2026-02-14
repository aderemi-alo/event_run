import 'package:app/core/utils/result.dart';
import 'package:app/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:app/features/inventory/domain/repositories/inventory_repository.dart';

class GetItemById {
  final InventoryRepository _repository;

  GetItemById(this._repository);

  Future<Result<InventoryItemEntity>> call(String itemId) {
    return _repository.getItemById(itemId);
  }
}
