import 'package:app/core/theme/app_color_set.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class VendorSetupStepHeader extends StatelessWidget {
  const VendorSetupStepHeader({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 24, color: colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: textTheme.headlineSmall?.vCopyWith(
                fontWeight: AppFontWeight.bold,
              ),
            ),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: textTheme.bodyMedium?.vCopyWith(
              color: context.appColors.textTertiary,
            ),
          ),
        ],
      ],
    );
  }
}
