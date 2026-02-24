import 'package:app/core/theme/app_color_set.dart';
import 'package:app/core/theme/app_typography.dart';
import 'package:app/core/utils/extensions.dart';
import 'package:app/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:flutter/material.dart';

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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            // Name
            Expanded(
              flex: 4,
              child: Text(
                item.name,
                style: context.textTheme.bodyLarge?.vCopyWith(
                  fontWeight: FontWeight.w500,
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
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : Text(
                        '-',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            // Edit button
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: onEdit,
                icon: Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: Colors.grey.shade400,
                ),
                splashRadius: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
