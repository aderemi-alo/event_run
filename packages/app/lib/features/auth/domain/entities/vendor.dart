import 'package:equatable/equatable.dart';

/// Vendor entity representing the event business owner
class Vendor extends Equatable {
  const Vendor({
    required this.id,
    required this.businessName,
    required this.fullName,
    required this.email,
    required this.phone,
  });

  final String id;
  final String businessName;
  final String fullName;
  final String email;
  final String phone;

  @override
  List<Object?> get props => [id, businessName, fullName, email, phone];
}
