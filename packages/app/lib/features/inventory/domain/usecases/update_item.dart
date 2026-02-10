import 'package:event_run/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:event_run/features/inventory/domain/repositories/inventory_repository.dart';

class UpdateItem {
  final InventoryRepository _repository;

  UpdateItem(this._repository);

  Future<InventoryItemEntity> call({required InventoryItemEntity item}) {
    return _repository.updateItem(item: item);
  }
}
