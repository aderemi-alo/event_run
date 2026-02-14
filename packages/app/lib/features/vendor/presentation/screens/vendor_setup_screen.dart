import 'package:app/core/utils/enums.dart';
import 'package:app/features/vendor/domain/entities/vendor_setup_step.dart';
import 'package:app/core/utils/extensions.dart';
import 'package:app/features/vendor/presentation/providers/vendor_providers_di.dart';
import 'package:app/features/vendor/presentation/screens/steps/bank_info_step.dart';
import 'package:app/features/vendor/presentation/screens/steps/business_info_step.dart';
import 'package:app/features/vendor/presentation/screens/steps/plan_selection_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app/core/router/route_names.dart';
import 'package:app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:app/features/vendor/domain/entities/create_vendor_params.dart';
import 'package:app/features/vendor/domain/entities/vendor_entity.dart';
import 'package:app/features/vendor/presentation/providers/vendor_state.dart';
import 'package:app/features/vendor/presentation/widgets/vendor_setup_flow_shell.dart';

class VendorSetupScreen extends ConsumerStatefulWidget {
  const VendorSetupScreen({super.key});

  @override
  ConsumerState<VendorSetupScreen> createState() => _VendorSetupScreenState();
}

class _VendorSetupScreenState extends ConsumerState<VendorSetupScreen> {
  // ── Step navigation ──
  var _currentStep = VendorSetupStep.businessInfo;

  // ── Form keys ──
  final _businessFormKey = GlobalKey<FormState>();
  final _bankFormKey = GlobalKey<FormState>();

  // ── Business info controllers ──
  final _businessNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();

  // ── Bank info controllers ──
  final _accountNumberController = TextEditingController();
  final _accountNameController = TextEditingController();

  // ── Discrete selections ──
  String _selectedState = 'Lagos';
  String _selectedBank = '';
  VendorPlan _selectedPlan = VendorPlan.free;

  @override
  void dispose() {
    _businessNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _accountNumberController.dispose();
    _accountNameController.dispose();
    super.dispose();
  }

  // ── Navigation ──

  void _nextStep() {
    switch (_currentStep) {
      case VendorSetupStep.businessInfo:
        if (!(_businessFormKey.currentState?.validate() ?? false)) return;
        setState(() => _currentStep = VendorSetupStep.bankInfo);
      case VendorSetupStep.bankInfo:
        if (!(_bankFormKey.currentState?.validate() ?? false)) return;
        setState(() => _currentStep = VendorSetupStep.planSelection);
      case VendorSetupStep.planSelection:
        break;
    }
  }

  void _previousStep() {
    switch (_currentStep) {
      case VendorSetupStep.businessInfo:
        return;
      case VendorSetupStep.bankInfo:
        setState(() => _currentStep = VendorSetupStep.businessInfo);
      case VendorSetupStep.planSelection:
        setState(() => _currentStep = VendorSetupStep.bankInfo);
    }
  }

  // ── Submission ──

  Future<void> _submit() async {
    final user = ref.read(currentUserProvider);
    if (user == null) {
      _showSnackBar(context.l10n.notSignedInError);
      return;
    }

    await ref
        .read(vendorProvider.notifier)
        .createVendor(
          CreateVendorParams(
            ownerId: user.id,
            businessName: _businessNameController.text.trim(),
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
            address: _addressController.text.trim(),
            city: _cityController.text.trim(),
            state: _selectedState,
            bankName: _selectedBank,
            accountName: _accountNameController.text.trim(),
            accountNumber: _accountNumberController.text.trim(),
            plan: _selectedPlan.name,
          ),
        );
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // ── Build ──

  @override
  Widget build(BuildContext context) {
    ref.listen<VendorState>(vendorProvider, (previous, next) {
      if (next.actionState == ActionState.success) {
        context.goNamed(RouteNames.dashboard);
      }
      if (next.actionState == ActionState.error && next.actionError != null) {
        _showSnackBar(next.actionError!);
        ref.read(vendorProvider.notifier).resetAction();
      }
    });

    final isSubmitting = ref.watch(
      vendorProvider.select((s) => s.actionState == ActionState.loading),
    );

    return VendorSetupFlowShell(
      progress: _currentStep.progress,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: switch (_currentStep) {
          VendorSetupStep.businessInfo => BusinessInfoStep(
            key: const ValueKey('business-info'),
            formKey: _businessFormKey,
            businessNameController: _businessNameController,
            emailController: _emailController,
            phoneController: _phoneController,
            addressController: _addressController,
            cityController: _cityController,
            selectedState: _selectedState,
            onStateChanged: (v) => setState(() => _selectedState = v),
            onNext: _nextStep,
          ),
          VendorSetupStep.bankInfo => BankInfoStep(
            key: const ValueKey('bank-info'),
            formKey: _bankFormKey,
            accountNumberController: _accountNumberController,
            accountNameController: _accountNameController,
            selectedBank: _selectedBank,
            onBankChanged: (v) => setState(() => _selectedBank = v),
            onNext: _nextStep,
            onBack: _previousStep,
          ),
          VendorSetupStep.planSelection => PlanSelectionStep(
            key: const ValueKey('plan-selection'),
            selectedPlan: _selectedPlan,
            isSubmitting: isSubmitting,
            onPlanChanged: (v) => setState(() => _selectedPlan = v),
            onSubmit: _submit,
            onBack: _previousStep,
          ),
        },
      ),
    );
  }
}
