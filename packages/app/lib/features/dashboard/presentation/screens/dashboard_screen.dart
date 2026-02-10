import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:event_run/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:event_run/features/dashboard/presentation/widgets/stats_card.dart';
import 'package:event_run/features/dashboard/presentation/widgets/upcoming_events_list.dart';
import 'package:event_run/features/dashboard/presentation/widgets/outstanding_invoices_list.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);
    final currencyFormat = NumberFormat.currency(symbol: '\$');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(dashboardStatsProvider);
          ref.invalidate(upcomingEventsProvider);
          ref.invalidate(outstandingInvoicesProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -------------------------------------------------------
              // Stats grid
              // -------------------------------------------------------
              statsAsync.when(
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 48),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (error, _) => Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    child: Column(
                      children: [
                        Icon(Icons.error_outline,
                            color: Colors.red[400], size: 48),
                        const SizedBox(height: 8),
                        Text(
                          'Failed to load dashboard stats',
                          style: TextStyle(color: Colors.red[400]),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () =>
                              ref.invalidate(dashboardStatsProvider),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
                data: (stats) => LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                    return GridView.count(
                      crossAxisCount: crossAxisCount,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.4,
                      children: [
                        StatsCard(
                          icon: Icons.attach_money,
                          title: 'Total Revenue',
                          value: currencyFormat.format(stats.totalRevenue),
                          color: Colors.teal,
                        ),
                        StatsCard(
                          icon: Icons.money_off,
                          title: 'Outstanding',
                          value:
                              currencyFormat.format(stats.outstandingAmount),
                          color: Colors.orange,
                        ),
                        StatsCard(
                          icon: Icons.event,
                          title: 'Total Events',
                          value: stats.totalEvents.toString(),
                          color: Colors.indigo,
                        ),
                        StatsCard(
                          icon: Icons.people,
                          title: 'Total Clients',
                          value: stats.totalClients.toString(),
                          color: Colors.teal,
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // -------------------------------------------------------
              // Upcoming events section
              // -------------------------------------------------------
              UpcomingEventsList(
                onViewAll: () {
                  // TODO: Navigate to events list screen
                },
              ),

              const SizedBox(height: 24),

              // -------------------------------------------------------
              // Outstanding invoices section
              // -------------------------------------------------------
              OutstandingInvoicesList(
                onViewAll: () {
                  // TODO: Navigate to invoices list screen
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
