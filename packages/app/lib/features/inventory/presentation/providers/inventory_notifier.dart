import 'package:app/core/utils/enums.dart';
import 'package:app/core/utils/result.dart';
import 'package:app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:app/features/inventory/domain/entities/create_inventory_item_params.dart';
import 'package:app/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:app/features/inventory/domain/entities/update_inventory_item_params.dart';
import 'package:app/features/inventory/presentation/providers/inventory_providers_di.dart';
import 'package:app/features/inventory/presentation/providers/inventory_state.dart';
import 'package:app/features/vendor/presentation/providers/vendor_providers_di.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InventoryNotifier extends Notifier<InventoryState> {
  @override
  InventoryState build() => InventoryState();

  Future<void> getInventoryItems() async {
    final vendorId = ref.read(vendorProvider).currentVendor?.id;
    if (vendorId == null) {
      state = state.copyWith(
        actionError: 'No vendor found',
        actionState: ActionState.error,
      );
      return;
    }
    state = state.copyWith(isLoading: true, error: null);
    final useCase = ref.read(getInventoryItemsUsecaseProvider);
    final result = await useCase.call(vendorId);
    if (!ref.mounted) return;
    result.fold(
      onSuccess: (inventoryItems) {
        state = state.copyWith(
          inventoryItems: inventoryItems,
          isLoading: false,
        );
      },
      onError: (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
    );
  }

  Future<Result<InventoryItemEntity>> getItemById(String itemId) async {
    state = state.copyWith(isLoading: true, error: null);
    final useCase = ref.read(getItemByIdUsecaseProvider);
    final item = await useCase.call(itemId);
    state = state.copyWith(isLoading: false);
    return item;
  }

  Future<void> createItem(CreateInventoryItemParams params) async {
    final vendorId = ref.read(currentVendorIdProvider);
    if (vendorId == null) {
      state = state.copyWith(
        actionError: 'No vendor found',
        actionState: ActionState.error,
      );
      return;
    }

    state = state.copyWith(actionState: ActionState.loading, actionError: null);
    final useCase = ref.read(createItemUsecaseProvider);
    final result = await useCase.call(
      params: params.copyWith(vendorId: vendorId),
    );
    if (!ref.mounted) return;
    result.fold(
      onSuccess: (inventoryItem) {
        final updatedCategories =
            inventoryItem.category != null &&
                !state.categories.contains(inventoryItem.category)
            ? [...state.categories, inventoryItem.category!]
            : state.categories;

        state = state.copyWith(
          inventoryItems: [...state.inventoryItems, inventoryItem],
          categories: updatedCategories,
          actionState: ActionState.success,
        );
      },
      onError: (failure) {
        state = state.copyWith(
          actionError: failure.message,
          actionState: ActionState.error,
        );
      },
    );
  }

  Future<void> updateItem(UpdateInventoryItemParams params) async {
    state = state.copyWith(actionState: ActionState.loading, actionError: null);
    final useCase = ref.read(updateItemUsecaseProvider);
    final result = await useCase.call(params: params);
    if (!ref.mounted) return;
    result.fold(
      onSuccess: (updatedInventoryItem) {
        final updatedItems = state.inventoryItems
            .map(
              (i) => i.id == updatedInventoryItem.id ? updatedInventoryItem : i,
            )
            .toList();

        final updatedCategories = updatedItems
            .map((i) => i.category)
            .whereType<String>()
            .toSet()
            .toList();

        state = state.copyWith(
          inventoryItems: updatedItems,
          categories: updatedCategories,
          actionState: ActionState.success,
        );
      },
      onError: (failure) {
        state = state.copyWith(
          actionError: failure.message,
          actionState: ActionState.error,
        );
      },
    );
  }

  Future<void> deleteItem(String itemId) async {
    state = state.copyWith(actionState: ActionState.loading, actionError: null);
    final useCase = ref.read(deleteItemUsecaseProvider);
    final result = await useCase.call(itemId);
    if (!ref.mounted) return;
    result.fold(
      onSuccess: (_) {
        final updatedItems = state.inventoryItems
            .where((item) => item.id != itemId)
            .toList();

        final updatedCategories = updatedItems
            .map((i) => i.category)
            .whereType<String>()
            .toSet()
            .toList();

        state = state.copyWith(
          inventoryItems: updatedItems,
          categories: updatedCategories,
          actionState: ActionState.success,
        );
      },
      onError: (failure) {
        state = state.copyWith(
          actionError: failure.message,
          actionState: ActionState.error,
        );
      },
    );
  }

  Future<void> getCategories() async {
    final vendorId = ref.read(vendorProvider).currentVendor?.id;
    if (vendorId == null) {
      state = state.copyWith(
        actionError: 'No vendor found',
        actionState: ActionState.error,
      );
      return;
    }
    state = state.copyWith(isLoading: true, error: null);
    final useCase = ref.read(getCategoriesUsecaseProvider);
    final result = await useCase.call(vendorId);
    if (!ref.mounted) return;
    result.fold(
      onSuccess: (categories) {
        state = state.copyWith(categories: categories, isLoading: false);
      },
      onError: (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
    );
  }

  Future<void> loadInventoryScreen() async {
    final vendorId = ref.read(vendorProvider).currentVendor?.id;
    if (vendorId == null) {
      state = state.copyWith(error: 'No vendor found', isLoading: false);
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    final getItems = ref.read(getInventoryItemsUsecaseProvider);
    final getCats = ref.read(getCategoriesUsecaseProvider);

    final results = await Future.wait([
      getItems.call(vendorId),
      getCats.call(vendorId),
    ]);

    if (!ref.mounted) return;

    final itemsResult = results[0] as Result<List<InventoryItemEntity>>;
    final catsResult = results[1] as Result<List<String>>;

    String? error;
    List<InventoryItemEntity> items = state.inventoryItems;
    List<String> cats = state.categories;

    itemsResult.fold(
      onSuccess: (v) => items = v,
      onError: (f) => error = f.message,
    );

    catsResult.fold(
      onSuccess: (v) => cats = v,
      onError: (f) => error ??= f.message,
    );

    state = state.copyWith(
      inventoryItems: items,
      categories: cats,
      isLoading: false,
      error: error,
    );
  }

  void resetAction() {
    state = state.copyWith(actionState: ActionState.idle, actionError: null);
  }
}
