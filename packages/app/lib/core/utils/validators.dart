import 'package:app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class Validators {
  Validators._();

  static String? validateEmail(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.l10n.requiredField(context.l10n.auth_email);
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) return context.l10n.invalidEmail;
    return null;
  }

  static String? validatePhone(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.l10n.requiredField(context.l10n.phoneNumber);
    }
    final cleaned = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    if (!cleaned.startsWith('+234') && !cleaned.startsWith('0')) {
      return context.l10n.invalidPhoneStart;
    }
    final expectedLength = cleaned.startsWith('+234') ? 14 : 11;
    if (cleaned.length != expectedLength)
      return context.l10n.invalidPhoneLength;
    return null;
  }

  static String? validatePassword(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.l10n.requiredField(context.l10n.auth_password);
    }
    if (value.length < 8) return context.l10n.passwordLength;
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return context.l10n.passwordUppercase;
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return context.l10n.passwordLowercase;
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return context.l10n.passwordNumber;
    }
    return null;
  }

  static String? validateRequired(
    BuildContext context,
    String? value, {
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return context.l10n.requiredField(fieldName ?? context.l10n.thisField);
    }
    return null;
  }

  static String? validateNumber(
    BuildContext context,
    String? value, {
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return context.l10n.requiredField(fieldName ?? context.l10n.thisField);
    }
    if (double.tryParse(value) == null) return context.l10n.invalidNumber;
    return null;
  }

  static String? validatePositiveNumber(
    BuildContext context,
    String? value, {
    String? fieldName,
  }) {
    final numberError = validateNumber(context, value, fieldName: fieldName);
    if (numberError != null) return numberError;
    if (double.parse(value!) <= 0) {
      return context.l10n.positiveNumber(
        fieldName ?? context.l10n.valueMustBeGreaterThanZero,
      );
    }
    return null;
  }
}
