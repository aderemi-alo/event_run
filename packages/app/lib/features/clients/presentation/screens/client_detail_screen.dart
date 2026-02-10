import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:event_run/core/widgets/app_loading.dart';
import 'package:event_run/core/widgets/app_error_widget.dart';
import 'package:event_run/features/clients/presentation/providers/client_providers.dart';

class ClientDetailScreen extends ConsumerWidget {
  const ClientDetailScreen({super.key, required this.clientId});

  final String clientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientAsync = ref.watch(clientDetailProvider(clientId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Delete Client'),
                  content: const Text(
                      'Are you sure you want to delete this client?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
              if (confirmed == true && context.mounted) {
                await ref
                    .read(deleteClientUsecaseProvider)
                    .call(clientId);
                if (context.mounted) context.pop();
              }
            },
          ),
        ],
      ),
      body: clientAsync.when(
        loading: () => const AppLoading(),
        error: (e, _) => AppErrorWidget(
          message: e.toString(),
          onRetry: () => ref.invalidate(clientDetailProvider(clientId)),
        ),
        data: (client) {
          if (client == null) {
            return const AppErrorWidget(message: 'Client not found');
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: CircleAvatar(
                  radius: 40,
                  child: Text(
                    client.fullName.isNotEmpty
                        ? client.fullName[0].toUpperCase()
                        : '?',
                    style: theme.textTheme.headlineMedium,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                client.fullName,
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (client.email != null)
                        ListTile(
                          leading: const Icon(Icons.email_outlined),
                          title: Text(client.email!),
                          contentPadding: EdgeInsets.zero,
                        ),
                      if (client.phone != null)
                        ListTile(
                          leading: const Icon(Icons.phone_outlined),
                          title: Text(client.phone!),
                          contentPadding: EdgeInsets.zero,
                        ),
                      if (client.notes != null) ...[
                        const Divider(),
                        const SizedBox(height: 8),
                        Text('Notes',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withAlpha(153),
                            )),
                        const SizedBox(height: 4),
                        Text(client.notes!),
                      ],
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
