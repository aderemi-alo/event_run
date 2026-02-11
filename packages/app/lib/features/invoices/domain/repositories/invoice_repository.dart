import 'package:app/features/invoices/domain/entities/invoice_entity.dart';

abstract class InvoiceRepository {
  Future<List<InvoiceEntity>> getInvoices(String vendorId);
  Future<InvoiceEntity?> getInvoiceById(String invoiceId);
  Future<InvoiceEntity> createInvoice({required InvoiceEntity invoice});
  Future<InvoiceEntity> updateInvoice({required InvoiceEntity invoice});
  Future<void> deleteInvoice(String invoiceId);
  Future<void> markAsSent(String invoiceId);
  Future<void> markAsPaid(String invoiceId);
  Future<List<InvoiceEntity>> getOverdueInvoices(String vendorId);
  Future<List<InvoiceEntity>> getInvoicesByClient(String clientId);
  Future<String> generateInvoiceNumber(String vendorId);
}
