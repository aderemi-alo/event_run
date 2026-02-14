class CreateInventoryItemParams {
  final String name;
  final int quantity;
  final String? category;
  final String? description;

  const CreateInventoryItemParams({
    required this.name,
    required this.quantity,
    this.category,
    this.description,
  });

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
