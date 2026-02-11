import 'package:app/features/invoices/data/datasources/payment_remote_datasource.dart';
import 'package:app/features/invoices/data/models/payment_model.dart';
import 'package:app/features/invoices/domain/entities/payment_entity.dart';
import 'package:app/features/invoices/domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDatasource _datasource;

  PaymentRepositoryImpl(this._datasource);

  @override
  Future<List<PaymentEntity>> getPayments(String invoiceId) {
    return _datasource.getPayments(invoiceId);
  }

  @override
  Future<PaymentEntity> recordPayment({required PaymentEntity payment}) {
    return _datasource.recordPayment(
      payment: PaymentModel(
        id: payment.id,
        invoiceId: payment.invoiceId,
        amount: payment.amount,
        method: payment.method,
        reference: payment.reference,
        notes: payment.notes,
        paidAt: payment.paidAt,
        createdAt: payment.createdAt,
      ),
    );
  }
}
