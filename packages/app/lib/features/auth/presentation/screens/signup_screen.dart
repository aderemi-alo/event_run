import 'package:app/core/router/route_names.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/app_typography.dart';
import 'package:app/core/utils/extensions.dart';
import 'package:app/core/utils/validators.dart';
import 'package:app/features/auth/domain/entities/signup_params.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/auth/presentation/widgets/signup_legal_text.dart';
import 'package:app/shared/widgets/app_button.dart';
import 'package:app/shared/widgets/app_phone_text_field.dart';
import 'package:app/shared/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    await ref
        .read(authProvider.notifier)
        .signup(
          SignupParams(
            fullName: _fullNameController.text,
            phone: _phoneController.text,
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final isLoading = ref.watch(authProvider).isLoading;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ── Header ──
                  Text(
                    'EventRun',
                    style: textTheme.headlineLarge!.vCopyWith(
                      fontWeight: AppFontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.l10n.createYourAccount,
                    style: textTheme.headlineMedium!.vCopyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.l10n.signupSubtitle,
                    style: textTheme.labelLarge!.vCopyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // ── Form ──
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AppTextField(
                          label: context.l10n.fullName,
                          icon: Icons.person_outline,
                          controller: _fullNameController,
                          hint: context.l10n.fullNameHint,
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z\s]'),
                            ),
                          ],
                          validator: (value) => Validators.validateRequired(
                            context,
                            value,
                            fieldName: context.l10n.fullName,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ── Phone with +234 prefix ──
                        AppPhoneTextField(
                          controller: _phoneController,
                          label: context.l10n.phoneNumber,
                        ),
                        const SizedBox(height: 16),

                        AppTextField(
                          label: context.l10n.emailAddress,
                          icon: Icons.mail_outline,
                          controller: _emailController,
                          hint: context.l10n.emailAddressHint,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              Validators.validateEmail(context, value),
                        ),
                        const SizedBox(height: 16),

                        AppTextField(
                          label: context.l10n.password,
                          controller: _passwordController,
                          icon: Icons.lock_outline,
                          hint: context.l10n.passwordHint,
                          isPassword: true,
                          validator: (value) =>
                              Validators.validatePassword(context, value),
                        ),

                        const SizedBox(height: 24),

                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 380),
                          child: SignupLegalText(),
                        ),

                        const SizedBox(height: 10),

                        // ── Submit Button ──
                        AppButton(
                          label: context.l10n.createAccount,
                          onPressed: _handleSubmit,
                          loading: isLoading,
                          trailing: Icons.arrow_forward,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // - Login Link -
                  Text.rich(
                    TextSpan(
                      text: context.l10n.alreadyHaveAccount,
                      style: textTheme.labelLarge!.vCopyWith(
                        fontWeight: AppFontWeight.regular,
                        color: AppColors.textTertiary,
                      ),
                      children: [
                        TextSpan(
                          text: context.l10n.logIn,
                          style: textTheme.labelLarge!.vCopyWith(
                            fontWeight: AppFontWeight.semiBold,
                            color: colorScheme.primary,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.goNamed(RouteNames.login),
                        ),
                      ],
                    ),
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
