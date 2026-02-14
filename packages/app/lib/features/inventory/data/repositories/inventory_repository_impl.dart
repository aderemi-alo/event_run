import 'package:app/core/error/exceptions.dart';
import 'package:app/core/error/failures.dart';
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
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<InventoryItemEntity>> getItemById(String itemId) async {
    try {
      final inventoryItem = await _datasource.getItemById(itemId);
      return Success(inventoryItem);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<InventoryItemEntity>> createItem({
    required String vendorId,
    required CreateInventoryItemParams params,
  }) async {
    try {
      final inventoryItem = await _datasource.createItem(
        vendorId: vendorId,
        params: params,
      );
      return Success(inventoryItem);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<InventoryItemEntity>> updateItem({
    required UpdateInventoryItemParams params,
  }) async {
    try {
      final inventoryItem = await _datasource.updateItem(params: params);
      return Success(inventoryItem);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<void>> deleteItem(String itemId) async {
    try {
      await _datasource.deleteItem(itemId);
      return Success(null);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<List<String>>> getCategories(String vendorId) async {
    try {
      final categories = await _datasource.getCategories(vendorId);
      return Success(categories);
    } on ServerException catch (e) {
      return Error(ServerFailure(e.message));
    } catch (e) {
      return Error(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
