import 'package:event_run/features/vendor/data/datasources/subscription_remote_datasource.dart';
import 'package:event_run/features/vendor/domain/entities/subscription_event_entity.dart';
import 'package:event_run/features/vendor/domain/repositories/subscription_repository.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionRemoteDatasource _datasource;

  SubscriptionRepositoryImpl(this._datasource);

  @override
  Future<List<SubscriptionEventEntity>> getSubscriptionEvents(
      String vendorId) {
    return _datasource.getSubscriptionEvents(vendorId);
  }

  @override
  Future<void> upgradeToPro({
    required String vendorId,
    required String reference,
    required num amount,
  }) {
    return _datasource.upgradeToPro(
      vendorId: vendorId,
      reference: reference,
      amount: amount,
    );
  }
}
