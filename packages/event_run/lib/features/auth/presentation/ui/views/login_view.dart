import 'package:event_run/core/widgets/responsive_builder.dart';
import 'package:event_run/features/auth/presentation/ui/widgets/primary_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_run/core/constants/app_colors.dart';
import 'package:event_run/core/constants/app_spacing.dart';
import 'package:event_run/core/utils/validators.dart';
import 'package:event_run/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:event_run/features/auth/presentation/ui/widgets/auth_text_field.dart';

/// Login screen
class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await ref
            .read(authNotifierProvider.notifier)
            .login(_emailController.text.trim(), _passwordController.text);
        // Navigation will be handled by router
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: EdgeInsets.all(context.isMobile ? 16.0 : 32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: AppSpacing.xxl),

                    // Logo/Title
                    Text(
                      'EventRun',
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            // color: AppColors.teal700,
                            color: Colors.teal.shade700,
                          ),
                    ),

                    const SizedBox(height: AppSpacing.sm),

                    Text(
                      'Welcome Back',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        // color: AppColors.teal700,
                        color: Colors.grey.shade900,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.sm),

                    Text(
                      'Log in to manage your events.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 14,
                        // color: AppColors.slate500,
                        color: Colors.grey.shade500,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    // Email field
                    AuthTextField(
                      controller: _emailController,
                      label: 'Email Address',
                      hintText: 'you@example.com',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.mail_outline,
                      validator: Validators.validateEmail,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Password field
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Password',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: AppColors.slate700,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                        ),
                        TextButton(
                          onPressed: () {
                            // navigate to forgot password
                          },
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.teal.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    AuthTextField(
                      controller: _passwordController,
                      label: '',
                      showLabel: false,
                      hintText: '••••••••',
                      isPassword: true,
                      prefixIcon: Icons.lock_outline,
                      validator: Validators.validatePassword,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _handleLogin(),
                      autofillHints: const [AutofillHints.password],
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Login button
                    PrimaryLoadingButton(
                      isLoading: authState.isLoading,
                      onPressed: () {
                        _handleLogin();
                      },
                      label: 'Log In',
                      icon: Icons.arrow_forward,
                      hapticFeedback: HapticFeedback.lightImpact(),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Sign up link
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Navigation will be handled by router
                        },
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.slate600),
                            children: const [
                              TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: 'Sign up',
                                style: TextStyle(
                                  color: AppColors.teal600,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
