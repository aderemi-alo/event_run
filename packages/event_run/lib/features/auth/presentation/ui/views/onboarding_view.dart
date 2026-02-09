import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_run/core/constants/app_colors.dart';
import 'package:event_run/core/constants/app_spacing.dart';
import 'package:event_run/features/auth/presentation/notifiers/auth_notifier.dart';

/// Onboarding screen with 3-step carousel
class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({super.key});

  @override
  ConsumerState<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  int _currentStep = 0;
  final PageController _pageController = PageController();

  final List<OnboardingStep> _steps = const [
    OnboardingStep(
      title: 'Prevent Double Bookings',
      description:
          'Never lose money or reputation again. See exactly when your equipment is available.',
      icon: Icons.event_busy_rounded,
      bgColor: AppColors.error,
      iconBgColor: Color(0xFFFEE2E2),
    ),
    OnboardingStep(
      title: 'Professional Invoices',
      description:
          'Send beautiful invoices in 2 minutes. Get paid faster and look more professional.',
      icon: Icons.receipt_long_rounded,
      bgColor: AppColors.info,
      iconBgColor: Color(0xFFDBEAFE),
    ),
    OnboardingStep(
      title: 'Run Your Business',
      description:
          'Manage clients, track revenue, and organize events from anywhere on your phone.',
      icon: Icons.dashboard_rounded,
      bgColor: AppColors.teal600,
      iconBgColor: AppColors.teal100,
    ),
  ];

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    ref.read(authStateProvider.notifier).completeOnboarding();
    // Navigation will be handled by router
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: const Text('Skip'),
                ),
              ),

              // Main content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentStep = index);
                  },
                  itemCount: _steps.length,
                  itemBuilder: (context, index) {
                    final step = _steps[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon container
                        Container(
                          width: 128,
                          height: 128,
                          decoration: BoxDecoration(
                            color: step.iconBgColor,
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusXl,
                            ),
                          ),
                          child: Icon(step.icon, size: 64, color: step.bgColor),
                        ),

                        const SizedBox(height: AppSpacing.xxl),

                        // Title
                        Text(
                          step.title,
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.slate900,
                              ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: AppSpacing.md),

                        // Description
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                          ),
                          child: Text(
                            step.description,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: AppColors.slate500,
                                  height: 1.6,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        const SizedBox(height: AppSpacing.xl),

                        // Dots indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _steps.length,
                            (i) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: i == _currentStep ? 32 : 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: i == _currentStep
                                    ? AppColors.teal600
                                    : AppColors.slate200,
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusFull,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Next/Get Started button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _currentStep == _steps.length - 1
                            ? 'Get Started'
                            : 'Next',
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Icon(
                        _currentStep == _steps.length - 1
                            ? Icons.check_rounded
                            : Icons.arrow_forward_rounded,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Onboarding step data model
class OnboardingStep {
  const OnboardingStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.bgColor,
    required this.iconBgColor,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color bgColor;
  final Color iconBgColor;
}
