import 'package:app/core/error/supabase_error_handler.dart';
import 'package:app/core/utils/result.dart';
import 'package:app/features/inventory/data/datasources/inventory_remote_datasource.dart';
import 'package:app/features/inventory/domain/entities/create_inventory_item_params.dart';
import 'package:app/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:app/features/inventory/domain/entities/update_inventory_item_params.dart';
import 'package:app/features/inventory/domain/repositories/inventory_repository.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final InventoryRemoteDatasource _datasource;

  InventoryRepositoryImpl(this._datasource);

  @override
  Future<Result<List<InventoryItemEntity>>> getInventoryItems(
    String vendorId,
  ) async {
    try {
      final inventoryItems = await _datasource.getInventoryItems(vendorId);
      return Success(inventoryItems);
    } catch (e) {
      return Error(SupabaseErrorHandler.map(e));
    }
  }

  @override
  Future<Result<InventoryItemEntity>> getItemById(String itemId) async {
    try {
      final inventoryItem = await _datasource.getItemById(itemId);
      return Success(inventoryItem);
    } catch (e) {
      return Error(SupabaseErrorHandler.map(e));
    }
  }

  @override
  Future<Result<InventoryItemEntity>> createItem({
    required CreateInventoryItemParams params,
  }) async {
    try {
      final inventoryItem = await _datasource.createItem(
        vendorId: params.vendorId!,
        params: params,
      );
      return Success(inventoryItem);
    } catch (e) {
      return Error(SupabaseErrorHandler.map(e));
    }
  }

  @override
  Future<Result<InventoryItemEntity>> updateItem({
    required UpdateInventoryItemParams params,
  }) async {
    try {
      final inventoryItem = await _datasource.updateItem(params: params);
      return Success(inventoryItem);
    } catch (e) {
      return Error(SupabaseErrorHandler.map(e));
    }
  }

  @override
  Future<Result<void>> deleteItem(String itemId) async {
    try {
      await _datasource.deleteItem(itemId);
      return Success(null);
    } catch (e) {
      return Error(SupabaseErrorHandler.map(e));
    }
  }

  @override
  Future<Result<List<String>>> getCategories(String vendorId) async {
    try {
      final categories = await _datasource.getCategories(vendorId);
      return Success(categories);
    } catch (e) {
      return Error(SupabaseErrorHandler.map(e));
    }
  }
}
