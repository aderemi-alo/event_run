import 'package:event_run/features/invoices/domain/entities/invoice_entity.dart';
import 'package:event_run/features/invoices/domain/repositories/invoice_repository.dart';

class GetInvoices {
  final InvoiceRepository _repository;

  GetInvoices(this._repository);

  Future<List<InvoiceEntity>> call(String vendorId) {
    return _repository.getInvoices(vendorId);
  }
}
