import 'package:app/features/invoices/domain/entities/payment_entity.dart';
import 'package:app/features/invoices/domain/repositories/payment_repository.dart';

class RecordPayment {
  final PaymentRepository _repository;

  RecordPayment(this._repository);

  Future<PaymentEntity> call({required PaymentEntity payment}) {
    return _repository.recordPayment(payment: payment);
  }
}
