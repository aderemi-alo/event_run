import 'package:event_run/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:event_run/features/inventory/domain/repositories/inventory_repository.dart';

class GetInventoryItems {
  final InventoryRepository _repository;

  GetInventoryItems(this._repository);

  Future<List<InventoryItemEntity>> call(String vendorId) {
    return _repository.getInventoryItems(vendorId);
  }
}
