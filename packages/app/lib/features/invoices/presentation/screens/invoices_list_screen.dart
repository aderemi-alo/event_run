import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:event_run/core/router/route_names.dart';
import 'package:event_run/core/widgets/app_error_widget.dart';
import 'package:event_run/core/widgets/app_loading.dart';
import 'package:event_run/core/widgets/empty_state_widget.dart';
import 'package:event_run/features/invoices/domain/entities/invoice_entity.dart';
import 'package:event_run/features/invoices/presentation/providers/invoice_providers.dart';
import 'package:event_run/features/invoices/presentation/widgets/invoice_card.dart';

class InvoicesListScreen extends ConsumerStatefulWidget {
  final String vendorId;

  const InvoicesListScreen({super.key, required this.vendorId});

  @override
  ConsumerState<InvoicesListScreen> createState() => _InvoicesListScreenState();
}

class _InvoicesListScreenState extends ConsumerState<InvoicesListScreen> {
  InvoiceStatus? _filterStatus;

  @override
  Widget build(BuildContext context) {
    final invoicesAsync = ref.watch(invoicesProvider(widget.vendorId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
        actions: [
          PopupMenuButton<InvoiceStatus?>(
            icon: const Icon(Icons.filter_list),
            onSelected: (status) => setState(() => _filterStatus = status),
            itemBuilder: (_) => [
              const PopupMenuItem(value: null, child: Text('All')),
              ...InvoiceStatus.values.map(
                (s) => PopupMenuItem(value: s, child: Text(s.displayName)),
              ),
            ],
          ),
        ],
      ),
      body: invoicesAsync.when(
        loading: () => const AppLoading(),
        error: (error, _) => AppErrorWidget(
          message: error.toString(),
          onRetry: () => ref.invalidate(invoicesProvider(widget.vendorId)),
        ),
        data: (invoices) {
          final filtered = _filterStatus != null
              ? invoices.where((i) => i.status == _filterStatus).toList()
              : invoices;

          if (filtered.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.receipt_long,
              title: 'No invoices yet',
              subtitle: 'Create your first invoice to get started.',
            );
          }

          return RefreshIndicator(
            onRefresh: () async =>
                ref.invalidate(invoicesProvider(widget.vendorId)),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final invoice = filtered[index];
                return InvoiceCard(
                  invoice: invoice,
                  onTap: () => context.pushNamed(
                    RouteNames.invoiceDetail,
                    pathParameters: {'invoiceId': invoice.id},
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(RouteNames.invoiceForm),
        child: const Icon(Icons.add),
      ),
    );
  }
}
