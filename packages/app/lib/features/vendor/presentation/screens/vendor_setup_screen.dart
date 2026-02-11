import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app/core/router/route_names.dart';
import 'package:app/core/utils/validators.dart';
import 'package:app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:app/features/vendor/domain/entities/vendor_entity.dart';
import 'package:app/features/vendor/presentation/providers/vendor_providers.dart';
import 'package:app/features/auth/presentation/widgets/auth_form_field.dart';

class VendorSetupScreen extends ConsumerStatefulWidget {
  const VendorSetupScreen({super.key});

  @override
  ConsumerState<VendorSetupScreen> createState() => _VendorSetupScreenState();
}

class _VendorSetupScreenState extends ConsumerState<VendorSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _businessNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final user = ref.read(currentUserProvider);
    if (user == null) return;

    setState(() => _loading = true);
    try {
      final vendor = VendorEntity(
        id: '',
        businessName: _businessNameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        createdAt: DateTime.now(),
        ownerId: user.id,
      );
      await ref.read(createVendorUsecaseProvider).call(vendor: vendor);
      if (mounted) context.goNamed(RouteNames.dashboard);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Set Up Your Business')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Tell us about your business',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              AuthFormField(
                label: 'Business Name',
                hint: 'Acme Events',
                controller: _businessNameController,
                prefixIcon: Icons.business_outlined,
                textInputAction: TextInputAction.next,
                validator: (v) => Validators.validateRequired(
                  context,
                  v,
                  fieldName: 'Business name',
                ),
              ),
              const SizedBox(height: 16),
              AuthFormField(
                label: 'Business Email',
                hint: 'hello@acme.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
                textInputAction: TextInputAction.next,
                validator: (v) => Validators.validateEmail(context, v),
              ),
              const SizedBox(height: 16),
              AuthFormField(
                label: 'Phone Number',
                hint: '08012345678',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.phone_outlined,
                textInputAction: TextInputAction.done,
                validator: (v) => Validators.validatePhone(context, v),
                onFieldSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _loading ? null : _submit,
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
