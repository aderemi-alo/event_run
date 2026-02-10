import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:event_run/core/widgets/app_loading.dart';
import 'package:event_run/core/widgets/app_error_widget.dart';
import 'package:event_run/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:event_run/features/vendor/presentation/providers/vendor_providers.dart';

class BusinessSettingsScreen extends ConsumerWidget {
  const BusinessSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    if (user == null) return const AppErrorWidget(message: 'Not signed in');

    final vendorAsync = ref.watch(vendorProvider(user.id));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Settings'),
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Business Info',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 12),
                      _InfoRow(label: 'Name', value: vendor.businessName),
                      _InfoRow(label: 'Email', value: vendor.email),
                      _InfoRow(label: 'Phone', value: vendor.phone),
                      if (vendor.address != null)
                        _InfoRow(label: 'Address', value: vendor.address!),
                      if (vendor.city != null)
                        _InfoRow(label: 'City', value: vendor.city!),
                      if (vendor.state != null)
                        _InfoRow(label: 'State', value: vendor.state!),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(153),
                  ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
