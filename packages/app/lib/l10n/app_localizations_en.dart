// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'EventLock';

  @override
  String get common_save => 'Save';

  @override
  String get common_cancel => 'Cancel';

  @override
  String get auth_email => 'Email';

  @override
  String get auth_password => 'Password';

  @override
  String get auth_signIn => 'Sign in';

  @override
  String get createYourAccount => 'Create Your Account';

  @override
  String get fullName => 'Full Name';

  @override
  String get fullNameHint => 'e.g. Tunde Bakare';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get phoneNumberHint => '0876 543 2100';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get emailAddressHint => 'you@example.com';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => '••••••••';

  @override
  String get nextStep => 'Next Step';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get logIn => 'Log in';

  @override
  String requiredField(String fieldName) {
    return '$fieldName is required';
  }

  @override
  String get invalidEmail => 'Please enter a valid email';

  @override
  String get invalidPhoneStart => 'Phone number must start with +234 or 0';

  @override
  String get invalidPhoneLength => 'Please enter a valid phone number';

  @override
  String get passwordLength => 'Password must be at least 8 characters';

  @override
  String get passwordUppercase =>
      'Password must contain at least one uppercase letter';

  @override
  String get passwordLowercase =>
      'Password must contain at least one lowercase letter';

  @override
  String get passwordNumber => 'Password must contain at least one number';

  @override
  String get invalidNumber => 'Please enter a valid number';

  @override
  String positiveNumber(String fieldName) {
    return '$fieldName must be greater than 0';
  }

  @override
  String get valueMustBeGreaterThanZero => 'Value must be greater than 0';

  @override
  String get thisField => 'This field';
}
