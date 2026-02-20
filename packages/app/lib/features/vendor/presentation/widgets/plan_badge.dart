import 'package:app/core/theme/app_color_set.dart';
import 'package:flutter/material.dart';
import 'package:app/features/vendor/domain/entities/vendor_entity.dart';

class PlanBadge extends StatelessWidget {
  const PlanBadge({super.key, required this.plan});

  final VendorPlan plan;

  @override
  Widget build(BuildContext context) {
    final isPro = plan == VendorPlan.pro;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isPro ? context.colors.primary : context.colors.borderLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        plan.displayName,
        style: TextStyle(
          color: isPro
              ? context.colors.surfacePrimary
              : context.colors.textSecondary,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
