import 'package:equatable/equatable.dart';

/// Client entity
class Client extends Equatable {
  const Client({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.lastEventDate,
  });

  final String id;
  final String name;
  final String phone;
  final String? email;
  final String? lastEventDate;

  @override
  List<Object?> get props => [id, name, phone, email, lastEventDate];
}
