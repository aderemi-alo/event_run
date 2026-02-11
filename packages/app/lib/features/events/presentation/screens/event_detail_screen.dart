import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app/core/router/route_names.dart';
import 'package:app/core/utils/currency_formatter.dart';
import 'package:app/core/utils/date_formatter.dart';
import 'package:app/core/widgets/app_loading.dart';
import 'package:app/core/widgets/app_error_widget.dart';
import 'package:app/features/events/presentation/providers/event_providers.dart';
import 'package:app/features/events/presentation/widgets/event_status_chip.dart';

class EventDetailScreen extends ConsumerWidget {
  const EventDetailScreen({super.key, required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventDetailProvider(eventId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.pushNamed(
              RouteNames.eventForm,
              pathParameters: {'id': eventId},
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'requirements') {
                context.pushNamed(
                  RouteNames.eventRequirements,
                  pathParameters: {'id': eventId},
                );
              } else if (value == 'delete') {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Delete Event'),
                    content: const Text(
                      'Are you sure you want to delete this event?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
                if (confirmed == true && context.mounted) {
                  await ref.read(deleteEventUsecaseProvider).call(eventId);
                  if (context.mounted) context.pop();
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'requirements',
                child: Text('Requirements'),
              ),
              const PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
      body: eventAsync.when(
        loading: () => const AppLoading(),
        error: (e, _) => AppErrorWidget(
          message: e.toString(),
          onRetry: () => ref.invalidate(eventDetailProvider(eventId)),
        ),
        data: (event) {
          if (event == null) {
            return const AppErrorWidget(message: 'Event not found');
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                event.name,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              EventStatusChip(status: event.status),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DetailRow(
                        icon: Icons.calendar_today,
                        label: 'Date',
                        value: DateFormatter.formatDateWithDay(event.eventDate),
                      ),
                      if (event.location != null)
                        _DetailRow(
                          icon: Icons.location_on_outlined,
                          label: 'Location',
                          value: event.location!,
                        ),
                      if (event.revenue != null)
                        _DetailRow(
                          icon: Icons.attach_money,
                          label: 'Revenue',
                          value: CurrencyFormatter.formatNaira(
                            event.revenue!.toDouble(),
                          ),
                        ),

                      if (event.notes != null) ...[
                        const Divider(height: 24),
                        Text('Notes', style: theme.textTheme.labelMedium),
                        const SizedBox(height: 4),
                        Text(event.notes!),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(153),
                ),
              ),
              Text(value),
            ],
          ),
        ],
      ),
    );
  }
}
