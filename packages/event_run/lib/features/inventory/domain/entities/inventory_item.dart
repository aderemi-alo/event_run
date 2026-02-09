import 'package:equatable/equatable.dart';

/// Inventory item entity
class InventoryItem extends Equatable {
  const InventoryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
    this.notes,
    this.imageUrl,
  });

  final String id;
  final String name;
  final int quantity;
  final String category;
  final String? notes;
  final String? imageUrl;

  @override
  List<Object?> get props => [id, name, quantity, category, notes, imageUrl];
}
