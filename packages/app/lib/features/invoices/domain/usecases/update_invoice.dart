import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:app/features/invoices/domain/repositories/invoice_repository.dart';

class UpdateInvoice {
  final InvoiceRepository _repository;

  UpdateInvoice(this._repository);

  Future<InvoiceEntity> call({required InvoiceEntity invoice}) {
    return _repository.updateInvoice(invoice: invoice);
  }
}
