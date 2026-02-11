import 'package:app/features/events/domain/entities/inventory_conflict_entity.dart';

class InventoryConflictModel extends InventoryConflictEntity {
  const InventoryConflictModel({
    required super.inventoryItemId,
    required super.itemName,
    required super.availableQuantity,
    required super.requestedQuantity,
    required super.conflictingEventIds,
  });

  factory InventoryConflictModel.fromJson(Map<String, dynamic> json) {
    return InventoryConflictModel(
      inventoryItemId: json['inventory_item_id'] as String,
      itemName: json['item_name'] as String,
      availableQuantity: json['available_quantity'] as int,
      requestedQuantity: json['requested_quantity'] as int,
      conflictingEventIds: (json['conflicting_event_ids'] as List)
          .cast<String>(),
    );
  }
}
