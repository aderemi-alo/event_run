import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app/core/router/route_names.dart';
import 'package:app/core/widgets/app_loading.dart';
import 'package:app/core/widgets/app_error_widget.dart';
import 'package:app/core/widgets/empty_state_widget.dart';
import 'package:app/features/events/presentation/providers/event_providers.dart';
import 'package:app/features/events/presentation/widgets/event_card.dart';

class EventsListScreen extends ConsumerWidget {
  const EventsListScreen({super.key, required this.vendorId});

  final String vendorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventsProvider(vendorId));

    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(RouteNames.eventForm),
        child: const Icon(Icons.add),
      ),
      body: eventsAsync.when(
        loading: () => const AppLoading(),
        error: (e, _) => AppErrorWidget(
          message: e.toString(),
          onRetry: () => ref.invalidate(eventsProvider(vendorId)),
        ),
        data: (events) {
          if (events.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.event_outlined,
              title: 'No events yet',
              subtitle: 'Create your first event to get started',
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(eventsProvider(vendorId));
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: events.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                return EventCard(
                  event: events[index],
                  onTap: () => context.pushNamed(
                    RouteNames.eventDetail,
                    pathParameters: {'id': events[index].id},
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
