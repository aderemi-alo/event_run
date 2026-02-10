import 'package:event_run/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:event_run/features/inventory/domain/repositories/inventory_repository.dart';

class GetItemById {
  final InventoryRepository _repository;

  GetItemById(this._repository);

  Future<InventoryItemEntity?> call(String itemId) {
    return _repository.getItemById(itemId);
  }
}
