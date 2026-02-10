import 'package:event_run/features/inventory/domain/entities/inventory_item_entity.dart';

abstract class InventoryRepository {
  Future<List<InventoryItemEntity>> getInventoryItems(String vendorId);
  Future<InventoryItemEntity?> getItemById(String itemId);
  Future<InventoryItemEntity> createItem({required InventoryItemEntity item});
  Future<InventoryItemEntity> updateItem({required InventoryItemEntity item});
  Future<void> deleteItem(String itemId);
}
