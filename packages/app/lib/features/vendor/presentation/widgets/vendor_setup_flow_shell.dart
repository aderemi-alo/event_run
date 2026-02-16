import 'package:app/core/theme/app_color_set.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/app_typography.dart';
import 'package:app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class VendorSetupFlowShell extends StatelessWidget {
  const VendorSetupFlowShell({
    super.key,
    required this.progress,
    required this.child,
  });

  final double progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: context.appColors.surfaceSecondary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                children: [
                  Text(
                    context.l10n.setupYourBusiness,
                    style: textTheme.headlineMedium?.vCopyWith(
                      fontWeight: AppFontWeight.bold,
                      color: context.appColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.l10n.setupBusinessSubtitle,
                    style: textTheme.bodyMedium?.vCopyWith(
                      color: context.appColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: context.appColors.borderLight,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.appColors.surfacePrimary,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: context.appColors.borderLight),
                      boxShadow: [
                        BoxShadow(
                          color: context.appColors.shadow,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: child,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
