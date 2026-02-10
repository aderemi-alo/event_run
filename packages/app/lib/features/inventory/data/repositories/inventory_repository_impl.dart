import 'package:event_run/features/inventory/data/datasources/inventory_remote_datasource.dart';
import 'package:event_run/features/inventory/data/models/inventory_item_model.dart';
import 'package:event_run/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:event_run/features/inventory/domain/repositories/inventory_repository.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final InventoryRemoteDatasource _datasource;

  InventoryRepositoryImpl(this._datasource);

  @override
  Future<List<InventoryItemEntity>> getInventoryItems(String vendorId) {
    return _datasource.getInventoryItems(vendorId);
  }

  @override
  Future<InventoryItemEntity?> getItemById(String itemId) {
    return _datasource.getItemById(itemId);
  }

  @override
  Future<InventoryItemEntity> createItem(
      {required InventoryItemEntity item}) {
    final model = InventoryItemModel(
      id: item.id,
      vendorId: item.vendorId,
      name: item.name,
      quantity: item.quantity,
      category: item.category,
      notes: item.notes,
      imageUrl: item.imageUrl,
      createdAt: item.createdAt,
    );
    return _datasource.createItem(item: model);
  }

  @override
  Future<InventoryItemEntity> updateItem(
      {required InventoryItemEntity item}) {
    final model = InventoryItemModel(
      id: item.id,
      vendorId: item.vendorId,
      name: item.name,
      quantity: item.quantity,
      category: item.category,
      notes: item.notes,
      imageUrl: item.imageUrl,
      createdAt: item.createdAt,
    );
    return _datasource.updateItem(item: model);
  }

  @override
  Future<void> deleteItem(String itemId) {
    return _datasource.deleteItem(itemId);
  }
}
