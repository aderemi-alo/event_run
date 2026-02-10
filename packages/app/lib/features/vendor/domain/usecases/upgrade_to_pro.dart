import 'package:event_run/features/vendor/domain/repositories/subscription_repository.dart';

class UpgradeToPro {
  final SubscriptionRepository _repository;

  UpgradeToPro(this._repository);

  Future<void> call({
    required String vendorId,
    required String reference,
    required num amount,
  }) {
    return _repository.upgradeToPro(
      vendorId: vendorId,
      reference: reference,
      amount: amount,
    );
  }
}
