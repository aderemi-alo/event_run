import 'package:event_run/features/vendor/domain/entities/subscription_event_entity.dart';

abstract class SubscriptionRepository {
  Future<List<SubscriptionEventEntity>> getSubscriptionEvents(String vendorId);
  Future<void> upgradeToPro({
    required String vendorId,
    required String reference,
    required num amount,
  });
}
