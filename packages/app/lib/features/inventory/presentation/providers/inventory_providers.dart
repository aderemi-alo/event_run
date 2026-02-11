import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/features/inventory/data/datasources/inventory_remote_datasource.dart';
import 'package:app/features/inventory/data/repositories/inventory_repository_impl.dart';
import 'package:app/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:app/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:app/features/inventory/domain/usecases/get_inventory_items.dart';
import 'package:app/features/inventory/domain/usecases/get_item_by_id.dart';
import 'package:app/features/inventory/domain/usecases/create_item.dart';
import 'package:app/features/inventory/domain/usecases/update_item.dart';
import 'package:app/features/inventory/domain/usecases/delete_item.dart';

// Datasource
final inventoryRemoteDatasourceProvider = Provider<InventoryRemoteDatasource>((
  ref,
) {
  return InventoryRemoteDatasourceImpl(Supabase.instance.client);
});

// Repository
final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  return InventoryRepositoryImpl(ref.watch(inventoryRemoteDatasourceProvider));
});

// Usecases
final getInventoryItemsUsecaseProvider = Provider<GetInventoryItems>((ref) {
  return GetInventoryItems(ref.watch(inventoryRepositoryProvider));
});

final getItemByIdUsecaseProvider = Provider<GetItemById>((ref) {
  return GetItemById(ref.watch(inventoryRepositoryProvider));
});

final createItemUsecaseProvider = Provider<CreateItem>((ref) {
  return CreateItem(ref.watch(inventoryRepositoryProvider));
});

final updateItemUsecaseProvider = Provider<UpdateItem>((ref) {
  return UpdateItem(ref.watch(inventoryRepositoryProvider));
});

final deleteItemUsecaseProvider = Provider<DeleteItem>((ref) {
  return DeleteItem(ref.watch(inventoryRepositoryProvider));
});

// Async state
final inventoryItemsProvider = FutureProvider.autoDispose
    .family<List<InventoryItemEntity>, String>((ref, vendorId) {
      return ref.watch(getInventoryItemsUsecaseProvider).call(vendorId);
    });

final inventoryItemDetailProvider = FutureProvider.autoDispose
    .family<InventoryItemEntity?, String>((ref, itemId) {
      return ref.watch(getItemByIdUsecaseProvider).call(itemId);
    });
