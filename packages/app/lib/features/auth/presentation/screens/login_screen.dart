import 'package:app/core/theme/app_color_set.dart';
import 'package:app/core/theme/app_typography.dart';
import 'package:app/core/utils/extensions.dart';
import 'package:app/features/auth/presentation/providers/auth_providers_di.dart';
import 'package:app/features/auth/presentation/widgets/signup_legal_text.dart';
import 'package:app/shared/widgets/app_button.dart';
import 'package:app/shared/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app/core/router/route_names.dart';
import 'package:app/core/utils/validators.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(authNotifierProvider.notifier).signIn((
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final isLoading = ref.watch(authNotifierProvider).isLoading;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header
                  Text(
                    context.l10n.appName,
                    style: textTheme.headlineLarge!.vCopyWith(
                      fontWeight: AppFontWeight.bold,
                      color: context.colors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    context.l10n.welcomeBack,
                    style: textTheme.headlineMedium!.vCopyWith(
                      color: context.colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.l10n.loginToManageEvents,
                    style: textTheme.labelLarge!.vCopyWith(
                      color: context.colors.textHint,
                    ),
                  ),
                  const SizedBox(height: 32),

                  //Form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AppTextField(
                          label: context.l10n.emailAddress,
                          icon: Icons.mail_outline,
                          controller: _emailController,
                          hint: context.l10n.emailAddressHint,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              Validators.validateEmail(context, value),
                          textInputAction: TextInputAction.next,
                          autofillHints: [AutofillHints.email],
                        ),
                        const SizedBox(height: 16),

                        AppTextField(
                          label: context.l10n.password,
                          labelWidget: Row(
                            children: [
                              Text(
                                context.l10n.password,
                                style: textTheme.labelLarge!.vCopyWith(
                                  color: context.colors.textSecondary,
                                ),
                              ),
                              const Spacer(),
                              Text.rich(
                                TextSpan(
                                  text: context.l10n.forgotPassword,
                                  style: textTheme.labelMedium!.vCopyWith(
                                    color: colorScheme.primary,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => context.pushNamed(
                                      RouteNames.forgotPassword,
                                    ),
                                ),
                              ),
                            ],
                          ),
                          controller: _passwordController,
                          icon: Icons.lock_outline,
                          hint: context.l10n.passwordHint,
                          isPassword: true,
                          validator: (value) =>
                              Validators.validatePassword(context, value),
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _handleSubmit(),
                          autofillHints: [AutofillHints.password],
                        ),

                        const SizedBox(height: 24),

                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 380),
                          child: SignupLegalText(),
                        ),

                        const SizedBox(height: 10),

                        AppButton(
                          label: context.l10n.login,
                          onPressed: _handleSubmit,
                          loading: isLoading,
                          trailing: Icons.arrow_forward,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  Text.rich(
                    TextSpan(
                      text: context.l10n.dontHaveAccount,
                      style: textTheme.labelLarge!.vCopyWith(
                        fontWeight: AppFontWeight.regular,
                        color: context.colors.textTertiary,
                      ),
                      children: [
                        TextSpan(
                          text: context.l10n.signUp,
                          style: textTheme.labelLarge!.vCopyWith(
                            fontWeight: AppFontWeight.semiBold,
                            color: colorScheme.primary,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.goNamed(RouteNames.signup),
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
