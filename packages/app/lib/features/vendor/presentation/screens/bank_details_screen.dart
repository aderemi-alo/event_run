import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app/core/utils/validators.dart';
import 'package:app/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:app/features/vendor/presentation/providers/vendor_providers.dart';

class BankDetailsScreen extends ConsumerStatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  ConsumerState<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends ConsumerState<BankDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bankNameController = TextEditingController();
  final _accountNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _bankNameController.dispose();
    _accountNameController.dispose();
    _accountNumberController.dispose();
    super.dispose();
  }

  Future<void> _submit(String vendorId) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      await ref
          .read(updateBankDetailsUsecaseProvider)
          .call(
            vendorId: vendorId,
            bankName: _bankNameController.text.trim(),
            accountName: _accountNameController.text.trim(),
            accountNumber: _accountNumberController.text.trim(),
          );
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Bank details updated')));
        context.pop();
      }
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthFormField(
                label: 'Bank Name',
                hint: 'GTBank',
                controller: _bankNameController,
                prefixIcon: Icons.account_balance_outlined,
                textInputAction: TextInputAction.next,
                validator: (v) => Validators.validateRequired(
                  context,
                  v,
                  fieldName: 'Bank name',
                ),
              ),
              const SizedBox(height: 16),
              AuthFormField(
                label: 'Account Name',
                hint: 'Acme Events Ltd',
                controller: _accountNameController,
                prefixIcon: Icons.person_outlined,
                textInputAction: TextInputAction.next,
                validator: (v) => Validators.validateRequired(
                  context,
                  v,
                  fieldName: 'Account name',
                ),
              ),
              const SizedBox(height: 16),
              AuthFormField(
                label: 'Account Number',
                hint: '0123456789',
                controller: _accountNumberController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.numbers_outlined,
                textInputAction: TextInputAction.done,
                validator: (v) => Validators.validateRequired(
                  context,
                  v,
                  fieldName: 'Account number',
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _loading ? null : () => _submit(''),
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
