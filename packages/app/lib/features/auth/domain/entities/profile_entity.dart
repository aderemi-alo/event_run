class ProfileEntity {
  final String id;
  final String email;
  final String fullName;
  final String phone;
  final String? avatarUrl;
  final DateTime createdAt;

  const ProfileEntity({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phone,
    this.avatarUrl,
    required this.createdAt,
  });
}
