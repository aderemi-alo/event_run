/// Parameters required for the signup use case.
class SignupParams {
  final String fullName;
  final String phone; // raw local input (e.g. "08012345678")
  final String email;
  final String password;

  const SignupParams({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.password,
  });
}
