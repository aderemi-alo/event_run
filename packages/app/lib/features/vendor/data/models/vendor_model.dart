import 'package:event_run/features/vendor/domain/entities/vendor_entity.dart';

class VendorModel extends VendorEntity {
  const VendorModel({
    required super.id,
    required super.businessName,
    super.logoUrl,
    required super.email,
    required super.phone,
    super.address,
    super.city,
    super.state,
    super.bankName,
    super.accountName,
    super.accountNumber,
    super.plan,
    super.planExpiresAt,
    required super.createdAt,
    required super.ownerId,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json['id'] as String,
      businessName: json['business_name'] as String,
      logoUrl: json['logo_url'] as String?,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      bankName: json['bank_name'] as String?,
      accountName: json['account_name'] as String?,
      accountNumber: json['account_number'] as String?,
      plan: VendorPlan.values.byName(json['plan'] as String? ?? 'free'),
      planExpiresAt: json['plan_expires_at'] != null
          ? DateTime.parse(json['plan_expires_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      ownerId: json['owner_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_name': businessName,
      'logo_url': logoUrl,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'bank_name': bankName,
      'account_name': accountName,
      'account_number': accountNumber,
      'plan': plan.name,
      'plan_expires_at': planExpiresAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'owner_id': ownerId,
    };
  }
}
