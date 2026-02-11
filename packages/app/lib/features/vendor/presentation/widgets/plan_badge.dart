import 'package:flutter/material.dart';
import 'package:app/core/theme/app_colors.dart';
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
        color: isPro ? AppColors.primary : AppColors.borderLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        plan.displayName,
        style: TextStyle(
          color: isPro ? AppColors.surfacePrimary : AppColors.textSecondary,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
