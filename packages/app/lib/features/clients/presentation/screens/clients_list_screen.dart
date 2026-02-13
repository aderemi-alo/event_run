import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app/core/router/route_names.dart';
import 'package:app/core/widgets/app_loading.dart';
import 'package:app/core/widgets/app_error_widget.dart';
import 'package:app/core/widgets/empty_state_widget.dart';
import 'package:app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:app/features/clients/presentation/providers/client_providers.dart';
import 'package:app/features/clients/presentation/widgets/client_card.dart';
import 'package:app/features/clients/presentation/widgets/client_search_delegate.dart';

class ClientsListScreen extends ConsumerWidget {
  const ClientsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vendorId = ref.watch(currentVendorIdProvider);

    if (vendorId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Clients')),
        body: AppErrorWidget(
          message: 'Complete business setup to manage clients.',
          onRetry: () => ref.invalidate(routeAccessStateProvider),
        ),
      );
    }

    final clientsAsync = ref.watch(clientsProvider(vendorId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clients'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              final clients = clientsAsync.asData?.value ?? [];
              showSearch(
                context: context,
                delegate: ClientSearchDelegate(clients: clients),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(RouteNames.clients),
        child: const Icon(Icons.add),
      ),
      body: clientsAsync.when(
        loading: () => const AppLoading(),
        error: (e, _) => AppErrorWidget(
          message: e.toString(),
          onRetry: () => ref.invalidate(clientsProvider(vendorId)),
        ),
        data: (clients) {
          if (clients.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.people_outline,
              title: 'No clients yet',
              subtitle: 'Add your first client to get started',
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(clientsProvider(vendorId));
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: clients.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                return ClientCard(
                  client: clients[index],
                  onTap: () => context.pushNamed(
                    RouteNames.clientDetail,
                    pathParameters: {'id': clients[index].id},
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
