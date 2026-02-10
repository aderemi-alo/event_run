import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:event_run/core/constants/supabase_constants.dart';
import 'package:event_run/core/error/exceptions.dart';
import 'package:event_run/features/invoices/data/models/invoice_model.dart';

abstract class InvoiceRemoteDatasource {
  Future<List<InvoiceModel>> getInvoices(String vendorId);
  Future<InvoiceModel?> getInvoiceById(String invoiceId);
  Future<InvoiceModel> createInvoice({required InvoiceModel invoice});
  Future<InvoiceModel> updateInvoice({required InvoiceModel invoice});
  Future<void> deleteInvoice(String invoiceId);
  Future<void> markAsSent(String invoiceId);
  Future<void> markAsPaid(String invoiceId);
  Future<List<InvoiceModel>> getOverdueInvoices(String vendorId);
  Future<List<InvoiceModel>> getInvoicesByClient(String clientId);
  Future<String> generateInvoiceNumber(String vendorId);
}

class InvoiceRemoteDatasourceImpl implements InvoiceRemoteDatasource {
  final SupabaseClient _client;

  InvoiceRemoteDatasourceImpl(this._client);

  @override
  Future<List<InvoiceModel>> getInvoices(String vendorId) async {
    try {
      final response = await _client
          .from(SupabaseConstants.invoices)
          .select('*, invoice_items(*)')
          .eq('vendor_id', vendorId)
          .order('created_at', ascending: false);

      return response.map((json) => InvoiceModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<InvoiceModel?> getInvoiceById(String invoiceId) async {
    try {
      final response = await _client
          .from(SupabaseConstants.invoices)
          .select('*, invoice_items(*)')
          .eq('id', invoiceId)
          .maybeSingle();

      if (response == null) return null;
      return InvoiceModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<InvoiceModel> createInvoice({required InvoiceModel invoice}) async {
    try {
      final response = await _client
          .from(SupabaseConstants.invoices)
          .insert(invoice.toJson())
          .select('*, invoice_items(*)')
          .single();

      return InvoiceModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<InvoiceModel> updateInvoice({required InvoiceModel invoice}) async {
    try {
      final response = await _client
          .from(SupabaseConstants.invoices)
          .update(invoice.toJson())
          .eq('id', invoice.id)
          .select('*, invoice_items(*)')
          .single();

      return InvoiceModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteInvoice(String invoiceId) async {
    try {
      await _client
          .from(SupabaseConstants.invoices)
          .delete()
          .eq('id', invoiceId);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> markAsSent(String invoiceId) async {
    try {
      await _client
          .from(SupabaseConstants.invoices)
          .update({'status': 'sent'}).eq('id', invoiceId);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> markAsPaid(String invoiceId) async {
    try {
      await _client
          .from(SupabaseConstants.invoices)
          .update({'status': 'paid'}).eq('id', invoiceId);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<InvoiceModel>> getOverdueInvoices(String vendorId) async {
    try {
      final response = await _client
          .from(SupabaseConstants.invoices)
          .select('*, invoice_items(*)')
          .eq('vendor_id', vendorId)
          .inFilter('status', ['sent', 'overdue'])
          .lt('due_date', DateTime.now().toIso8601String())
          .order('due_date');

      return response.map((json) => InvoiceModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<InvoiceModel>> getInvoicesByClient(String clientId) async {
    try {
      final response = await _client
          .from(SupabaseConstants.invoices)
          .select('*, invoice_items(*)')
          .eq('client_id', clientId)
          .order('created_at', ascending: false);

      return response.map((json) => InvoiceModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> generateInvoiceNumber(String vendorId) async {
    try {
      final response = await _client
          .from(SupabaseConstants.invoices)
          .select('id')
          .eq('vendor_id', vendorId);

      final count = (response as List).length + 1;
      return 'INV-${count.toString().padLeft(4, '0')}';
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
