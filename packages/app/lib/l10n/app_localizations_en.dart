// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'EventRun';

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
  String get phoneNumberHint => '876 543 2100';

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
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get logIn => 'Log in';

  @override
  String get login => 'Login';

  @override
  String get signUp => 'Sign Up';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get loginToManageEvents => 'Login to manage your events';

  @override
  String get forgotPassword => 'Forgot password?';

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

  @override
  String get bySigningUpYouAgreeToOur => 'By continuing, you agree to our ';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get and => 'and';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get createAccount => 'Create Account';

  @override
  String get signupSubtitle => 'Get Started With Event Run';

  @override
  String get accountCreatedSuccessfully => 'Account created successfully!';

  @override
  String get setupYourBusiness => 'Setup your Business';

  @override
  String get setupBusinessSubtitle =>
      'Let\'s get your profile ready for clients.';

  @override
  String get businessDetails => 'Business Details';

  @override
  String get businessName => 'Business Name';

  @override
  String get businessNameHint => 'e.g. Royal Events & Decor';

  @override
  String get businessEmail => 'Business Email';

  @override
  String get businessPhone => 'Business Phone';

  @override
  String get officeAddress => 'Office Address';

  @override
  String get officeAddressHint => '123 Admiralty Way';

  @override
  String get city => 'City';

  @override
  String get cityHint => 'Lekki';

  @override
  String get state => 'State';

  @override
  String get chooseLogo => 'Choose Logo';

  @override
  String get logoMaxWeight => 'Optional. Max 2MB.';

  @override
  String get bankDetails => 'Bank Details';

  @override
  String get bankDetailsSubtitle =>
      'These details appear on invoices so clients know where to pay.';

  @override
  String get bankInfoBanner =>
      'These details are used on client-facing invoices.';

  @override
  String get bankName => 'Bank Name';

  @override
  String get selectBank => 'Select bank';

  @override
  String get bankNameRequired => 'Select a bank';

  @override
  String get accountNumber => 'Account Number';

  @override
  String get accountNumberRequired => 'Account number is required';

  @override
  String get accountNumberLength => 'Account number must be 10 digits';

  @override
  String get accountName => 'Account Name';

  @override
  String get accountNameHint => 'Matches your bank account name';

  @override
  String get selectPlan => 'Select a Plan';

  @override
  String get selectPlanSubtitle =>
      'You can change plans later from subscription settings.';

  @override
  String get starterPlan => 'Starter';

  @override
  String get free => 'Free';

  @override
  String get starterFeatures => '5 Events/mo, Basic Invoices';

  @override
  String get proBusinessPlan => 'Pro Business';

  @override
  String get proPrice => '₦6,000';

  @override
  String get monthSuffix => '/month';

  @override
  String get proFeatures =>
      'Unlimited Events, Unlimited Invoices, Priority Support';

  @override
  String get recommended => 'RECOMMENDED';

  @override
  String get proceedToPayment => 'Proceed to Payment';

  @override
  String get completeSetup => 'Complete Setup';

  @override
  String get notSignedInError =>
      'You are not signed in. Please sign in and try again.';

  @override
  String get checkingBusinessProfile => 'Checking your business profile...';

  @override
  String get couldNotVerifyBusinessProfile =>
      'We could not verify your business profile.';

  @override
  String get retry => 'Retry';
}
