import 'package:app/core/theme/app_color_set.dart';
import 'package:app/core/utils/extensions.dart';
import 'package:app/core/utils/validators.dart';
import 'package:app/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppPhoneTextField extends StatelessWidget {
  const AppPhoneTextField({
    super.key,
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: label,
      icon: Icons.phone_outlined,
      controller: controller,
      hint: context.l10n.phoneNumberHint,
      keyboardType: TextInputType.phone,
      prefix: _buildPhonePrefix(context),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
      ],
      validator: (value) => Validators.validatePhone(context, value),
    );
  }

  /// Non-editable "+234" chip shown inside the phone field.
  Widget _buildPhonePrefix(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: context.appColors.primaryDark.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '+234',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: context.appColors.primaryDark,
        ),
      ),
    );
  }
}
