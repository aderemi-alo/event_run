class CreateInventoryItemParams {
  final String? vendorId;
  final String name;
  final int quantity;
  final String? category;
  final String? description;

  const CreateInventoryItemParams({
    this.vendorId,
    required this.name,
    required this.quantity,
    this.category,
    this.description,
  });

  CreateInventoryItemParams copyWith({
    String? vendorId,
    String? name,
    int? quantity,
    String? category,
    String? description,
  }) {
    return CreateInventoryItemParams(
      vendorId: vendorId ?? this.vendorId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'category': category,
      'description': description,
      'is_active': true,
    };
  }
}
