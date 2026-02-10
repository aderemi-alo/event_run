class ClientEntity {
  final String id;
  final String vendorId;
  final String fullName;
  final String? email;
  final String? phone;
  final String? notes;
  final DateTime createdAt;

  const ClientEntity({
    required this.id,
    required this.vendorId,
    required this.fullName,
    this.email,
    this.phone,
    this.notes,
    required this.createdAt,
  });
}
