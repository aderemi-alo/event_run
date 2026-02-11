import 'package:app/features/invoices/data/datasources/invoice_remote_datasource.dart';
import 'package:app/features/invoices/data/models/invoice_model.dart';
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:app/features/invoices/domain/repositories/invoice_repository.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final InvoiceRemoteDatasource _datasource;

  InvoiceRepositoryImpl(this._datasource);

  @override
  Future<List<InvoiceEntity>> getInvoices(String vendorId) {
    return _datasource.getInvoices(vendorId);
  }

  @override
  Future<InvoiceEntity?> getInvoiceById(String invoiceId) {
    return _datasource.getInvoiceById(invoiceId);
  }

  @override
  Future<InvoiceEntity> createInvoice({required InvoiceEntity invoice}) {
    return _datasource.createInvoice(
      invoice: InvoiceModel(
        id: invoice.id,
        vendorId: invoice.vendorId,
        clientId: invoice.clientId,
        eventId: invoice.eventId,
        invoiceNumber: invoice.invoiceNumber,
        items: invoice.items,
        totalAmount: invoice.totalAmount,
        dateIssued: invoice.dateIssued,
        dueDate: invoice.dueDate,
        status: invoice.status,
        notes: invoice.notes,
        snapshotData: invoice.snapshotData,
        createdAt: invoice.createdAt,
      ),
    );
  }

  @override
  Future<InvoiceEntity> updateInvoice({required InvoiceEntity invoice}) {
    return _datasource.updateInvoice(
      invoice: InvoiceModel(
        id: invoice.id,
        vendorId: invoice.vendorId,
        clientId: invoice.clientId,
        eventId: invoice.eventId,
        invoiceNumber: invoice.invoiceNumber,
        items: invoice.items,
        totalAmount: invoice.totalAmount,
        dateIssued: invoice.dateIssued,
        dueDate: invoice.dueDate,
        status: invoice.status,
        notes: invoice.notes,
        snapshotData: invoice.snapshotData,
        createdAt: invoice.createdAt,
      ),
    );
  }

  @override
  Future<void> deleteInvoice(String invoiceId) {
    return _datasource.deleteInvoice(invoiceId);
  }

  @override
  Future<void> markAsSent(String invoiceId) {
    return _datasource.markAsSent(invoiceId);
  }

  @override
  Future<void> markAsPaid(String invoiceId) {
    return _datasource.markAsPaid(invoiceId);
  }

  @override
  Future<List<InvoiceEntity>> getOverdueInvoices(String vendorId) {
    return _datasource.getOverdueInvoices(vendorId);
  }

  @override
  Future<List<InvoiceEntity>> getInvoicesByClient(String clientId) {
    return _datasource.getInvoicesByClient(clientId);
  }

  @override
  Future<String> generateInvoiceNumber(String vendorId) {
    return _datasource.generateInvoiceNumber(vendorId);
  }
}
