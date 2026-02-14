class UpdateInventoryItemParams {
  final String id;
  final String? name;
  final int? quantity;
  final String? category;
  final String? description;
  final bool? isActive;

  const UpdateInventoryItemParams({
    required this.id,
    this.name,
    this.quantity,
    this.category,
    this.description,
    this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (quantity != null) 'quantity': quantity,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (isActive != null) 'is_active': isActive,
    };
  }
}
