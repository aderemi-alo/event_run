import 'package:flutter/material.dart';
import 'package:event_run/features/invoices/domain/entities/invoice_entity.dart';

class InvoiceStatusChip extends StatelessWidget {
  final InvoiceStatus status;

  const InvoiceStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, bgColor) = switch (status) {
      InvoiceStatus.draft => (Colors.grey.shade700, Colors.grey.shade100),
      InvoiceStatus.sent => (Colors.blue.shade700, Colors.blue.shade50),
      InvoiceStatus.paid => (Colors.green.shade700, Colors.green.shade50),
      InvoiceStatus.overdue => (Colors.red.shade700, Colors.red.shade50),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
