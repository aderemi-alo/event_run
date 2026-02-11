import 'package:app/features/invoices/data/models/invoice_item_model.dart';
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';

class InvoiceModel extends InvoiceEntity {
  const InvoiceModel({
    required super.id,
    required super.vendorId,
    required super.clientId,
    super.eventId,
    required super.invoiceNumber,
    required super.items,
    required super.totalAmount,
    required super.dateIssued,
    required super.dueDate,
    required super.status,
    super.notes,
    super.snapshotData,
    required super.createdAt,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    final itemsList =
        (json['invoice_items'] as List?)
            ?.map((e) => InvoiceItemModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    return InvoiceModel(
      id: json['id'] as String,
      vendorId: json['vendor_id'] as String,
      clientId: json['client_id'] as String,
      eventId: json['event_id'] as String?,
      invoiceNumber: json['invoice_number'] as String,
      items: itemsList,
      totalAmount: json['total_amount'] as num,
      dateIssued: DateTime.parse(json['date_issued'] as String),
      dueDate: DateTime.parse(json['due_date'] as String),
      status: InvoiceStatus.values.byName(json['status'] as String),
      notes: json['notes'] as String?,
      snapshotData: json['snapshot_data'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendor_id': vendorId,
      'client_id': clientId,
      'event_id': eventId,
      'invoice_number': invoiceNumber,
      'total_amount': totalAmount,
      'date_issued': dateIssued.toIso8601String(),
      'due_date': dueDate.toIso8601String(),
      'status': status.name,
      'notes': notes,
      'snapshot_data': snapshotData,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
