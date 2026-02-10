class SubscriptionEventEntity {
  final String id;
  final String vendorId;
  final String eventType;
  final String? reference;
  final num? amount;
  final DateTime createdAt;

  const SubscriptionEventEntity({
    required this.id,
    required this.vendorId,
    required this.eventType,
    this.reference,
    this.amount,
    required this.createdAt,
  });
}
