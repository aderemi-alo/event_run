import 'package:app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';

class GetOutstandingInvoices {
  final DashboardRepository repository;

  const GetOutstandingInvoices(this.repository);

  Future<List<InvoiceEntity>> call(String vendorId) {
    return repository.getOutstandingInvoices(vendorId);
  }
}
