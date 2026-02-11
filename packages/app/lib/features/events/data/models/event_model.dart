import 'package:app/features/events/domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  const EventModel({
    required super.id,
    required super.vendorId,
    super.clientId,
    required super.name,
    required super.eventDate,
    super.location,
    required super.status,
    super.revenue,
    super.notes,
    required super.createdAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      vendorId: json['vendor_id'] as String,
      clientId: json['client_id'] as String?,
      name: json['name'] as String,
      eventDate: DateTime.parse(json['event_date'] as String),
      location: json['location'] as String?,
      status: EventStatus.values.byName(json['status'] as String),
      revenue: json['revenue'] as num?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendor_id': vendorId,
      'client_id': clientId,
      'name': name,
      'event_date': eventDate.toIso8601String(),
      'location': location,
      'status': status.name,
      'revenue': revenue,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
