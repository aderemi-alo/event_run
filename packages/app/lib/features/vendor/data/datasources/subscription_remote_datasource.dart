import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:event_run/core/constants/supabase_constants.dart';
import 'package:event_run/core/error/exceptions.dart';
import 'package:event_run/features/vendor/data/models/subscription_event_model.dart';

abstract class SubscriptionRemoteDatasource {
  Future<List<SubscriptionEventModel>> getSubscriptionEvents(String vendorId);
  Future<void> upgradeToPro({
    required String vendorId,
    required String reference,
    required num amount,
  });
}

class SubscriptionRemoteDatasourceImpl implements SubscriptionRemoteDatasource {
  final SupabaseClient _client;

  SubscriptionRemoteDatasourceImpl(this._client);

  @override
  Future<List<SubscriptionEventModel>> getSubscriptionEvents(
      String vendorId) async {
    try {
      final response = await _client
          .from(SupabaseConstants.subscriptionEvents)
          .select()
          .eq('vendor_id', vendorId)
          .order('created_at', ascending: false);

      return response
          .map((json) => SubscriptionEventModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> upgradeToPro({
    required String vendorId,
    required String reference,
    required num amount,
  }) async {
    try {
      final expiresAt =
          DateTime.now().add(const Duration(days: 365)).toIso8601String();

      await _client.from(SupabaseConstants.vendors).update({
        'plan': 'pro',
        'plan_expires_at': expiresAt,
      }).eq('id', vendorId);

      await _client.from(SupabaseConstants.subscriptionEvents).insert({
        'vendor_id': vendorId,
        'event_type': 'upgrade',
        'reference': reference,
        'amount': amount,
      });
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
