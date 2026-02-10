import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:event_run/core/widgets/app_loading.dart';
import 'package:event_run/core/widgets/app_error_widget.dart';
import 'package:event_run/core/widgets/empty_state_widget.dart';
import 'package:event_run/features/events/presentation/providers/event_requirement_providers.dart';
import 'package:event_run/features/events/presentation/widgets/conflict_banner.dart';

class EventRequirementsScreen extends ConsumerWidget {
  const EventRequirementsScreen({super.key, required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requirementsAsync = ref.watch(eventRequirementsProvider(eventId));
    final conflictsAsync = ref.watch(inventoryConflictsProvider(eventId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Requirements'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Show add requirement dialog
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          conflictsAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (conflicts) {
              if (conflicts.isEmpty) return const SizedBox.shrink();
              return ConflictBanner(conflicts: conflicts);
            },
          ),
          Expanded(
            child: requirementsAsync.when(
              loading: () => const AppLoading(),
              error: (e, _) => AppErrorWidget(
                message: e.toString(),
                onRetry: () =>
                    ref.invalidate(eventRequirementsProvider(eventId)),
              ),
              data: (requirements) {
                if (requirements.isEmpty) {
                  return const EmptyStateWidget(
                    icon: Icons.checklist_outlined,
                    title: 'No requirements',
                    subtitle: 'Add inventory items needed for this event',
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: requirements.length,
                  itemBuilder: (context, index) {
                    final req = requirements[index];
                    return Card(
                      child: ListTile(
                        title: Text('Item: ${req.inventoryItemId}'),
                        subtitle: Text('Qty: ${req.quantity}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () async {
                            await ref
                                .read(eventRequirementRepositoryProvider)
                                .removeRequirement(req.id);
                            ref.invalidate(
                                eventRequirementsProvider(eventId));
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
