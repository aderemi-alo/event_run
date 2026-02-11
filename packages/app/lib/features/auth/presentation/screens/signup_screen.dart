import 'package:app/core/theme/app_typography.dart';
import 'package:app/core/utils/extensions.dart';
import 'package:app/core/utils/validators.dart';
import 'package:app/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

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

    setState(() => _loading = true);

    try {
      // TODO: Replace with your actual Supabase signup logic
      // final response = await supabase.auth.signUp(
      //   email: _emailController.text.trim(),
      //   password: _passwordController.text,
      //   data: {
      //     'full_name': _fullNameController.text.trim(),
      //     'phone': _phoneController.text.trim(),
      //   },
      // );

      // Simulate network delay for now
      await Future.delayed(const Duration(milliseconds: 600));

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/setup-business');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Signup failed: ${e.toString()}'),
            backgroundColor: Colors.red.shade600,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448), // max-w-md
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ── Header ──
                  Text(
                    'EventRun',
                    style: textTheme.headlineMedium!.vCopyWith(
                      fontWeight: AppFontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.l10n.createYourAccount,
                    style: textTheme.bodyMedium!.copyWith(
                      color: const Color(0xFF475569),
                    ),
                    // style: TextStyle(
                    //   fontSize: 20,
                    //   fontWeight: FontWeight.w600,
                    //   color: Color(0xFF0F172A), // slate-900
                    // ),
                  ),
                  const SizedBox(height: 32),

                  // ── Form ──
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

                        AppTextField(
                          label: context.l10n.phoneNumber,
                          icon: Icons.phone_outlined,
                          controller: _phoneController,
                          hint: context.l10n.phoneNumberHint,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                          validator: (value) =>
                              Validators.validatePhone(context, value),
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

                        // ── Submit Button ──
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _loading ? null : _handleSubmit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal.shade600,
                              disabledBackgroundColor: Colors.teal.shade600
                                  .withOpacity(0.7),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                              shadowColor: Colors.teal.shade600.withOpacity(
                                0.2,
                              ),
                            ),
                            child: _loading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        context.l10n.nextStep,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.arrow_forward, size: 20),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Login Link ──
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.l10n.alreadyHaveAccount,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushReplacementNamed(context, '/login'),
                        child: Text(
                          context.l10n.logIn,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal.shade600,
                          ),
                        ),
                      ),
                    ],
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
