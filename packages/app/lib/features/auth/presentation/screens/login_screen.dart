import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/app_typography.dart';
import 'package:app/core/utils/extensions.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';
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

    await ref
        .read(authProvider.notifier)
        .signIn(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final isLoading = ref.watch(authProvider).isLoading;

    return Scaffold(
      backgroundColor: AppColors.surfacePrimary,
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
                    'EventRun',
                    style: textTheme.headlineLarge!.vCopyWith(
                      fontWeight: AppFontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    'Welcome back',
                    style: textTheme.headlineMedium!.vCopyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Login to manage your events',
                    style: textTheme.labelLarge!.vCopyWith(
                      color: AppColors.textHint,
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
                        ),
                        const SizedBox(height: 16),

                        AppTextField(
                          label: context.l10n.password,
                          labelWidget: Row(
                            children: [
                              Text(
                                context.l10n.password,
                                style: textTheme.labelLarge!.vCopyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const Spacer(),
                              Text.rich(
                                TextSpan(
                                  text: 'Forgot password?',
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
                        ),

                        const SizedBox(height: 24),

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
                  Text.rich(
                    TextSpan(
                      text: 'Don\'t have an account? ',
                      style: textTheme.labelLarge!.vCopyWith(
                        fontWeight: AppFontWeight.regular,
                        color: AppColors.textTertiary,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: textTheme.labelLarge!.vCopyWith(
                            fontWeight: AppFontWeight.semiBold,
                            color: colorScheme.primary,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.go(RouteNames.signup),
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
