class EventRequirementEntity {
  final String id;
  final String eventId;
  final String inventoryItemId;
  final int quantity;
  final String? notes;
  final DateTime createdAt;

  const EventRequirementEntity({
    required this.id,
    required this.eventId,
    required this.inventoryItemId,
    required this.quantity,
    this.notes,
    required this.createdAt,
  });
}
