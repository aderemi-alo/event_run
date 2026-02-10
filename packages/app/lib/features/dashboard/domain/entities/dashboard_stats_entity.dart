import 'package:equatable/equatable.dart';

class DashboardStatsEntity extends Equatable {
  final num totalRevenue;
  final num outstandingAmount;
  final int totalEvents;
  final int upcomingEvents;
  final int totalClients;
  final int totalInvoices;
  final int overdueInvoices;

  const DashboardStatsEntity({
    required this.totalRevenue,
    required this.outstandingAmount,
    required this.totalEvents,
    required this.upcomingEvents,
    required this.totalClients,
    required this.totalInvoices,
    required this.overdueInvoices,
  });

  @override
  List<Object?> get props => [
        totalRevenue,
        outstandingAmount,
        totalEvents,
        upcomingEvents,
        totalClients,
        totalInvoices,
        overdueInvoices,
      ];
}
