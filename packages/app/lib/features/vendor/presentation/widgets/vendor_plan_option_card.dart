import 'package:app/core/theme/app_color_set.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/app_typography.dart';
import 'package:app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class VendorPlanOptionCard extends StatelessWidget {
  const VendorPlanOptionCard({
    super.key,
    required this.title,
    required this.priceLabel,
    required this.priceSuffix,
    required this.features,
    required this.isRecommended,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String priceLabel;
  final String priceSuffix;
  final List<String> features;
  final bool isRecommended;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? context.appColors.primarySurface
              : context.appColors.surfacePrimary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? context.appColors.primaryLight
                : context.appColors.borderLight,
            width: 2,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (isRecommended)
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: context.appColors.primary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    context.l10n.recommended,
                    style: textTheme.labelSmall?.vCopyWith(
                      color: context.appColors.onPrimary,
                      fontWeight: AppFontWeight.bold,
                    ),
                  ),
                ),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleLarge?.vCopyWith(
                        fontWeight: AppFontWeight.bold,
                        color: context.appColors.textPrimary,
                      ),
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        color: context.appColors.primary,
                        size: 24,
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      priceLabel,
                      style: textTheme.displaySmall?.vCopyWith(
                        fontWeight: AppFontWeight.extraBold,
                        color: context.appColors.textPrimary,
                      ),
                    ),
                    if (priceSuffix.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 6),
                        child: Text(
                          priceSuffix,
                          style: textTheme.bodyMedium?.vCopyWith(
                            color: context.appColors.textTertiary,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                ...features.map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 16,
                          color: isSelected
                              ? context.appColors.primary
                              : context.appColors.textHint,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            feature,
                            style: textTheme.bodyMedium?.vCopyWith(
                              color: context.appColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
