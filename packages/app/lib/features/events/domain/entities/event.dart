import 'package:equatable/equatable.dart';

/// Event status enum
enum EventStatus {
  covered,
  attention,
  conflict;

  String get displayName {
    switch (this) {
      case EventStatus.covered:
        return 'COVERED';
      case EventStatus.attention:
        return 'ATTENTION';
      case EventStatus.conflict:
        return 'CONFLICT';
    }
  }
}

/// Event entity
class Event extends Equatable {
  const Event({
    required this.id,
    required this.name,
    required this.date,
    required this.location,
    required this.clientId,
    required this.status,
    required this.inventoryCount,
    required this.revenue,
    this.notes,
  });

  final String id;
  final String name;
  final String date; // ISO string, will parse to DateTime when needed
  final String location;
  final String clientId;
  final EventStatus status;
  final int inventoryCount;
  final num revenue;
  final String? notes;

  /// Parse the date string to DateTime
  DateTime get dateTime => DateTime.parse(date);

  @override
  List<Object?> get props => [
    id,
    name,
    date,
    location,
    clientId,
    status,
    inventoryCount,
    revenue,
    notes,
  ];
}
