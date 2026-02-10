enum PaymentMethod {
  bankTransfer,
  cash,
  card,
  other;

  String get displayName {
    switch (this) {
      case PaymentMethod.bankTransfer:
        return 'Bank Transfer';
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.card:
        return 'Card';
      case PaymentMethod.other:
        return 'Other';
    }
  }
}

class PaymentEntity {
  final String id;
  final String invoiceId;
  final num amount;
  final PaymentMethod method;
  final String? reference;
  final String? notes;
  final DateTime paidAt;
  final DateTime createdAt;

  const PaymentEntity({
    required this.id,
    required this.invoiceId,
    required this.amount,
    required this.method,
    this.reference,
    this.notes,
    required this.paidAt,
    required this.createdAt,
  });
}
