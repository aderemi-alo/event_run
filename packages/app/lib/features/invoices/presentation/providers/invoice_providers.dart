import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/features/invoices/data/datasources/invoice_remote_datasource.dart';
import 'package:app/features/invoices/data/repositories/invoice_repository_impl.dart';
import 'package:app/features/invoices/domain/usecases/get_invoices.dart';
import 'package:app/features/invoices/domain/usecases/get_invoice_by_id.dart';
import 'package:app/features/invoices/domain/usecases/create_invoice.dart';
import 'package:app/features/invoices/domain/usecases/update_invoice.dart';
import 'package:app/features/invoices/domain/usecases/delete_invoice.dart';

final invoiceRemoteDatasourceProvider = Provider<InvoiceRemoteDatasource>(
  (ref) => InvoiceRemoteDatasourceImpl(Supabase.instance.client),
);

final invoiceRepositoryProvider = Provider(
  (ref) => InvoiceRepositoryImpl(ref.read(invoiceRemoteDatasourceProvider)),
);

final getInvoicesProvider = Provider(
  (ref) => GetInvoices(ref.read(invoiceRepositoryProvider)),
);

final getInvoiceByIdProvider = Provider(
  (ref) => GetInvoiceById(ref.read(invoiceRepositoryProvider)),
);

final createInvoiceProvider = Provider(
  (ref) => CreateInvoice(ref.read(invoiceRepositoryProvider)),
);

final updateInvoiceProvider = Provider(
  (ref) => UpdateInvoice(ref.read(invoiceRepositoryProvider)),
);

final deleteInvoiceProvider = Provider(
  (ref) => DeleteInvoice(ref.read(invoiceRepositoryProvider)),
);

final invoicesProvider = FutureProvider.autoDispose.family(
  (ref, String vendorId) => ref.read(getInvoicesProvider).call(vendorId),
);

final invoiceDetailProvider = FutureProvider.autoDispose.family(
  (ref, String invoiceId) => ref.read(getInvoiceByIdProvider).call(invoiceId),
);
