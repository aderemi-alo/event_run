import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/core/constants/supabase_constants.dart';
import 'package:app/core/error/exceptions.dart';
import 'package:app/features/inventory/data/models/inventory_item_model.dart';

abstract class InventoryRemoteDatasource {
  Future<List<InventoryItemModel>> getInventoryItems(String vendorId);
  Future<InventoryItemModel?> getItemById(String itemId);
  Future<InventoryItemModel> createItem({required InventoryItemModel item});
  Future<InventoryItemModel> updateItem({required InventoryItemModel item});
  Future<void> deleteItem(String itemId);
}

class InventoryRemoteDatasourceImpl implements InventoryRemoteDatasource {
  final SupabaseClient _client;

  InventoryRemoteDatasourceImpl(this._client);

  @override
  Future<List<InventoryItemModel>> getInventoryItems(String vendorId) async {
    try {
      final response = await _client
          .from(SupabaseConstants.inventoryItemsTable)
          .select()
          .eq('vendor_id', vendorId)
          .order('name');

      return response.map((json) => InventoryItemModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<InventoryItemModel?> getItemById(String itemId) async {
    try {
      final response = await _client
          .from(SupabaseConstants.inventoryItemsTable)
          .select()
          .eq('id', itemId)
          .maybeSingle();

      if (response == null) return null;
      return InventoryItemModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<InventoryItemModel> createItem({
    required InventoryItemModel item,
  }) async {
    try {
      final response = await _client
          .from(SupabaseConstants.inventoryItemsTable)
          .insert(item.toJson())
          .select()
          .single();

      return InventoryItemModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<InventoryItemModel> updateItem({
    required InventoryItemModel item,
  }) async {
    try {
      final response = await _client
          .from(SupabaseConstants.inventoryItemsTable)
          .update(item.toJson())
          .eq('id', item.id)
          .select()
          .single();

      return InventoryItemModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteItem(String itemId) async {
    try {
      await _client
          .from(SupabaseConstants.inventoryItemsTable)
          .delete()
          .eq('id', itemId);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
