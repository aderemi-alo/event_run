import 'package:flutter/material.dart';
import 'package:event_run/core/constants/app_colors.dart';
import 'package:event_run/core/constants/app_spacing.dart';

/// Status badge widget for Events and Invoices
class StatusBadge extends StatelessWidget {
  const StatusBadge({required this.status, required this.type, super.key});

  final String status;
  final String type; // 'event' or 'invoice'

  Color _getBackgroundColor() {
    if (type == 'event') {
      switch (status.toUpperCase()) {
        case 'COVERED':
          return AppColors.success.withValues(alpha: 0.1);
        case 'ATTENTION':
          return AppColors.warning.withValues(alpha: 0.1);
        case 'CONFLICT':
          return AppColors.error.withValues(alpha: 0.1);
        default:
          return AppColors.slate100;
      }
    } else {
      // invoice statuses
      switch (status.toUpperCase()) {
        case 'PAID':
          return AppColors.success.withValues(alpha: 0.1);
        case 'SENT':
          return AppColors.info.withValues(alpha: 0.1);
        case 'DRAFT':
          return AppColors.slate100;
        case 'OVERDUE':
          return AppColors.error.withValues(alpha: 0.1);
        default:
          return AppColors.slate100;
      }
    }
  }

  Color _getTextColor() {
    if (type == 'event') {
      switch (status.toUpperCase()) {
        case 'COVERED':
          return AppColors.success;
        case 'ATTENTION':
          return AppColors.warning;
        case 'CONFLICT':
          return AppColors.error;
        default:
          return AppColors.slate600;
      }
    } else {
      // invoice statuses
      switch (status.toUpperCase()) {
        case 'PAID':
          return AppColors.success;
        case 'SENT':
          return AppColors.info;
        case 'DRAFT':
          return AppColors.slate600;
        case 'OVERDUE':
          return AppColors.error;
        default:
          return AppColors.slate600;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + 2,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        status.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: _getTextColor(),
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    );
  }
}
