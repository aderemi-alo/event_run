import 'package:app/core/theme/app_color_set.dart';
import 'package:app/shared/widgets/app_phone_text_field.dart';
import 'package:app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:app/core/constants/nigerian_states.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/app_typography.dart';
import 'package:app/core/utils/validators.dart';
import 'package:app/features/vendor/presentation/widgets/vendor_setup_step_header.dart';
import 'package:app/shared/widgets/app_button.dart';
import 'package:app/shared/widgets/app_text_field.dart';

class BusinessInfoStep extends StatelessWidget {
  const BusinessInfoStep({
    super.key,
    required this.formKey,
    required this.businessNameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
    required this.cityController,
    required this.selectedState,
    required this.onStateChanged,
    required this.onNext,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController businessNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController cityController;
  final String selectedState;
  final ValueChanged<String> onStateChanged;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VendorSetupStepHeader(
              icon: Icons.business_outlined,
              title: context.l10n.businessDetails,
            ),
            const SizedBox(height: 20),
            const _LogoPicker(),
            const SizedBox(height: 24),
            AppTextField(
              label: context.l10n.businessName,
              controller: businessNameController,
              hint: context.l10n.businessNameHint,
              icon: Icons.business_center_outlined,
              validator: (value) => Validators.validateRequired(
                context,
                value,
                fieldName: context.l10n.businessName,
              ),
            ),
            const SizedBox(height: 16),
            _ContactFields(
              emailController: emailController,
              phoneController: phoneController,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: context.l10n.officeAddress,
              controller: addressController,
              hint: context.l10n.officeAddressHint,
              icon: Icons.location_on_outlined,
              validator: (value) => Validators.validateRequired(
                context,
                value,
                fieldName: context.l10n.officeAddress,
              ),
            ),
            const SizedBox(height: 16),
            _CityStateFields(
              cityController: cityController,
              selectedState: selectedState,
              onStateChanged: onStateChanged,
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerRight,
              child: AppButton(
                label: context.l10n.nextStep,
                trailing: Icons.arrow_forward,
                expand: false,
                onPressed: onNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Private sub-widgets ──

class _LogoPicker extends StatelessWidget {
  const _LogoPicker();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.appColors.surfaceTertiary,
            border: Border.all(color: context.appColors.borderLight),
          ),
          child: Icon(
            Icons.upload_outlined,
            color: context.appColors.textHint,
            size: 30,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppButton.outlined(
                label: context.l10n.chooseLogo,
                expand: false,
                // TODO(logo): Integrate image picker for logo upload.
                onPressed: () {},
              ),
              const SizedBox(height: 4),
              Text(
                context.l10n.logoMaxWeight,
                style: textTheme.bodySmall?.vCopyWith(
                  color: context.appColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContactFields extends StatelessWidget {
  const _ContactFields({
    required this.emailController,
    required this.phoneController,
  });

  final TextEditingController emailController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    final emailField = AppTextField(
      label: context.l10n.businessEmail,
      controller: emailController,
      hint: context.l10n.emailAddressHint,
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email_outlined,
      validator: (value) => Validators.validateEmail(context, value),
    );

    final phoneField = AppPhoneTextField(
      label: context.l10n.businessPhone,
      controller: phoneController,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 560) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: emailField),
              const SizedBox(width: 16),
              Expanded(child: phoneField),
            ],
          );
        }
        return Column(
          children: [emailField, const SizedBox(height: 16), phoneField],
        );
      },
    );
  }
}

class _CityStateFields extends StatelessWidget {
  const _CityStateFields({
    required this.cityController,
    required this.selectedState,
    required this.onStateChanged,
  });

  final TextEditingController cityController;
  final String selectedState;
  final ValueChanged<String> onStateChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final cityField = AppTextField(
      label: context.l10n.city,
      controller: cityController,
      hint: context.l10n.cityHint,
      icon: Icons.location_city_outlined,
      validator: (value) => Validators.validateRequired(
        context,
        value,
        fieldName: context.l10n.city,
      ),
    );

    final stateField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.state,
          style: textTheme.labelLarge?.vCopyWith(
            fontWeight: AppFontWeight.medium,
            color: context.appColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: selectedState,
          isExpanded: true,
          decoration: const InputDecoration(),
          items: nigerianStates
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: (value) {
            if (value != null) onStateChanged(value);
          },
        ),
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 560) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: stateField),
              const SizedBox(width: 16),
              Expanded(child: cityField),
            ],
          );
        }
        return Column(
          children: [stateField, const SizedBox(height: 16), cityField],
        );
      },
    );
  }
}
