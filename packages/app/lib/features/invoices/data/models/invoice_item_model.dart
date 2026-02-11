import 'package:app/features/invoices/domain/entities/invoice_item_entity.dart';

class InvoiceItemModel extends InvoiceItemEntity {
  const InvoiceItemModel({
    required super.id,
    required super.invoiceId,
    required super.description,
    required super.quantity,
    required super.unitPrice,
  });

  factory InvoiceItemModel.fromJson(Map<String, dynamic> json) {
    return InvoiceItemModel(
      id: json['id'] as String,
      invoiceId: json['invoice_id'] as String,
      description: json['description'] as String,
      quantity: json['quantity'] as int,
      unitPrice: json['unit_price'] as num,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoice_id': invoiceId,
      'description': description,
      'quantity': quantity,
      'unit_price': unitPrice,
    };
  }
}
