import 'package:app/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:app/features/inventory/domain/repositories/inventory_repository.dart';

class CreateItem {
  final InventoryRepository _repository;

  CreateItem(this._repository);

  Future<InventoryItemEntity> call({required InventoryItemEntity item}) {
    return _repository.createItem(item: item);
  }
}
