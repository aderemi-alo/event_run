class InventoryItemEntity {
  final String id;
  final String vendorId;
  final String name;
  final int quantity;
  final String? category;
  final String? description;
  final String? imageUrl;
  final bool? isActive;
  final DateTime createdAt;

  const InventoryItemEntity({
    required this.id,
    required this.vendorId,
    required this.name,
    required this.quantity,
    this.category,
    this.description,
    this.imageUrl,
    this.isActive,
    required this.createdAt,
  });
}
