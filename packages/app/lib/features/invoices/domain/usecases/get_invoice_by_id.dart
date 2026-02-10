import 'package:event_run/features/invoices/domain/entities/invoice_entity.dart';
import 'package:event_run/features/invoices/domain/repositories/invoice_repository.dart';

class GetInvoiceById {
  final InvoiceRepository _repository;

  GetInvoiceById(this._repository);

  Future<InvoiceEntity?> call(String invoiceId) {
    return _repository.getInvoiceById(invoiceId);
  }
}
