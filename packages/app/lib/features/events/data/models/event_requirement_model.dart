import 'package:event_run/features/events/domain/entities/event_requirement_entity.dart';

class EventRequirementModel extends EventRequirementEntity {
  const EventRequirementModel({
    required super.id,
    required super.eventId,
    required super.inventoryItemId,
    required super.quantity,
    super.notes,
    required super.createdAt,
  });

  factory EventRequirementModel.fromJson(Map<String, dynamic> json) {
    return EventRequirementModel(
      id: json['id'] as String,
      eventId: json['event_id'] as String,
      inventoryItemId: json['inventory_item_id'] as String,
      quantity: json['quantity'] as int,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_id': eventId,
      'inventory_item_id': inventoryItemId,
      'quantity': quantity,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
