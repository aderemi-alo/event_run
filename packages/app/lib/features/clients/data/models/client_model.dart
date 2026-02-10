import 'package:event_run/features/clients/domain/entities/client_entity.dart';

class ClientModel extends ClientEntity {
  const ClientModel({
    required super.id,
    required super.vendorId,
    required super.fullName,
    super.email,
    super.phone,
    super.notes,
    required super.createdAt,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'] as String,
      vendorId: json['vendor_id'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendor_id': vendorId,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
