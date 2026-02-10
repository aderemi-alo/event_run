import 'package:event_run/features/dashboard/data/models/dashboard_stats_model.dart';
import 'package:event_run/features/events/data/models/event_model.dart';
import 'package:event_run/features/invoices/data/models/invoice_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class DashboardRemoteDatasource {
  Future<DashboardStatsModel> getDashboardStats(String vendorId);
  Future<List<EventModel>> getUpcomingEvents(String vendorId);
  Future<List<InvoiceModel>> getOutstandingInvoices(String vendorId);
}

class DashboardRemoteDatasourceImpl implements DashboardRemoteDatasource {
  final SupabaseClient supabaseClient;

  const DashboardRemoteDatasourceImpl({required this.supabaseClient});

  @override
  Future<DashboardStatsModel> getDashboardStats(String vendorId) async {
    // Query the dashboard_stats view for aggregated vendor statistics.
    // Falls back to zero-valued stats if no data is found.
    final response = await supabaseClient
        .from('dashboard_stats')
        .select()
        .eq('vendor_id', vendorId)
        .maybeSingle();

    if (response != null) {
      return DashboardStatsModel.fromJson(response);
    }

    // Return default empty stats if no view data exists
    return const DashboardStatsModel(
      totalRevenue: 0,
      outstandingAmount: 0,
      totalEvents: 0,
      upcomingEvents: 0,
      totalClients: 0,
      totalInvoices: 0,
      overdueInvoices: 0,
    );
  }

  @override
  Future<List<EventModel>> getUpcomingEvents(String vendorId) async {
    final now = DateTime.now().toIso8601String();

    final response = await supabaseClient
        .from('events')
        .select()
        .eq('vendor_id', vendorId)
        .gt('event_date', now)
        .order('event_date', ascending: true)
        .limit(5);

    return (response as List<dynamic>)
        .map((json) => EventModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<InvoiceModel>> getOutstandingInvoices(String vendorId) async {
    final response = await supabaseClient
        .from('invoices')
        .select()
        .eq('vendor_id', vendorId)
        .inFilter('status', ['sent', 'overdue'])
        .order('due_date', ascending: true);

    return (response as List<dynamic>)
        .map((json) => InvoiceModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
