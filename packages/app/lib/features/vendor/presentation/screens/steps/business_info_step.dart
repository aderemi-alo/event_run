import 'package:app/shared/widgets/app_phone_text_field.dart';
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
            const VendorSetupStepHeader(
              icon: Icons.business_outlined,
              title: 'Business Details',
            ),
            const SizedBox(height: 20),
            const _LogoPicker(),
            const SizedBox(height: 24),
            AppTextField(
              label: 'Business Name',
              controller: businessNameController,
              hint: 'e.g. Royal Events & Decor',
              icon: Icons.business_center_outlined,
              validator: (value) => Validators.validateRequired(
                context,
                value,
                fieldName: 'Business name',
              ),
            ),
            const SizedBox(height: 16),
            _ContactFields(
              emailController: emailController,
              phoneController: phoneController,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Office Address',
              controller: addressController,
              hint: '123 Admiralty Way',
              icon: Icons.location_on_outlined,
              validator: (value) => Validators.validateRequired(
                context,
                value,
                fieldName: 'Office address',
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
                label: 'Next Step',
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
            color: AppColors.surfaceTertiary,
            border: Border.all(color: AppColors.borderLight),
          ),
          child: const Icon(
            Icons.upload_outlined,
            color: AppColors.textHint,
            size: 30,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppButton.outlined(
                label: 'Choose Logo',
                expand: false,
                // TODO(logo): Integrate image picker for logo upload.
                onPressed: () {},
              ),
              const SizedBox(height: 4),
              Text(
                'Optional. Max 2MB.',
                style: textTheme.bodySmall?.vCopyWith(
                  color: AppColors.textTertiary,
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
      label: 'Business Email',
      controller: emailController,
      hint: 'you@business.com',
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email_outlined,
      validator: (value) => Validators.validateEmail(context, value),
    );

    final phoneField = AppPhoneTextField(
      label: 'Business Phone',
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
      label: 'City',
      controller: cityController,
      hint: 'Lekki',
      icon: Icons.location_city_outlined,
      validator: (value) =>
          Validators.validateRequired(context, value, fieldName: 'City'),
    );

    final stateField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'State',
          style: textTheme.labelLarge?.vCopyWith(
            fontWeight: AppFontWeight.medium,
            color: AppColors.textSecondary,
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
