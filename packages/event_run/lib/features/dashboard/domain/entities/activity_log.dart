import 'package:equatable/equatable.dart';

/// Activity type enum
enum ActivityType {
  eventCreated,
  invoiceSent,
  paymentReceived,
  clientAdded,
  conflictDetected;

  String get displayName {
    switch (this) {
      case ActivityType.eventCreated:
        return 'EVENT_CREATED';
      case ActivityType.invoiceSent:
        return 'INVOICE_SENT';
      case ActivityType.paymentReceived:
        return 'PAYMENT_RECEIVED';
      case ActivityType.clientAdded:
        return 'CLIENT_ADDED';
      case ActivityType.conflictDetected:
        return 'CONFLICT_DETECTED';
    }
  }
}

/// Activity log entity for dashboard
class ActivityLog extends Equatable {
  const ActivityLog({
    required this.id,
    required this.type,
    required this.message,
    required this.timestamp,
  });

  final String id;
  final ActivityType type;
  final String message;
  final String timestamp; // ISO string

  /// Parse the timestamp string to DateTime
  DateTime get dateTime => DateTime.parse(timestamp);

  @override
  List<Object?> get props => [id, type, message, timestamp];
}
