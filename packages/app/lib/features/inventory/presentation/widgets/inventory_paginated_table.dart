import 'dart:math';

import 'package:app/core/theme/app_color_set.dart';
import 'package:app/core/theme/app_typography.dart';
import 'package:app/core/utils/extensions.dart';
import 'package:app/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:app/features/inventory/presentation/widgets/inventory_item_tile.dart';
import 'package:app/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';

class InventoryPaginatedTable extends StatefulWidget {
  final List<InventoryItemEntity> items;
  final ValueChanged<InventoryItemEntity> onItemTap;
  final ValueChanged<InventoryItemEntity> onEditTap;

  const InventoryPaginatedTable({
    super.key,
    required this.items,
    required this.onItemTap,
    required this.onEditTap,
  });

  @override
  State<InventoryPaginatedTable> createState() =>
      _InventoryPaginatedTableState();
}

class _InventoryPaginatedTableState extends State<InventoryPaginatedTable> {
  static const int _itemsPerPage = 10;
  int _currentPage = 0;

  @override
  void didUpdateWidget(covariant InventoryPaginatedTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset page if the items list changes significantly (e.g. search/filter)
    if (widget.items != oldWidget.items) {
      if (_currentPage > 0) {
        final maxPage = max(
          0,
          ((widget.items.length - 1) / _itemsPerPage).floor(),
        );
        if (_currentPage > maxPage) {
          _currentPage = 0;
        }
      }
    }
  }

  int get _totalPages => max(1, (widget.items.length / _itemsPerPage).ceil());

  List<InventoryItemEntity> get _currentPageItems {
    final startIndex = _currentPage * _itemsPerPage;
    final endIndex = min(startIndex + _itemsPerPage, widget.items.length);

    if (startIndex >= widget.items.length) {
      return [];
    }
    return widget.items.sublist(startIndex, endIndex);
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentItems = _currentPageItems;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
              vertical: BorderSide(color: context.colors.borderLight),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 16,
              top: 16,
              bottom: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    context.l10n.inventory_itemTable_name,
                    style: context.textTheme.bodyMedium?.vCopyWith(
                      color: context.colors.textTertiary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      context.l10n.inventory_itemTable_category,
                      style: context.textTheme.bodyMedium?.vCopyWith(
                        color: context.colors.textTertiary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      context.l10n.inventory_itemTable_quantity,
                      style: context.textTheme.bodyMedium?.vCopyWith(
                        color: context.colors.textTertiary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      context.l10n.inventory_itemTable_actions,
                      style: context.textTheme.bodyMedium?.vCopyWith(
                        color: context.colors.textTertiary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.colors.surfacePrimary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            border: Border(
              bottom: BorderSide(color: context.colors.borderLight),
              left: BorderSide(color: context.colors.borderLight),
              right: BorderSide(color: context.colors.borderLight),
            ),
            boxShadow: [
              BoxShadow(
                color: context.colors.onMode.withValues(alpha: 0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: currentItems.length,
            separatorBuilder: (_, __) =>
                Divider(height: 1, color: context.colors.borderLight),
            itemBuilder: (context, index) {
              final item = currentItems[index];
              return Padding(
                padding: const EdgeInsets.only(left: 24, right: 16),
                child: InventoryItemTile(
                  item: item,
                  onTap: () => widget.onItemTap(item),
                  onEdit: () => widget.onEditTap(item),
                ),
              );
            },
          ),
        ),
        // Pagination Controls
        if (widget.items.length > _itemsPerPage)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.inventory_pagination_page(
                    _currentPage + 1,
                    _totalPages,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium?.vCopyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
                Row(
                  children: [
                    AppButton(
                      label: context.l10n.inventory_pagination_previous,
                      onPressed: _currentPage > 0 ? _previousPage : null,
                      expand: false,
                      height: 36,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                    const SizedBox(width: 8),
                    AppButton(
                      label: context.l10n.inventory_pagination_next,
                      onPressed: _currentPage < _totalPages - 1
                          ? _nextPage
                          : null,
                      expand: false,
                      height: 36,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
