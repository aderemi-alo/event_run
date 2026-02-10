import 'package:event_run/features/events/domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  const EventModel({
    required super.id,
    required super.vendorId,
    super.clientId,
    required super.name,
    super.description,
    required super.eventDate,
    super.endDate,
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
      description: json['description'] as String?,
      eventDate: DateTime.parse(json['event_date'] as String),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'] as String)
          : null,
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
      'description': description,
      'event_date': eventDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'location': location,
      'status': status.name,
      'revenue': revenue,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
