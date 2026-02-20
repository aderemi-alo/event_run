import 'package:app/core/theme/app_color_set.dart';
import 'package:flutter/material.dart';
import 'package:app/features/events/domain/entities/event_entity.dart';

class EventStatusChip extends StatelessWidget {
  const EventStatusChip({super.key, required this.status});

  final EventStatus status;

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color fg) = switch (status) {
      EventStatus.draft => (
        context.colors.info.withAlpha(30),
        context.colors.info,
      ),
      EventStatus.confirmed => (
        context.colors.warning.withAlpha(30),
        context.colors.warning,
      ),
      EventStatus.completed => (
        context.colors.success.withAlpha(30),
        context.colors.success,
      ),
      EventStatus.cancelled => (
        context.colors.error.withAlpha(30),
        context.colors.error,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
