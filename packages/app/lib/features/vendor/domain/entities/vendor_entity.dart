enum VendorPlan {
  free,
  pro;

  String get displayName {
    switch (this) {
      case VendorPlan.free:
        return 'Free';
      case VendorPlan.pro:
        return 'Pro';
    }
  }
}

class VendorEntity {
  final String id;
  final String businessName;
  final String? logoUrl;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String bankName;
  final String accountName;
  final String accountNumber;
  final VendorPlan plan;
  final DateTime? planExpiresAt;
  final DateTime createdAt;
  final String ownerId;

  const VendorEntity({
    required this.id,
    required this.businessName,
    this.logoUrl,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
    this.plan = VendorPlan.free,
    this.planExpiresAt,
    required this.createdAt,
    required this.ownerId,
  });

  bool get isProPlan =>
      plan == VendorPlan.pro &&
      planExpiresAt != null &&
      planExpiresAt!.isAfter(DateTime.now());
}
