import 'package:event_run/features/invoices/domain/repositories/invoice_repository.dart';

class DeleteInvoice {
  final InvoiceRepository _repository;

  DeleteInvoice(this._repository);

  Future<void> call(String invoiceId) {
    return _repository.deleteInvoice(invoiceId);
  }
}
