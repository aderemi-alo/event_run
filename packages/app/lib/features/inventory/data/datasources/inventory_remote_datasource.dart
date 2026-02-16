import 'package:app/features/inventory/domain/entities/create_inventory_item_params.dart';
import 'package:app/features/inventory/domain/entities/update_inventory_item_params.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/core/constants/supabase_constants.dart';
import 'package:app/features/inventory/data/models/inventory_item_model.dart';

abstract class InventoryRemoteDatasource {
  Future<List<InventoryItemModel>> getInventoryItems(String vendorId);
  Future<InventoryItemModel> getItemById(String itemId);
  Future<InventoryItemModel> createItem({
    required String vendorId,
    required CreateInventoryItemParams params,
  });
  Future<InventoryItemModel> updateItem({
    required UpdateInventoryItemParams params,
  });
  Future<void> deleteItem(String itemId);
  Future<List<String>> getCategories(String vendorId);
}

class InventoryRemoteDatasourceImpl implements InventoryRemoteDatasource {
  final SupabaseClient _client;

  InventoryRemoteDatasourceImpl(this._client);

  @override
  Future<List<InventoryItemModel>> getInventoryItems(String vendorId) async {
    final response = await _client
        .from(SupabaseConstants.inventoryItemsTable)
        .select()
        .eq('vendor_id', vendorId)
        .order('name');

    return response.map((json) => InventoryItemModel.fromJson(json)).toList();
  }

  @override
  Future<InventoryItemModel> getItemById(String itemId) async {
    final response = await _client
        .from(SupabaseConstants.inventoryItemsTable)
        .select()
        .eq('id', itemId)
        .single();

    return InventoryItemModel.fromJson(response);
  }

  @override
  Future<InventoryItemModel> createItem({
    required String vendorId,
    required CreateInventoryItemParams params,
  }) async {
    final response = await _client
        .from(SupabaseConstants.inventoryItemsTable)
        .insert({...params.toJson(), 'vendor_id': vendorId})
        .select()
        .single();

    return InventoryItemModel.fromJson(response);
  }

  @override
  Future<InventoryItemModel> updateItem({
    required UpdateInventoryItemParams params,
  }) async {
    final response = await _client
        .from(SupabaseConstants.inventoryItemsTable)
        .update(params.toJson())
        .eq('id', params.id)
        .select()
        .single();
    return InventoryItemModel.fromJson(response);
  }

  @override
  Future<void> deleteItem(String itemId) async {
    await _client
        .from(SupabaseConstants.inventoryItemsTable)
        .delete()
        .eq('id', itemId);
  }

  @override
  Future<List<String>> getCategories(String vendorId) async {
    final response = await _client
        .from(SupabaseConstants.inventoryItemsTable)
        .select('category')
        .eq('vendor_id', vendorId)
        .not('category', 'is', null);

    return response.map((json) => json['category'] as String).toSet().toList();
  }
}
