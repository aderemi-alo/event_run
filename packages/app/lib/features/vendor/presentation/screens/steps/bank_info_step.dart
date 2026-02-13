import 'package:app/core/constants/banks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/app_typography.dart';
import 'package:app/core/utils/validators.dart';
import 'package:app/features/vendor/presentation/widgets/vendor_setup_step_header.dart';
import 'package:app/shared/widgets/app_button.dart';
import 'package:app/shared/widgets/app_text_field.dart';

class BankInfoStep extends StatelessWidget {
  const BankInfoStep({
    super.key,
    required this.formKey,
    required this.accountNumberController,
    required this.accountNameController,
    required this.selectedBank,
    required this.onBankChanged,
    required this.onNext,
    required this.onBack,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController accountNumberController;
  final TextEditingController accountNameController;
  final String selectedBank;
  final ValueChanged<String> onBankChanged;
  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VendorSetupStepHeader(
              icon: Icons.account_balance_outlined,
              title: 'Bank Details',
              subtitle:
                  'These details appear on invoices so clients know where to pay.',
            ),
            const SizedBox(height: 16),

            // TODO(paystack): Replace manual bank fields with Paystack
            // bank account verification flow.
            const _BankInfoBanner(),

            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bank Name',
                  style: textTheme.labelLarge?.vCopyWith(
                    fontWeight: AppFontWeight.medium,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: selectedBank.isEmpty ? null : selectedBank,
                  isExpanded: true,
                  decoration: const InputDecoration(hintText: 'Select bank'),
                  items: nigerianBanks
                      .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                      .toList(),
                  onChanged: (value) => onBankChanged(value ?? ''),
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Select a bank' : null,
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Account Number',
              controller: accountNumberController,
              hint: '0123456789',
              keyboardType: TextInputType.number,
              icon: Icons.numbers_outlined,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Account number is required';
                }
                if (value.trim().length != 10) {
                  return 'Account number must be 10 digits';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Account Name',
              controller: accountNameController,
              hint: 'Matches your bank account name',
              icon: Icons.person_outline,
              validator: (value) => Validators.validateRequired(
                context,
                value,
                fieldName: 'Account name',
              ),
            ),
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
                  label: 'Next Step',
                  trailing: Icons.arrow_forward,
                  expand: false,
                  onPressed: onNext,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Private sub-widgets ──

class _BankInfoBanner extends StatelessWidget {
  const _BankInfoBanner();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.infoLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.infoBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.verified_user_outlined,
            size: 20,
            color: AppColors.info,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'These details are used on client-facing invoices.',
              style: textTheme.bodyMedium?.vCopyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
