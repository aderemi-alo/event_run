import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/features/invoices/data/datasources/payment_remote_datasource.dart';
import 'package:app/features/invoices/data/repositories/payment_repository_impl.dart';
import 'package:app/features/invoices/domain/usecases/record_payment.dart';

final paymentRemoteDatasourceProvider = Provider<PaymentRemoteDatasource>(
  (ref) => PaymentRemoteDatasourceImpl(Supabase.instance.client),
);

final paymentRepositoryProvider = Provider(
  (ref) => PaymentRepositoryImpl(ref.read(paymentRemoteDatasourceProvider)),
);

final recordPaymentProvider = Provider(
  (ref) => RecordPayment(ref.read(paymentRepositoryProvider)),
);

final paymentsProvider = FutureProvider.autoDispose.family(
  (ref, String invoiceId) =>
      ref.read(paymentRemoteDatasourceProvider).getPayments(invoiceId),
);
