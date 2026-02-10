import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_run/core/constants/app_colors.dart';
import 'package:event_run/core/constants/app_spacing.dart';
import 'package:event_run/core/utils/validators.dart';
import 'package:event_run/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:event_run/features/auth/presentation/ui/widgets/auth_text_field.dart';

/// Signup screen
class SignupView extends ConsumerStatefulWidget {
  const SignupView({super.key});

  @override
  ConsumerState<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _businessNameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // await ref
        //     .read(authStateProvider.notifier)
        //     .signup(
        //       businessName: _businessNameController.text.trim(),
        //       fullName: _fullNameController.text.trim(),
        //       email: _emailController.text.trim(),
        //       phone: _phoneController.text.trim(),
        //       password: _passwordController.text,
        // );
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
    // final authState = ref.watch(authStateProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo/Title
                Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.slate900,
                  ),
                ),

                const SizedBox(height: AppSpacing.sm),

                Text(
                  'Sign up to get started with EventRun',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.slate500),
                ),

                const SizedBox(height: AppSpacing.xl),

                // Business name
                AuthTextField(
                  controller: _businessNameController,
                  label: 'Business Name',
                  hintText: 'e.g. Ola Events Solutions',
                  textCapitalization: TextCapitalization.words,
                  prefixIcon: Icons.business_rounded,
                  validator: (value) => Validators.validateRequired(
                    value,
                    fieldName: 'Business name',
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Full name
                AuthTextField(
                  controller: _fullNameController,
                  label: 'Full Name',
                  hintText: 'Your full name',
                  textCapitalization: TextCapitalization.words,
                  prefixIcon: Icons.person_outline,
                  validator: (value) => Validators.validateRequired(
                    value,
                    fieldName: 'Full name',
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Email
                AuthTextField(
                  controller: _emailController,
                  label: 'Email',
                  hintText: 'your@email.com',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  validator: Validators.validateEmail,
                ),

                const SizedBox(height: AppSpacing.md),

                // Phone
                AuthTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  hintText: '+234 803 555 0123',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_outlined,
                  validator: Validators.validatePhone,
                ),

                const SizedBox(height: AppSpacing.md),

                // Password
                AuthTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hintText: 'At least 6 characters',
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  validator: Validators.validatePassword,
                ),

                const SizedBox(height: AppSpacing.md),

                // Confirm password
                AuthTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  hintText: 'Re-enter your password',
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  validator: _validateConfirmPassword,
                ),

                const SizedBox(height: AppSpacing.lg),

                // Signup button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleSignup,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                      ),
                    ),
                    child: const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(AppColors.white),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Login link
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Navigation will be handled by router
                    },
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.slate600,
                        ),
                        children: const [
                          TextSpan(text: 'Already have an account? '),
                          TextSpan(
                            text: 'Login',
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
    );
  }
}
