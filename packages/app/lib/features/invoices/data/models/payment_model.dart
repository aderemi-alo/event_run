import 'package:app/features/invoices/domain/entities/payment_entity.dart';

class PaymentModel extends PaymentEntity {
  const PaymentModel({
    required super.id,
    required super.invoiceId,
    required super.amount,
    required super.method,
    super.reference,
    super.notes,
    required super.paidAt,
    required super.createdAt,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] as String,
      invoiceId: json['invoice_id'] as String,
      amount: json['amount'] as num,
      method: PaymentMethod.values.byName(json['method'] as String),
      reference: json['reference'] as String?,
      notes: json['notes'] as String?,
      paidAt: DateTime.parse(json['paid_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoice_id': invoiceId,
      'amount': amount,
      'method': method.name,
      'reference': reference,
      'notes': notes,
      'paid_at': paidAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
