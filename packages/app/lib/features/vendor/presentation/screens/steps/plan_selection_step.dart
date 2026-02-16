import 'package:app/core/theme/app_color_set.dart';
import 'package:flutter/material.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/app_typography.dart';
import 'package:app/core/utils/extensions.dart';
import 'package:app/features/vendor/domain/entities/vendor_entity.dart';
import 'package:app/features/vendor/presentation/widgets/vendor_plan_option_card.dart';
import 'package:app/features/vendor/presentation/widgets/vendor_setup_step_header.dart';
import 'package:app/shared/widgets/app_button.dart';

class PlanSelectionStep extends StatelessWidget {
  const PlanSelectionStep({
    super.key,
    required this.selectedPlan,
    required this.isSubmitting,
    required this.onPlanChanged,
    required this.onSubmit,
    required this.onBack,
  });

  final VendorPlan selectedPlan;
  final bool isSubmitting;
  final ValueChanged<VendorPlan> onPlanChanged;
  final VoidCallback onSubmit;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VendorSetupStepHeader(
            icon: Icons.workspace_premium_outlined,
            title: context.l10n.selectPlan,
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.selectPlanSubtitle,
            style: textTheme.bodyMedium?.vCopyWith(
              color: context.appColors.textTertiary,
            ),
          ),
          const SizedBox(height: 24),
          _PlanCards(selectedPlan: selectedPlan, onPlanChanged: onPlanChanged),
          const SizedBox(height: 32),
          Row(
            children: [
              AppButton.ghost(
                label: context.l10n.common_cancel.vToTitleCase(),
                leading: Icons.arrow_back,
                expand: false,
                onPressed: onBack,
              ),
              const Spacer(),
              AppButton(
                label: selectedPlan == VendorPlan.pro
                    ? context.l10n.proceedToPayment
                    : context.l10n.completeSetup,
                expand: false,
                loading: isSubmitting,
                onPressed: isSubmitting ? null : onSubmit,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlanCards extends StatelessWidget {
  const _PlanCards({required this.selectedPlan, required this.onPlanChanged});

  final VendorPlan selectedPlan;
  final ValueChanged<VendorPlan> onPlanChanged;

  @override
  Widget build(BuildContext context) {
    final starterCard = VendorPlanOptionCard(
      title: context.l10n.starterPlan,
      priceLabel: context.l10n.free,
      priceSuffix: '',
      features: context.l10n.starterFeatures.split(', '),
      isRecommended: false,
      isSelected: selectedPlan == VendorPlan.free,
      onTap: () => onPlanChanged(VendorPlan.free),
    );

    final proCard = VendorPlanOptionCard(
      title: context.l10n.proBusinessPlan,
      priceLabel: context.l10n.proPrice,
      priceSuffix: context.l10n.monthSuffix,
      features: context.l10n.proFeatures.split(', '),
      isRecommended: true,
      isSelected: selectedPlan == VendorPlan.pro,
      onTap: () => onPlanChanged(VendorPlan.pro),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 520) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: starterCard),
              const SizedBox(width: 12),
              Expanded(child: proCard),
            ],
          );
        }
        return Column(
          children: [starterCard, const SizedBox(height: 12), proCard],
        );
      },
    );
  }
}
