import 'package:app/core/utils/result.dart';
import 'package:app/features/inventory/domain/entities/create_inventory_item_params.dart';
import 'package:app/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:app/features/inventory/domain/entities/update_inventory_item_params.dart';

abstract class InventoryRepository {
  Future<Result<List<InventoryItemEntity>>> getInventoryItems(String vendorId);
  Future<Result<InventoryItemEntity>> getItemById(String itemId);
  Future<Result<InventoryItemEntity>> createItem({
    required String vendorId,
    required CreateInventoryItemParams params,
  });
  Future<Result<InventoryItemEntity>> updateItem({
    required UpdateInventoryItemParams params,
  });
  Future<Result<void>> deleteItem(String itemId);
  Future<Result<List<String>>> getCategories(String vendorId);
}
