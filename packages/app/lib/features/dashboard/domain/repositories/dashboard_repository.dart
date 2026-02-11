import 'package:app/features/dashboard/domain/entities/dashboard_stats_entity.dart';
import 'package:app/features/events/domain/entities/event_entity.dart';
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';

abstract class DashboardRepository {
  Future<DashboardStatsEntity> getDashboardStats(String vendorId);
  Future<List<EventEntity>> getUpcomingEvents(String vendorId);
  Future<List<InvoiceEntity>> getOutstandingInvoices(String vendorId);
}
