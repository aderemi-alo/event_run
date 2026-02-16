class UpdateVendorParams {
  final String vendorId;
  final String? businessName;
  final String? email;
  final String? phone;
  final String? address;
  final String? city;
  final String? state;
  final String? bankName;
  final String? accountName;
  final String? accountNumber;
  final String? plan;
  final String? logoUrl;

  UpdateVendorParams({
    required this.vendorId,
    this.businessName,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.state,
    this.bankName,
    this.accountName,
    this.accountNumber,
    this.plan,
    this.logoUrl,
  });

  UpdateVendorParams copyWith({
    String? vendorId,
    String? businessName,
    String? email,
    String? phone,
    String? address,
    String? city,
    String? state,
    String? bankName,
    String? accountName,
    String? accountNumber,
    String? plan,
    String? logoUrl,
  }) {
    return UpdateVendorParams(
      vendorId: vendorId ?? this.vendorId,
      businessName: businessName ?? this.businessName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      bankName: bankName ?? this.bankName,
      accountName: accountName ?? this.accountName,
      accountNumber: accountNumber ?? this.accountNumber,
      plan: plan ?? this.plan,
      logoUrl: logoUrl ?? this.logoUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (businessName != null) 'business_name': businessName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (bankName != null) 'bank_name': bankName,
      if (accountName != null) 'account_name': accountName,
      if (accountNumber != null) 'account_number': accountNumber,
      if (logoUrl != null) 'logo_url': logoUrl,
    };
  }
}
