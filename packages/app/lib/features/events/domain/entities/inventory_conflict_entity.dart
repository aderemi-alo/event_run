class InventoryConflictEntity {
  final String inventoryItemId;
  final String itemName;
  final int availableQuantity;
  final int requestedQuantity;
  final List<String> conflictingEventIds;

  const InventoryConflictEntity({
    required this.inventoryItemId,
    required this.itemName,
    required this.availableQuantity,
    required this.requestedQuantity,
    required this.conflictingEventIds,
  });
}
