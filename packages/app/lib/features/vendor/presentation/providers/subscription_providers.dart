import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:event_run/features/vendor/data/datasources/subscription_remote_datasource.dart';
import 'package:event_run/features/vendor/data/repositories/subscription_repository_impl.dart';
import 'package:event_run/features/vendor/domain/entities/subscription_event_entity.dart';
import 'package:event_run/features/vendor/domain/repositories/subscription_repository.dart';
import 'package:event_run/features/vendor/domain/usecases/upgrade_to_pro.dart';

// Datasource
final subscriptionRemoteDatasourceProvider =
    Provider<SubscriptionRemoteDatasource>((ref) {
  return SubscriptionRemoteDatasourceImpl(Supabase.instance.client);
});

// Repository
final subscriptionRepositoryProvider = Provider<SubscriptionRepository>((ref) {
  return SubscriptionRepositoryImpl(
      ref.watch(subscriptionRemoteDatasourceProvider));
});

// Usecases
final upgradeToProUsecaseProvider = Provider<UpgradeToPro>((ref) {
  return UpgradeToPro(ref.watch(subscriptionRepositoryProvider));
});

// Async state
final subscriptionEventsProvider = FutureProvider.autoDispose
    .family<List<SubscriptionEventEntity>, String>((ref, vendorId) {
  return ref.watch(subscriptionRepositoryProvider).getSubscriptionEvents(vendorId);
});
