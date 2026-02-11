import 'package:flutter/material.dart';
import 'package:app/core/utils/currency_formatter.dart';
import 'package:app/features/invoices/domain/entities/invoice_item_entity.dart';

class InvoiceItemRow extends StatelessWidget {
  final InvoiceItemEntity item;

  const InvoiceItemRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              item.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              '${item.quantity}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              CurrencyFormatter.formatNaira(item.unitPrice),
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              CurrencyFormatter.formatNaira(item.total),
              textAlign: TextAlign.right,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
