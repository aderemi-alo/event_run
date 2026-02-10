class InvoiceItemEntity {
  final String id;
  final String invoiceId;
  final String description;
  final int quantity;
  final num unitPrice;

  const InvoiceItemEntity({
    required this.id,
    required this.invoiceId,
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });

  num get total => quantity * unitPrice;
}
