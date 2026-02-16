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
            // Thumbnail
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              clipBehavior: Clip.antiAlias,
              child: (item.imageUrl != null && item.imageUrl!.isNotEmpty)
                  ? Image.network(item.imageUrl!, fit: BoxFit.cover)
                  : Icon(
                      Icons.inventory_2_outlined,
                      size: 20,
                      color: Colors.grey.shade400,
                    ),
            ),
            const SizedBox(width: 12),

            // Name + low stock warning
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item.category ?? '-',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      if (item.quantity < 5) ...[
                        const SizedBox(width: 8),
                        const Text(
                          'Low Stock',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 2,
              child: Text(
                item.category ?? '-',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),

            // Quantity
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
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
            IconButton(
              onPressed: onEdit,
              icon: Icon(
                Icons.edit_outlined,
                size: 18,
                color: Colors.grey.shade400,
              ),
              splashRadius: 20,
            ),
          ],
        ),
      ),
    );
  }
}
