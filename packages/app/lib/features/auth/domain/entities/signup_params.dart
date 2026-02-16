/// Parameters required for the signup use case.
class SignupParams {
  final String fullName;
  final String phone;
  final String email;
  final String password;

  const SignupParams({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.password,
  });
}
