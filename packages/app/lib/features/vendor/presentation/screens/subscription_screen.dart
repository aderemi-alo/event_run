import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/widgets/app_loading.dart';
import 'package:app/core/widgets/app_error_widget.dart';
import 'package:app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:app/features/vendor/presentation/providers/vendor_providers.dart';
import 'package:app/features/vendor/presentation/widgets/plan_badge.dart';

class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    if (user == null) return const AppErrorWidget(message: 'Not signed in');

    final vendorAsync = ref.watch(vendorProvider(user.id));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: vendorAsync.when(
        loading: () => const AppLoading(),
        error: (e, _) => AppErrorWidget(
          message: e.toString(),
          onRetry: () => ref.invalidate(vendorProvider(user.id)),
        ),
        data: (vendor) {
          if (vendor == null) {
            return const AppErrorWidget(message: 'Vendor not found');
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      PlanBadge(plan: vendor.plan),
                      const SizedBox(height: 16),
                      Text(
                        vendor.isProPlan
                            ? 'You are on the Pro plan'
                            : 'You are on the Free plan',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (vendor.planExpiresAt != null && vendor.isProPlan) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Expires: ${vendor.planExpiresAt!.day}/${vendor.planExpiresAt!.month}/${vendor.planExpiresAt!.year}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withAlpha(153),
                          ),
                        ),
                      ],
                      if (!vendor.isProPlan) ...[
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            // TODO: Implement payment flow
                          },
                          child: const Text('Upgrade to Pro'),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Pro Benefits',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              _BenefitTile(
                icon: Icons.event,
                title: 'Unlimited Events',
                subtitle: 'Create as many events as you need',
              ),
              _BenefitTile(
                icon: Icons.inventory_2,
                title: 'Inventory Management',
                subtitle: 'Track all your equipment and supplies',
              ),
              _BenefitTile(
                icon: Icons.receipt_long,
                title: 'Invoice Generation',
                subtitle: 'Professional invoices with your branding',
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BenefitTile extends StatelessWidget {
  const _BenefitTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.teal50,
        child: Icon(icon, color: AppColors.teal600, size: 20),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
