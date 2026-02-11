import 'package:flutter/material.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/events/domain/entities/inventory_conflict_entity.dart';

class ConflictBanner extends StatelessWidget {
  const ConflictBanner({super.key, required this.conflicts});

  final List<InventoryConflictEntity> conflicts;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: AppColors.warning.withAlpha(30),
      child: Row(
        children: [
          const Icon(Icons.warning_amber, color: AppColors.warning, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '${conflicts.length} inventory conflict${conflicts.length > 1 ? 's' : ''} detected',
              style: const TextStyle(
                color: AppColors.warning,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
