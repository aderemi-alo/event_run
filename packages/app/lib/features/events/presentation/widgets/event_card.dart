import 'package:flutter/material.dart';
import 'package:event_run/core/utils/date_formatter.dart';
import 'package:event_run/features/events/domain/entities/event_entity.dart';
import 'package:event_run/features/events/presentation/widgets/event_status_chip.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event, this.onTap});

  final EventEntity event;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      event.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  EventStatusChip(status: event.status),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today,
                      size: 14,
                      color: theme.colorScheme.onSurface.withAlpha(153)),
                  const SizedBox(width: 4),
                  Text(
                    DateFormatter.formatDateShort(event.eventDate),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withAlpha(153),
                    ),
                  ),
                  if (event.location != null) ...[
                    const SizedBox(width: 16),
                    Icon(Icons.location_on_outlined,
                        size: 14,
                        color: theme.colorScheme.onSurface.withAlpha(153)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        event.location!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withAlpha(153),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
