import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:event_run/core/constants/supabase_constants.dart';
import 'package:event_run/core/error/exceptions.dart';
import 'package:event_run/features/invoices/data/models/payment_model.dart';

abstract class PaymentRemoteDatasource {
  Future<List<PaymentModel>> getPayments(String invoiceId);
  Future<PaymentModel> recordPayment({required PaymentModel payment});
}

class PaymentRemoteDatasourceImpl implements PaymentRemoteDatasource {
  final SupabaseClient _client;

  PaymentRemoteDatasourceImpl(this._client);

  @override
  Future<List<PaymentModel>> getPayments(String invoiceId) async {
    try {
      final response = await _client
          .from(SupabaseConstants.payments)
          .select()
          .eq('invoice_id', invoiceId)
          .order('paid_at', ascending: false);

      return response.map((json) => PaymentModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<PaymentModel> recordPayment({required PaymentModel payment}) async {
    try {
      final response = await _client
          .from(SupabaseConstants.payments)
          .insert(payment.toJson())
          .select()
          .single();

      return PaymentModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
