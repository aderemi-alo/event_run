import 'package:flutter/material.dart';
import 'package:app/core/utils/currency_formatter.dart';
import 'package:app/core/utils/date_formatter.dart';
import 'package:app/features/invoices/domain/entities/payment_entity.dart';

class PaymentHistoryList extends StatelessWidget {
  final List<PaymentEntity> payments;

  const PaymentHistoryList({super.key, required this.payments});

  @override
  Widget build(BuildContext context) {
    if (payments.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('No payments recorded yet.'),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: payments.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final payment = payments[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green.shade50,
            child: Icon(Icons.payment, color: Colors.green.shade700, size: 20),
          ),
          title: Text(
            CurrencyFormatter.formatNaira(payment.amount),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            '${payment.method.displayName} - ${DateFormatter.formatDate(payment.paidAt)}',
          ),
          trailing: payment.reference != null
              ? Text(
                  payment.reference!,
                  style: Theme.of(context).textTheme.bodySmall,
                )
              : null,
        );
      },
    );
  }
}
