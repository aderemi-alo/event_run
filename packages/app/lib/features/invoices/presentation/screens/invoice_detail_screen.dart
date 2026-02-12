import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app/core/router/route_names.dart';
import 'package:app/core/utils/currency_formatter.dart';
import 'package:app/core/utils/date_formatter.dart';
import 'package:app/core/widgets/app_error_widget.dart';
import 'package:app/core/widgets/app_loading.dart';
import 'package:app/features/invoices/presentation/providers/invoice_providers.dart';
import 'package:app/features/invoices/presentation/providers/payment_providers.dart';
import 'package:app/features/invoices/presentation/widgets/invoice_item_row.dart';
import 'package:app/features/invoices/presentation/widgets/invoice_status_chip.dart';
import 'package:app/features/invoices/presentation/widgets/payment_history_list.dart';

class InvoiceDetailScreen extends ConsumerWidget {
  final String invoiceId;

  const InvoiceDetailScreen({super.key, required this.invoiceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoiceAsync = ref.watch(invoiceDetailProvider(invoiceId));
    final paymentsAsync = ref.watch(paymentsProvider(invoiceId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.preview),
            onPressed: () => context.pushNamed(
              RouteNames.invoicePreview,
              pathParameters: {'id': invoiceId},
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (action) => _handleAction(context, ref, action),
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              const PopupMenuItem(value: 'send', child: Text('Mark as Sent')),
              const PopupMenuItem(value: 'paid', child: Text('Mark as Paid')),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
      body: invoiceAsync.when(
        loading: () => const AppLoading(),
        error: (error, _) => AppErrorWidget(
          message: error.toString(),
          onRetry: () => ref.invalidate(invoiceDetailProvider(invoiceId)),
        ),
        data: (invoice) {
          if (invoice == null) {
            return const Center(child: Text('Invoice not found.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      invoice.invoiceNumber,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    InvoiceStatusChip(status: invoice.status),
                  ],
                ),
                const SizedBox(height: 16),

                // Dates
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _InfoRow(
                          label: 'Date Issued',
                          value: DateFormatter.formatDate(invoice.dateIssued),
                        ),
                        const SizedBox(height: 8),
                        _InfoRow(
                          label: 'Due Date',
                          value: DateFormatter.formatDate(invoice.dueDate),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Items
                Text(
                  'Items',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Header row
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Description',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                            SizedBox(
                              width: 40,
                              child: Text(
                                'Qty',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Price',
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Total',
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        ...invoice.items.map(
                          (item) => InvoiceItemRow(item: item),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Total: ${CurrencyFormatter.formatNaira(invoice.totalAmount)}',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Notes
                if (invoice.notes != null && invoice.notes!.isNotEmpty) ...[
                  Text(
                    'Notes',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(invoice.notes!),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Payments
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payments',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => context.pushNamed(
                        RouteNames.recordPayment,
                        pathParameters: {'id': invoiceId},
                      ),
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Record Payment'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Card(
                  child: paymentsAsync.when(
                    loading: () => const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (e, _) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text('Error loading payments: $e'),
                    ),
                    data: (payments) => PaymentHistoryList(payments: payments),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handleAction(BuildContext context, WidgetRef ref, String action) async {
    final repo = ref.read(invoiceRepositoryProvider);
    switch (action) {
      case 'edit':
        context.pushNamed(
          RouteNames.invoiceForm,
          pathParameters: {'id': invoiceId},
        );
      case 'send':
        await repo.markAsSent(invoiceId);
        ref.invalidate(invoiceDetailProvider(invoiceId));
      case 'paid':
        await repo.markAsPaid(invoiceId);
        ref.invalidate(invoiceDetailProvider(invoiceId));
      case 'delete':
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Delete Invoice'),
            content: const Text(
              'Are you sure you want to delete this invoice?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
        if (confirmed == true && context.mounted) {
          await repo.deleteInvoice(invoiceId);
          context.pop();
        }
    }
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
