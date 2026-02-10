enum EventStatus {
  upcoming,
  inProgress,
  completed,
  cancelled;

  String get displayName {
    switch (this) {
      case EventStatus.upcoming:
        return 'Upcoming';
      case EventStatus.inProgress:
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
  final String name;
  final String? description;
  final DateTime eventDate;
  final DateTime? endDate;
  final String? location;
  final EventStatus status;
  final num? revenue;
  final String? notes;
  final DateTime createdAt;

  const EventEntity({
    required this.id,
    required this.vendorId,
    this.clientId,
    required this.name,
    this.description,
    required this.eventDate,
    this.endDate,
    this.location,
    required this.status,
    this.revenue,
    this.notes,
    required this.createdAt,
  });
}
