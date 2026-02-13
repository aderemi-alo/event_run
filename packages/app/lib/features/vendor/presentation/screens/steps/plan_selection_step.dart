import 'package:flutter/material.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/app_typography.dart';
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
          const VendorSetupStepHeader(
            icon: Icons.workspace_premium_outlined,
            title: 'Select a Plan',
          ),
          const SizedBox(height: 8),
          Text(
            'You can change plans later from subscription settings.',
            style: textTheme.bodyMedium?.vCopyWith(
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 24),
          _PlanCards(selectedPlan: selectedPlan, onPlanChanged: onPlanChanged),
          const SizedBox(height: 32),
          Row(
            children: [
              AppButton.ghost(
                label: 'Back',
                leading: Icons.arrow_back,
                expand: false,
                onPressed: onBack,
              ),
              const Spacer(),
              AppButton(
                label: selectedPlan == VendorPlan.pro
                    ? 'Proceed to Payment'
                    : 'Complete Setup',
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
      title: 'Starter',
      priceLabel: 'Free',
      priceSuffix: '',
      features: const ['5 Events/mo', 'Basic Invoices'],
      isRecommended: false,
      isSelected: selectedPlan == VendorPlan.free,
      onTap: () => onPlanChanged(VendorPlan.free),
    );

    final proCard = VendorPlanOptionCard(
      title: 'Pro Business',
      priceLabel: '₦6,000',
      priceSuffix: '/month',
      features: const [
        'Unlimited Events',
        'Unlimited Invoices',
        'Priority Support',
      ],
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
