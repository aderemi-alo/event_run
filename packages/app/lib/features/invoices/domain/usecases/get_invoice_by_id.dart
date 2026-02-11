import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:app/features/invoices/domain/repositories/invoice_repository.dart';

class GetInvoiceById {
  final InvoiceRepository _repository;

  GetInvoiceById(this._repository);

  Future<InvoiceEntity?> call(String invoiceId) {
    return _repository.getInvoiceById(invoiceId);
  }
}
