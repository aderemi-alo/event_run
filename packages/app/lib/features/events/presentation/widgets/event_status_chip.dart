import 'package:flutter/material.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/events/domain/entities/event_entity.dart';

class EventStatusChip extends StatelessWidget {
  const EventStatusChip({super.key, required this.status});

  final EventStatus status;

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color fg) = switch (status) {
      EventStatus.draft => (AppColors.info.withAlpha(30), AppColors.info),
      EventStatus.confirmed => (
        AppColors.warning.withAlpha(30),
        AppColors.warning,
      ),
      EventStatus.completed => (
        AppColors.success.withAlpha(30),
        AppColors.success,
      ),
      EventStatus.cancelled => (AppColors.error.withAlpha(30), AppColors.error),
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
