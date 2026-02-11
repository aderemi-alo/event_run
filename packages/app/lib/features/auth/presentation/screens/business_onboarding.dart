import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart'; // Uncomment when you add the dependency

enum OnboardingStep { businessInfo, bankInfo, planSelection }

class BusinessOnboardingScreen extends StatefulWidget {
  const BusinessOnboardingScreen({super.key});

  @override
  State<BusinessOnboardingScreen> createState() =>
      _BusinessOnboardingScreenState();
}

class _BusinessOnboardingScreenState extends State<BusinessOnboardingScreen> {
  OnboardingStep _currentStep = OnboardingStep.businessInfo;
  bool _loading = false;
  String? _logoPath;

  // ── Form controllers ──
  final _businessNameController = TextEditingController();
  final _businessEmailController = TextEditingController();
  final _businessPhoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _accountNameController = TextEditingController();

  String _selectedState = 'Lagos';
  String _selectedBank = '';
  String _selectedPlan = 'FREE';

  final _businessFormKey = GlobalKey<FormState>();
  final _bankFormKey = GlobalKey<FormState>();

  static const List<String> _nigerianStates = [
    'Abia',
    'Abuja',
    'Adamawa',
    'Akwa Ibom',
    'Anambra',
    'Bauchi',
    'Bayelsa',
    'Benue',
    'Borno',
    'Cross River',
    'Delta',
    'Ebonyi',
    'Edo',
    'Ekiti',
    'Enugu',
    'Gombe',
    'Imo',
    'Jigawa',
    'Kaduna',
    'Kano',
    'Katsina',
    'Kebbi',
    'Kogi',
    'Kwara',
    'Lagos',
    'Nasarawa',
    'Niger',
    'Ogun',
    'Ondo',
    'Osun',
    'Oyo',
    'Plateau',
    'Rivers',
    'Sokoto',
    'Taraba',
    'Yobe',
    'Zamfara',
  ];

  static const List<String> _banks = [
    'Access Bank',
    'First Bank',
    'GTBank',
    'Kuda',
    'Moniepoint',
    'OPay',
    'Stanbic IBTC',
    'Sterling Bank',
    'UBA',
    'Union Bank',
    'Wema Bank',
    'Zenith Bank',
  ];

  @override
  void dispose() {
    _businessNameController.dispose();
    _businessEmailController.dispose();
    _businessPhoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _accountNumberController.dispose();
    _accountNameController.dispose();
    super.dispose();
  }

  // ── Progress ──
  double get _progress {
    switch (_currentStep) {
      case OnboardingStep.businessInfo:
        return 0.33;
      case OnboardingStep.bankInfo:
        return 0.66;
      case OnboardingStep.planSelection:
        return 1.0;
    }
  }

  // ── Navigation ──
  void _nextStep() {
    if (_currentStep == OnboardingStep.businessInfo) {
      if (!_businessFormKey.currentState!.validate()) return;
      setState(() => _currentStep = OnboardingStep.bankInfo);
    } else if (_currentStep == OnboardingStep.bankInfo) {
      if (!_bankFormKey.currentState!.validate()) return;
      setState(() => _currentStep = OnboardingStep.planSelection);
    }
  }

  void _previousStep() {
    if (_currentStep == OnboardingStep.bankInfo) {
      setState(() => _currentStep = OnboardingStep.businessInfo);
    } else if (_currentStep == OnboardingStep.planSelection) {
      setState(() => _currentStep = OnboardingStep.bankInfo);
    }
  }

  // ── Logo picker ──
  Future<void> _pickLogo() async {
    // TODO: Uncomment when image_picker is added:
    // final picker = ImagePicker();
    // final picked = await picker.pickImage(source: ImageSource.gallery, maxWidth: 512);
    // if (picked != null) {
    //   setState(() => _logoPath = picked.path);
    // }

    // Placeholder: show a snackbar
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Add image_picker package to enable logo upload'),
        ),
      );
    }
  }

  // ── Final submit ──
  Future<void> _handleFinalSubmit() async {
    setState(() => _loading = true);

    try {
      if (_selectedPlan == 'PRO') {
        // TODO: Integrate Paystack Flutter SDK here
        // final charge = PaystackCharge()
        //   ..amount = 600000 // ₦6,000 in kobo
        //   ..email = _businessEmailController.text;
        // final response = await paystackPlugin.checkout(context, charge: charge);
        await Future.delayed(const Duration(seconds: 2)); // Simulate payment
      } else {
        await Future.delayed(const Duration(seconds: 1)); // Simulate save
      }

      // TODO: Replace with actual Supabase vendor insert
      // await supabase.from('vendors').insert({
      //   'owner_id': supabase.auth.currentUser!.id,
      //   'business_name': _businessNameController.text.trim(),
      //   'business_email': _businessEmailController.text.trim(),
      //   'business_phone': _businessPhoneController.text.trim(),
      //   'address': _addressController.text.trim(),
      //   'city': _cityController.text.trim(),
      //   'state': _selectedState,
      //   'bank_name': _selectedBank,
      //   'account_number': _accountNumberController.text.trim(),
      //   'account_name': _accountNameController.text.trim(),
      //   'plan': _selectedPlan == 'PRO' ? 'pro' : 'free',
      // });

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Setup failed: ${e.toString()}'),
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
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // slate-50
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 672), // max-w-2xl
              child: Column(
                children: [
                  // ── Header ──
                  const Text(
                    'Setup your Business',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Let's get your profile ready for clients.",
                    style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 24),

                  // ── Progress bar ──
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      value: _progress,
                      minHeight: 8,
                      backgroundColor: const Color(0xFFE2E8F0), // slate-200
                      valueColor: AlwaysStoppedAnimation(Colors.teal.shade600),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Card ──
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _buildCurrentStep(),
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

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case OnboardingStep.businessInfo:
        return _buildBusinessInfoStep();
      case OnboardingStep.bankInfo:
        return _buildBankInfoStep();
      case OnboardingStep.planSelection:
        return _buildPlanSelectionStep();
    }
  }

  // ═══════════════════════════════════════════════════════════
  // STEP 1: Business Info
  // ═══════════════════════════════════════════════════════════
  Widget _buildBusinessInfoStep() {
    return Padding(
      key: const ValueKey('business_info'),
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _businessFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Row(
              children: [
                Icon(
                  Icons.business_outlined,
                  size: 24,
                  color: Colors.teal.shade600,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Business Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Logo upload
            Row(
              children: [
                GestureDetector(
                  onTap: _pickLogo,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFF1F5F9),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        style: _logoPath == null
                            ? BorderStyle.none
                            : BorderStyle.solid,
                      ),
                      image: _logoPath != null
                          ? DecorationImage(
                              image: FileImage(File(_logoPath!)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _logoPath == null
                        ? Icon(
                            Icons.upload_outlined,
                            size: 32,
                            color: Colors.grey.shade400,
                          )
                        : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutlinedButton(
                        onPressed: _pickLogo,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.teal.shade700,
                          backgroundColor: Colors.teal.shade50,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                        child: const Text(
                          'Choose Logo',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Optional. Max 2MB.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Business Name
            _buildLabel('Business Name'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _businessNameController,
              decoration: _inputDecoration('e.g. Royal Events & Decor'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Business name is required'
                  : null,
            ),
            const SizedBox(height: 16),

            // Email & Phone row
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 480) {
                  return Row(
                    children: [
                      Expanded(child: _emailField()),
                      const SizedBox(width: 16),
                      Expanded(child: _phoneField()),
                    ],
                  );
                }
                return Column(
                  children: [
                    _emailField(),
                    const SizedBox(height: 16),
                    _phoneField(),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),

            // Address
            _buildLabel('Office Address'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _addressController,
              decoration: _inputDecoration('123 Admiralty Way'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Address is required'
                  : null,
            ),
            const SizedBox(height: 16),

            // City & State row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('City'),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _cityController,
                        decoration: _inputDecoration('Lekki'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('State'),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: _selectedState,
                        decoration: _inputDecoration(''),
                        isExpanded: true,
                        items: _nigerianStates
                            .map(
                              (s) => DropdownMenuItem(value: s, child: Text(s)),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => _selectedState = v!),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Next button
            Align(alignment: Alignment.centerRight, child: _nextButton()),
          ],
        ),
      ),
    );
  }

  Widget _emailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Business Email'),
        const SizedBox(height: 6),
        TextFormField(
          controller: _businessEmailController,
          keyboardType: TextInputType.emailAddress,
          decoration: _inputDecoration('you@business.com'),
        ),
      ],
    );
  }

  Widget _phoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Business Phone'),
        const SizedBox(height: 6),
        TextFormField(
          controller: _businessPhoneController,
          keyboardType: TextInputType.phone,
          decoration: _inputDecoration('+234 800 000 0000'),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════
  // STEP 2: Bank Info
  // ═══════════════════════════════════════════════════════════
  Widget _buildBankInfoStep() {
    return Padding(
      key: const ValueKey('bank_info'),
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _bankFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.credit_card_outlined,
                  size: 24,
                  color: Colors.teal.shade600,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Bank Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Info banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF), // blue-50
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFDBEAFE)), // blue-100
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.verified_user_outlined,
                    size: 20,
                    color: Colors.blue.shade600,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'These details will appear on the invoices you generate so clients know where to pay.',
                      style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Bank Name
            _buildLabel('Bank Name'),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: _selectedBank.isEmpty ? null : _selectedBank,
              decoration: _inputDecoration(
                '',
              ).copyWith(hintText: 'Select Bank'),
              isExpanded: true,
              items: _banks
                  .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedBank = v ?? ''),
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'Please select a bank' : null,
            ),
            const SizedBox(height: 16),

            // Account Number
            _buildLabel('Account Number'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _accountNumberController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: _inputDecoration(
                '0123456789',
              ).copyWith(counterText: ''),
              validator: (v) {
                if (v == null || v.trim().isEmpty)
                  return 'Account number is required';
                if (v.trim().length != 10) return 'Must be 10 digits';
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Account Name
            _buildLabel('Account Name'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _accountNameController,
              decoration: _inputDecoration('Matches your bank account name'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Account name is required'
                  : null,
            ),
            const SizedBox(height: 32),

            // Nav buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_backButton(), _nextButton()],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // STEP 3: Plan Selection
  // ═══════════════════════════════════════════════════════════
  Widget _buildPlanSelectionStep() {
    return Padding(
      key: const ValueKey('plan_selection'),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text(
            'Select a Plan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 24),

          // Plan cards
          LayoutBuilder(
            builder: (context, constraints) {
              final cards = [
                _buildPlanCard(
                  planKey: 'FREE',
                  title: 'Starter',
                  priceLabel: 'Free',
                  priceSuffix: '',
                  features: ['5 Events/mo', 'Basic Invoices'],
                  isRecommended: false,
                ),
                _buildPlanCard(
                  planKey: 'PRO',
                  title: 'Pro Business',
                  priceLabel: '₦6,000',
                  priceSuffix: '/month',
                  features: [
                    'Unlimited Events',
                    'Unlimited Invoices',
                    'Priority Support',
                  ],
                  isRecommended: true,
                ),
              ];

              if (constraints.maxWidth > 500) {
                return Row(
                  children: cards.map((c) => Expanded(child: c)).toList()
                    ..insert(
                      1,
                      const Expanded(flex: 0, child: SizedBox(width: 12)),
                    ),
                );
              }
              return Column(
                children: [cards[0], const SizedBox(height: 12), cards[1]],
              );
            },
          ),
          const SizedBox(height: 32),

          // Nav buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _backButton(),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _loading ? null : _handleFinalSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade600,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.teal.shade600.withOpacity(
                      0.7,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    shadowColor: Colors.teal.shade600.withOpacity(0.2),
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _selectedPlan == 'PRO'
                                  ? 'Proceed to Payment'
                                  : 'Complete Setup',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required String planKey,
    required String title,
    required String priceLabel,
    required String priceSuffix,
    required List<String> features,
    required bool isRecommended,
  }) {
    final isSelected = _selectedPlan == planKey;

    return GestureDetector(
      onTap: () => setState(() => _selectedPlan = planKey),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.teal.shade500 : const Color(0xFFE2E8F0),
            width: 2,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Recommended badge
            if (isRecommended)
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade600,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'RECOMMENDED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + checkmark
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        color: Colors.teal.shade600,
                        size: 24,
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                // Price
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      priceLabel,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    if (priceSuffix.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4, left: 2),
                        child: Text(
                          priceSuffix,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                // Features
                ...features.map(
                  (f) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 16,
                          color: isSelected
                              ? Colors.teal.shade500
                              : Colors.grey.shade400,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            f,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF475569),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // Shared widgets
  // ═══════════════════════════════════════════════════════════

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.grey.shade700,
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFCBD5E1)), // slate-300
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.teal.shade500, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  Widget _nextButton() {
    return ElevatedButton(
      onPressed: _nextStep,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal.shade600,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Next Step', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
          Icon(Icons.arrow_forward, size: 16),
        ],
      ),
    );
  }

  Widget _backButton() {
    return TextButton(
      onPressed: _previousStep,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_back, size: 16, color: Colors.grey.shade500),
          const SizedBox(width: 8),
          Text(
            'Back',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
