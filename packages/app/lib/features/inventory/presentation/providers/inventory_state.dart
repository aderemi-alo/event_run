import 'package:app/core/utils/enums.dart';
import 'package:app/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_state.freezed.dart';

@freezed
class InventoryState with _$InventoryState {
  const factory InventoryState({
    @Default([]) List<InventoryItemEntity> inventoryItems,
    @Default([]) List<String> categories,
    @Default(false) bool isLoading,
    @Default(null) String? error,
    @Default(ActionState.idle) ActionState actionState,
    @Default(null) String? actionError,
  }) = _InventoryState;
}
