import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/features/auth/presentation/providers/auth_state_provider.dart';

import 'package:app/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:app/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:app/features/dashboard/domain/entities/dashboard_stats_entity.dart';
import 'package:app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:app/features/dashboard/domain/usecases/get_dashboard_stats.dart';
import 'package:app/features/dashboard/domain/usecases/get_outstanding_invoices.dart';
import 'package:app/features/dashboard/domain/usecases/get_upcoming_events.dart';
import 'package:app/features/events/domain/entities/event_entity.dart';
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';

// ---------------------------------------------------------------------------
// Data layer providers
// ---------------------------------------------------------------------------

final dashboardRemoteDatasourceProvider = Provider<DashboardRemoteDatasource>((
  ref,
) {
  return DashboardRemoteDatasourceImpl(
    supabaseClient: Supabase.instance.client,
  );
});

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepositoryImpl(
    remoteDatasource: ref.watch(dashboardRemoteDatasourceProvider),
  );
});

// ---------------------------------------------------------------------------
// Use-case providers
// ---------------------------------------------------------------------------

final getDashboardStatsProvider = Provider<GetDashboardStats>((ref) {
  return GetDashboardStats(ref.watch(dashboardRepositoryProvider));
});

final getUpcomingEventsProvider = Provider<GetUpcomingEvents>((ref) {
  return GetUpcomingEvents(ref.watch(dashboardRepositoryProvider));
});

final getOutstandingInvoicesProvider = Provider<GetOutstandingInvoices>((ref) {
  return GetOutstandingInvoices(ref.watch(dashboardRepositoryProvider));
});

// ---------------------------------------------------------------------------
// Async data providers
// ---------------------------------------------------------------------------

final dashboardStatsProvider = FutureProvider.autoDispose<DashboardStatsEntity>(
  (ref) async {
    final vendorId = ref.watch(currentVendorIdProvider);
    if (vendorId == null) {
      throw StateError('Vendor profile not found for current user.');
    }
    return ref.watch(getDashboardStatsProvider).call(vendorId);
  },
);

final upcomingEventsProvider = FutureProvider.autoDispose<List<EventEntity>>((
  ref,
) async {
  final vendorId = ref.watch(currentVendorIdProvider);
  if (vendorId == null) {
    throw StateError('Vendor profile not found for current user.');
  }
  return ref.watch(getUpcomingEventsProvider).call(vendorId);
});

final outstandingInvoicesProvider =
    FutureProvider.autoDispose<List<InvoiceEntity>>((ref) async {
      final vendorId = ref.watch(currentVendorIdProvider);
      if (vendorId == null) {
        throw StateError('Vendor profile not found for current user.');
      }
      return ref.watch(getOutstandingInvoicesProvider).call(vendorId);
    });
