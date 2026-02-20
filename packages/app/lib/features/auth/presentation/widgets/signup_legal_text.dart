import 'package:app/core/theme/app_color_set.dart';
import 'package:app/core/theme/app_typography.dart';
import 'package:app/core/utils/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupLegalText extends StatefulWidget {
  const SignupLegalText({super.key});

  @override
  State<SignupLegalText> createState() => _SignupLegalTextState();
}

class _SignupLegalTextState extends State<SignupLegalText> {
  late final TapGestureRecognizer _termsRecognizer;
  late final TapGestureRecognizer _privacyRecognizer;

  @override
  void initState() {
    super.initState();
    _termsRecognizer = TapGestureRecognizer()..onTap = _openTerms;
    _privacyRecognizer = TapGestureRecognizer()..onTap = _openPrivacy;
  }

  @override
  void dispose() {
    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();
    super.dispose();
  }

  void _openTerms() {
    //TODO: Navigate to Terms
  }

  void _openPrivacy() {
    //TODO: Navigate to Privacy
  }

  @override
  Widget build(BuildContext context) {
    // Assuming you have your theme and l10n setup
    final textTheme = Theme.of(context).textTheme;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: context.l10n.bySigningUpYouAgreeToOur, // Hardcoded for demo
        style: textTheme.labelMedium?.vCopyWith(
          color: context.colors.textTertiary,
        ),
        children: [
          TextSpan(
            text: context.l10n.termsOfService,
            style: textTheme.labelMedium!.vCopyWith(
              color: Colors.teal.shade600,
              fontWeight: AppFontWeight.medium,
            ),
            recognizer: _termsRecognizer,
          ),
          TextSpan(
            text: ' ${context.l10n.and} ',
            style: textTheme.labelMedium?.vCopyWith(
              color: context.colors.textTertiary,
            ),
          ),
          TextSpan(
            text: context.l10n.privacyPolicy,
            style: textTheme.labelMedium!.vCopyWith(
              color: Colors.teal.shade600,
              fontWeight: AppFontWeight.medium,
            ),
            recognizer: _privacyRecognizer,
          ),
        ],
      ),
    );
  }
}
