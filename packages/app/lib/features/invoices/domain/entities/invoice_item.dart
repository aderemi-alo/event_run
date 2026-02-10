import 'package:equatable/equatable.dart';

/// Invoice item entity
class InvoiceItem extends Equatable {
  const InvoiceItem({
    required this.id,
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });

  final String id;
  final String description;
  final int quantity;
  final num unitPrice;

  /// Calculate total for this line item
  num get total => quantity * unitPrice;

  @override
  List<Object?> get props => [id, description, quantity, unitPrice];
}
