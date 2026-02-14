import 'package:app/features/inventory/domain/entities/inventory_item_entity.dart';

class InventoryItemModel extends InventoryItemEntity {
  const InventoryItemModel({
    required super.id,
    required super.vendorId,
    required super.name,
    required super.quantity,
    super.category,
    super.isActive,
    super.description,
    super.imageUrl,
    required super.createdAt,
  });

  factory InventoryItemModel.fromJson(Map<String, dynamic> json) {
    return InventoryItemModel(
      id: json['id'] as String,
      vendorId: json['vendor_id'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      category: json['category'] as String?,
      isActive: json['is_active'] as bool?,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendor_id': vendorId,
      'name': name,
      'quantity': quantity,
      'category': category,
      'is_active': isActive,
      'description': description,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
