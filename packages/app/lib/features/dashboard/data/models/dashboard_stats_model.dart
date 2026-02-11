import 'package:app/features/dashboard/domain/entities/dashboard_stats_entity.dart';

class DashboardStatsModel extends DashboardStatsEntity {
  const DashboardStatsModel({
    required super.totalRevenue,
    required super.outstandingAmount,
    required super.totalEvents,
    required super.upcomingEvents,
    required super.totalClients,
    required super.totalInvoices,
    required super.overdueInvoices,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      totalRevenue: json['total_revenue'] as num? ?? 0,
      outstandingAmount: json['outstanding_amount'] as num? ?? 0,
      totalEvents: json['total_events'] as int? ?? 0,
      upcomingEvents: json['upcoming_events'] as int? ?? 0,
      totalClients: json['total_clients'] as int? ?? 0,
      totalInvoices: json['total_invoices'] as int? ?? 0,
      overdueInvoices: json['overdue_invoices'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_revenue': totalRevenue,
      'outstanding_amount': outstandingAmount,
      'total_events': totalEvents,
      'upcoming_events': upcomingEvents,
      'total_clients': totalClients,
      'total_invoices': totalInvoices,
      'overdue_invoices': overdueInvoices,
    };
  }
}
