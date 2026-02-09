import 'package:equatable/equatable.dart';
import 'package:event_run/features/invoices/domain/entities/invoice_item.dart';

/// Invoice status enum
enum InvoiceStatus {
  draft,
  sent,
  paid,
  overdue;

  String get displayName {
    switch (this) {
      case InvoiceStatus.draft:
        return 'DRAFT';
      case InvoiceStatus.sent:
        return 'SENT';
      case InvoiceStatus.paid:
        return 'PAID';
      case InvoiceStatus.overdue:
        return 'OVERDUE';
    }
  }
}

/// Invoice entity
class Invoice extends Equatable {
  const Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.clientId,
    this.eventId,
    required this.items,
    required this.amount,
    required this.dateIssued,
    required this.dueDate,
    required this.status,
    this.notes,
  });

  final String id;
  final String invoiceNumber;
  final String clientId;
  final String? eventId;
  final List<InvoiceItem> items;
  final num amount;
  final String dateIssued; // ISO string
  final String dueDate; // ISO string
  final InvoiceStatus status;
  final String? notes;

  /// Parse the date issued string to DateTime
  DateTime get dateIssuedDateTime => DateTime.parse(dateIssued);

  /// Parse the due date string to DateTime
  DateTime get dueDateDateTime => DateTime.parse(dueDate);

  @override
  List<Object?> get props => [
    id,
    invoiceNumber,
    clientId,
    eventId,
    items,
    amount,
    dateIssued,
    dueDate,
    status,
    notes,
  ];
}
