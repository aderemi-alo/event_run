import 'package:app/core/router/route_names.dart';
import 'package:app/core/theme/app_color_set.dart';
import 'package:app/core/theme/app_typography.dart';
import 'package:app/core/utils/extensions.dart';
import 'package:app/features/inventory/presentation/providers/inventory_providers_di.dart';
import 'package:app/features/inventory/presentation/widgets/filter_chip.dart';
import 'package:app/features/inventory/presentation/widgets/inventory_item_tile.dart';
import 'package:app/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:go_router/go_router.dart';

class InventoryListScreen extends ConsumerStatefulWidget {
  const InventoryListScreen({super.key});

  @override
  ConsumerState<InventoryListScreen> createState() =>
      _InventoryListScreenState();
}

class _InventoryListScreenState extends ConsumerState<InventoryListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(inventoryNotifierProvider.notifier).loadInventoryScreen(),
    );
  }

  String _searchQuery = '';
  String? _selectedCategory;

  List<InventoryItemEntity> _applyFilters(List<InventoryItemEntity> items) {
    var filtered = items;

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered
          .where((item) => item.name.toLowerCase().contains(query))
          .toList();
    }

    if (_selectedCategory != null) {
      filtered = filtered
          .where((item) => item.category == _selectedCategory)
          .toList();
    }

    return filtered;
  }

  int _totalQuantity(List<InventoryItemEntity> items) {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  void _navigateToCreate() {
    context.pushNamed(RouteNames.createInventory);
  }

  void _navigateToDetail(InventoryItemEntity item, {bool edit = false}) {
    context.pushNamed(
      RouteNames.inventoryDetail,
      pathParameters: {'id': item.id},
      queryParameters: {'edit': edit.toString()},
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inventoryNotifierProvider);
    final items = state.inventoryItems;
    final categories = state.categories;

    // Loading state
    if (state.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Empty state
    if (items.isEmpty) {
      return Scaffold(body: _EmptyState(onAddItem: _navigateToCreate));
    }

    final filtered = _applyFilters(items);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _Header(
                  totalQuantity: _totalQuantity(items),
                  onAddItem: _navigateToCreate,
                ),

                const SizedBox(height: 16),

                // Search + category filter
                _SearchAndFilter(
                  searchQuery: _searchQuery,
                  selectedCategory: _selectedCategory,
                  categories: categories,
                  onSearchChanged: (query) {
                    setState(() => _searchQuery = query);
                  },
                  onCategoryChanged: (cat) {
                    setState(() => _selectedCategory = cat);
                  },
                ),

                // Item list
                Expanded(
                  child: filtered.isEmpty
                      ? _NoResults(
                          onClear: () {
                            setState(() {
                              _searchQuery = '';
                              _selectedCategory = null;
                            });
                          },
                        )
                      : _InventoryTable(
                          items: filtered,
                          onItemTap: (item) => _navigateToDetail(item),
                          onEditTap: (item) =>
                              _navigateToDetail(item, edit: true),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────
// EMPTY STATE
// ──────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final VoidCallback onAddItem;

  const _EmptyState({required this.onAddItem});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.inventory_2_outlined,
                size: 48,
                color: Colors.grey.shade300,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No inventory yet',
              style: textTheme.headlineLarge?.vCopyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add your equipment (Speakers, Chairs, Lights, etc)'
              '\nso you can track them in your events.',
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.vCopyWith(
                color: colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 32),
            AppButton(
              label: 'Add First Item',
              onPressed: onAddItem,
              leading: Icons.add,
              expand: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final int totalQuantity;
  final VoidCallback onAddItem;

  const _Header({required this.totalQuantity, required this.onAddItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manage Your Equipment',
                style: context.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Track your stock and avoid shortages.',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.appColors.textTertiary,
                ),
              ),
            ],
          ),
          AppButton(
            expand: false,
            leading: Icons.add,
            label: 'Add Item',
            onPressed: onAddItem,
            height: 40,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ],
      ),
    );
  }
}

// Search and Category filter
class _SearchAndFilter extends StatelessWidget {
  final String searchQuery;
  final String? selectedCategory;
  final List<String> categories;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String?> onCategoryChanged;

  const _SearchAndFilter({
    required this.searchQuery,
    required this.selectedCategory,
    required this.categories,
    required this.onSearchChanged,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.outline),
        boxShadow: [
          BoxShadow(
            color: context.appColors.mode.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Search bar
            Container(
              constraints: const BoxConstraints(maxWidth: 300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                onChanged: onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search inventory...',
                  prefixIcon: const Icon(Icons.search, size: 20),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 60),

            // Category chips
            if (categories.length > 1)
              Expanded(
                child: SizedBox(
                  height: 30,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        CategoryFilterChip(
                          label: 'All',
                          isSelected: selectedCategory == null,
                          onTap: () => onCategoryChanged(null),
                        ),
                        const SizedBox(width: 8),
                        ...categories.map(
                          (cat) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: CategoryFilterChip(
                              label: cat,
                              isSelected: selectedCategory == cat,
                              onTap: () => onCategoryChanged(cat),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NoResults extends StatelessWidget {
  final VoidCallback onClear;

  const _NoResults({required this.onClear});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 48, color: Colors.grey.shade300),
          const SizedBox(height: 12),
          Text(
            'No items match your filters',
            style: TextStyle(color: Colors.grey.shade500),
          ),
          const SizedBox(height: 12),
          TextButton(onPressed: onClear, child: const Text('Clear filters')),
        ],
      ),
    );
  }
}

class _InventoryTable extends StatelessWidget {
  final List<InventoryItemEntity> items;
  final ValueChanged<InventoryItemEntity> onItemTap;
  final ValueChanged<InventoryItemEntity> onEditTap;

  const _InventoryTable({
    required this.items,
    required this.onItemTap,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(flex: 4, child: Text('Item')),
            Expanded(flex: 2, child: Center(child: Text('Category'))),
            Expanded(flex: 2, child: Center(child: Text('Quantity Owned'))),
            Expanded(flex: 1, child: Center(child: Text('Actions'))),
          ],
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = items[index];
              return InventoryItemTile(
                item: item,
                onTap: () => onItemTap(item),
                onEdit: () => onEditTap(item),
              );
            },
          ),
        ),
      ],
    );
  }
}
