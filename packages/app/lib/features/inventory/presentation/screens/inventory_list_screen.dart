import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app/core/router/route_names.dart';
import 'package:app/core/widgets/app_loading.dart';
import 'package:app/core/widgets/app_error_widget.dart';
import 'package:app/core/widgets/empty_state_widget.dart';
import 'package:app/features/inventory/presentation/providers/inventory_providers.dart';
import 'package:app/features/inventory/presentation/widgets/inventory_card.dart';
import 'package:app/features/inventory/presentation/widgets/category_filter_chips.dart';

class InventoryListScreen extends ConsumerStatefulWidget {
  const InventoryListScreen({super.key, required this.vendorId});

  final String vendorId;

  @override
  ConsumerState<InventoryListScreen> createState() =>
      _InventoryListScreenState();
}

class _InventoryListScreenState extends ConsumerState<InventoryListScreen> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(inventoryItemsProvider(widget.vendorId));

    return Scaffold(
      appBar: AppBar(title: const Text('Inventory')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(RouteNames.inventoryForm),
        child: const Icon(Icons.add),
      ),
      body: itemsAsync.when(
        loading: () => const AppLoading(),
        error: (e, _) => AppErrorWidget(
          message: e.toString(),
          onRetry: () =>
              ref.invalidate(inventoryItemsProvider(widget.vendorId)),
        ),
        data: (items) {
          if (items.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.inventory_2_outlined,
              title: 'No inventory items',
              subtitle: 'Add equipment and supplies to track',
            );
          }

          final categories =
              items
                  .where((i) => i.category != null)
                  .map((i) => i.category!)
                  .toSet()
                  .toList()
                ..sort();

          final filtered = _selectedCategory == null
              ? items
              : items.where((i) => i.category == _selectedCategory).toList();

          return Column(
            children: [
              if (categories.isNotEmpty)
                CategoryFilterChips(
                  categories: categories,
                  selected: _selectedCategory,
                  onSelected: (cat) {
                    setState(() {
                      _selectedCategory = cat == _selectedCategory ? null : cat;
                    });
                  },
                ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(inventoryItemsProvider(widget.vendorId));
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      return InventoryCard(item: filtered[index]);
                    },
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
