class InventoryItemEntity {
  final String id;
  final String vendorId;
  final String name;
  final int quantity;
  final String? category;
  final String? notes;
  final String? imageUrl;
  final DateTime createdAt;

  const InventoryItemEntity({
    required this.id,
    required this.vendorId,
    required this.name,
    required this.quantity,
    this.category,
    this.notes,
    this.imageUrl,
    required this.createdAt,
  });
}
