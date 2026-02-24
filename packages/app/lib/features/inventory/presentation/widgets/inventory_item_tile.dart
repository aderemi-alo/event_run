import 'package:app/core/theme/app_color_set.dart';
import 'package:app/core/theme/app_typography.dart';
import 'package:app/core/utils/extensions.dart';
import 'package:app/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:app/shared/widgets/app_action_button.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class InventoryItemTile extends StatelessWidget {
  final InventoryItemEntity item;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  const InventoryItemTile({
    super.key,
    required this.item,
    required this.onTap,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        hoverColor: context.colors.surfaceTertiary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 16,
            top: 12,
            bottom: 12,
          ),
          child: Row(
            children: [
              // Name
              Expanded(
                flex: 4,
                child: Text(
                  item.name.vToTitleCase(),
                  style: context.textTheme.bodyLarge?.vCopyWith(
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
              ),

              Expanded(
                flex: 2,
                child: Center(
                  child: item.category != null
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: context.colors.surfaceTertiary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item.category ?? '-',
                            style: context.textTheme.bodySmall?.vCopyWith(
                              fontWeight: AppFontWeight.semiBold,
                            ),
                          ),
                        )
                      : Text(
                          '-',
                          style: context.textTheme.bodySmall?.vCopyWith(
                            fontWeight: AppFontWeight.semiBold,
                          ),
                        ),
                ),
              ),

              // Quantity
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    item.quantity.toString(),
                    style: context.textTheme.bodyLarge?.vCopyWith(
                      fontWeight: AppFontWeight.semiBold,
                    ),
                  ),
                ),
              ),
              // Edit button
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    AppActionButton(
                      icon: LucideIcons.pencil,
                      onPressed: onEdit,
                      type: ActionButtonType.primary,
                    ),
                    const SizedBox(width: 2),

                    AppActionButton(
                      icon: LucideIcons.trash2,
                      onPressed: onEdit,
                      type: ActionButtonType.destructive,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
