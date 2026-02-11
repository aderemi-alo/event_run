import 'package:app/features/invoices/domain/entities/payment_entity.dart';

abstract class PaymentRepository {
  Future<List<PaymentEntity>> getPayments(String invoiceId);
  Future<PaymentEntity> recordPayment({required PaymentEntity payment});
}
