enum EventStatus {
  draft,
  confirmed,
  completed,
  cancelled;

  String get displayName {
    switch (this) {
      case EventStatus.draft:
        return 'Upcoming';
      case EventStatus.confirmed:
        return 'In Progress';
      case EventStatus.completed:
        return 'Completed';
      case EventStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class EventEntity {
  final String id;
  final String vendorId;
  final String? clientId;
  final String? clientName;
  final String name;
  final DateTime eventDate;
  final DateTime? startTime;
  final String? location;
  final EventStatus status;
  final num? revenue;
  final String? notes;
  final DateTime createdAt;

  const EventEntity({
    required this.id,
    required this.vendorId,
    this.clientId,
    this.clientName,
    required this.name,
    required this.eventDate,
    this.startTime,
    this.location,
    required this.status,
    this.revenue,
    this.notes,
    required this.createdAt,
  });
}
