import 'package:app/features/invoices/domain/entities/invoice_item_entity.dart';

enum InvoiceStatus {
  draft,
  sent,
  paid,
  overdue;

  String get displayName {
    switch (this) {
      case InvoiceStatus.draft:
        return 'Draft';
      case InvoiceStatus.sent:
        return 'Sent';
      case InvoiceStatus.paid:
        return 'Paid';
      case InvoiceStatus.overdue:
        return 'Overdue';
    }
  }
}

class InvoiceEntity {
  final String id;
  final String vendorId;
  final String clientId;
  final String? eventId;
  final String invoiceNumber;
  final List<InvoiceItemEntity> items;
  final num totalAmount;
  final DateTime dateIssued;
  final DateTime dueDate;
  final InvoiceStatus status;
  final String? notes;
  final String? snapshotData;
  final DateTime createdAt;

  const InvoiceEntity({
    required this.id,
    required this.vendorId,
    required this.clientId,
    this.eventId,
    required this.invoiceNumber,
    required this.items,
    required this.totalAmount,
    required this.dateIssued,
    required this.dueDate,
    required this.status,
    this.notes,
    this.snapshotData,
    required this.createdAt,
  });
}
