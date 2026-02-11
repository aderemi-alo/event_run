import 'package:flutter/material.dart';
import 'package:app/core/utils/currency_formatter.dart';
import 'package:app/core/utils/date_formatter.dart';
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:app/features/invoices/presentation/widgets/invoice_status_chip.dart';

class InvoiceCard extends StatelessWidget {
  final InvoiceEntity invoice;
  final VoidCallback? onTap;

  const InvoiceCard({super.key, required this.invoice, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    invoice.invoiceNumber,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InvoiceStatusChip(status: invoice.status),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                CurrencyFormatter.formatNaira(invoice.totalAmount),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Due ${DateFormatter.formatDate(invoice.dueDate)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
