import 'package:event_run/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:event_run/features/dashboard/domain/entities/dashboard_stats_entity.dart';
import 'package:event_run/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:event_run/features/events/domain/entities/event_entity.dart';
import 'package:event_run/features/invoices/domain/entities/invoice_entity.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDatasource remoteDatasource;

  const DashboardRepositoryImpl({required this.remoteDatasource});

  @override
  Future<DashboardStatsEntity> getDashboardStats(String vendorId) {
    return remoteDatasource.getDashboardStats(vendorId);
  }

  @override
  Future<List<EventEntity>> getUpcomingEvents(String vendorId) {
    return remoteDatasource.getUpcomingEvents(vendorId);
  }

  @override
  Future<List<InvoiceEntity>> getOutstandingInvoices(String vendorId) {
    return remoteDatasource.getOutstandingInvoices(vendorId);
  }
}
