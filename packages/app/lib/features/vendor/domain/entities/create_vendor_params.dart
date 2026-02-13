class CreateVendorParams {
  final String businessName;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String bankName;
  final String accountName;
  final String accountNumber;
  final String plan;
  final String ownerId;
  final String? logoUrl;

  CreateVendorParams({
    required this.businessName,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
    required this.plan,
    required this.ownerId,
    this.logoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'business_name': businessName,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'bank_name': bankName,
      'account_name': accountName,
      'account_number': accountNumber,
      'plan': plan,
      'owner_id': ownerId,
      if (logoUrl != null) 'logo_url': logoUrl,
    };
  }
}
