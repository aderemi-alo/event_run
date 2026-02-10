import 'package:event_run/features/invoices/domain/entities/invoice_entity.dart';
import 'package:event_run/features/invoices/domain/repositories/invoice_repository.dart';

class CreateInvoice {
  final InvoiceRepository _repository;

  CreateInvoice(this._repository);

  Future<InvoiceEntity> call({required InvoiceEntity invoice}) {
    return _repository.createInvoice(invoice: invoice);
  }
}
