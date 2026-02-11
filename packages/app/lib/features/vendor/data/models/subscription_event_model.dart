import 'package:app/features/vendor/domain/entities/subscription_event_entity.dart';

class SubscriptionEventModel extends SubscriptionEventEntity {
  const SubscriptionEventModel({
    required super.id,
    required super.vendorId,
    required super.eventType,
    super.reference,
    super.amount,
    required super.createdAt,
  });

  factory SubscriptionEventModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionEventModel(
      id: json['id'] as String,
      vendorId: json['vendor_id'] as String,
      eventType: json['event_type'] as String,
      reference: json['reference'] as String?,
      amount: json['amount'] as num?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendor_id': vendorId,
      'event_type': eventType,
      'reference': reference,
      'amount': amount,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
