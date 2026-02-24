import 'package:app/core/router/route_names.dart';
import 'package:app/core/theme/app_color_set.dart';
import 'package:app/core/theme/app_typography.dart';
import 'package:app/core/utils/extensions.dart';
import 'package:app/features/inventory/presentation/providers/inventory_providers_di.dart';
import 'package:app/features/inventory/presentation/widgets/filter_chip.dart';
import 'package:app/features/inventory/presentation/widgets/inventory_paginated_table.dart';
import 'package:app/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: SingleChildScrollView(
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
                    filtered.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: _NoResults(
                              onClear: () {
                                setState(() {
                                  _searchQuery = '';
                                  _selectedCategory = null;
                                });
                              },
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: InventoryPaginatedTable(
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
              context.l10n.inventory_noInventory,
              style: textTheme.headlineLarge?.vCopyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.inventory_emptySubtitle,
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.vCopyWith(
                color: colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 32),
            AppButton(
              label: context.l10n.inventory_addFirstItem,
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
                context.l10n.inventory_manageEquipment,
                style: context.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                context.l10n.inventory_trackStock,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.textTertiary,
                ),
              ),
            ],
          ),
          AppButton(
            expand: false,
            leading: LucideIcons.plus,
            label: context.l10n.inventory_addItem,
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
        color: context.colors.surfacePrimary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border.all(color: context.colors.borderLight),
        boxShadow: [
          BoxShadow(
            color: context.colors.onMode.withValues(alpha: 0.05),
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
                  hintText: context.l10n.inventory_searchHint,
                  prefixIcon: const Icon(LucideIcons.search, size: 20),
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
                          label: context.l10n.inventory_category_all,
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
            context.l10n.inventory_noResults,
            style: TextStyle(color: Colors.grey.shade500),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: onClear,
            child: Text(context.l10n.inventory_clearFilters),
          ),
        ],
      ),
    );
  }
}
