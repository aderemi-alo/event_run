import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:app/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';

class OutstandingInvoicesList extends ConsumerWidget {
  final VoidCallback? onViewAll;

  const OutstandingInvoicesList({super.key, this.onViewAll});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoicesAsync = ref.watch(outstandingInvoicesProvider);
    final theme = Theme.of(context);
    final currencyFormat = NumberFormat.currency(symbol: '\$');
    final dateFormat = DateFormat('MMM d, yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Outstanding Invoices',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (onViewAll != null)
              TextButton(
                onPressed: onViewAll,
                child: const Text(
                  'View all',
                  style: TextStyle(color: Colors.teal),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        invoicesAsync.when(
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Failed to load outstanding invoices',
                style: TextStyle(color: Colors.red[400]),
              ),
            ),
          ),
          data: (invoices) {
            if (invoices.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: Text('No outstanding invoices')),
              );
            }
            return Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: invoices.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final invoice = invoices[index];
                  return _OutstandingInvoiceTile(
                    invoice: invoice,
                    currencyFormat: currencyFormat,
                    dateFormat: dateFormat,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class _OutstandingInvoiceTile extends StatelessWidget {
  final InvoiceEntity invoice;
  final NumberFormat currencyFormat;
  final DateFormat dateFormat;

  const _OutstandingInvoiceTile({
    required this.invoice,
    required this.currencyFormat,
    required this.dateFormat,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOverdue = invoice.status == 'overdue';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: (isOverdue ? Colors.red : Colors.orange).withValues(
            alpha: 0.1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.receipt_long,
          color: isOverdue ? Colors.red : Colors.orange,
          size: 20,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            invoice.invoiceNumber,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            currencyFormat.format(invoice.totalAmount),
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isOverdue ? Colors.red : Colors.teal,
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person, size: 14, color: Colors.grey[500]),
                  const SizedBox(width: 4),
                  Text(invoice.clientId, style: theme.textTheme.bodySmall),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isOverdue
                      ? Colors.red.withValues(alpha: 0.1)
                      : Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  invoice.status.name.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isOverdue ? Colors.red : Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: Colors.grey[500]),
              const SizedBox(width: 4),
              Text(
                'Due: ${dateFormat.format(invoice.dueDate)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isOverdue ? Colors.red[400] : null,
                ),
              ),
            ],
          ),
        ],
      ),
      isThreeLine: true,
    );
  }
}
