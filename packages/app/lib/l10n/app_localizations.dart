import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'EventRun'**
  String get appName;

  /// No description provided for @common_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get common_save;

  /// No description provided for @common_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get common_cancel;

  /// No description provided for @auth_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get auth_email;

  /// No description provided for @auth_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get auth_password;

  /// No description provided for @auth_signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get auth_signIn;

  /// No description provided for @createYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Your Account'**
  String get createYourAccount;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Tunde Bakare'**
  String get fullNameHint;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @phoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'876 543 2100'**
  String get phoneNumberHint;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @emailAddressHint.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get emailAddressHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'••••••••'**
  String get passwordHint;

  /// No description provided for @nextStep.
  ///
  /// In en, this message translates to:
  /// **'Next Step'**
  String get nextStep;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @loginToManageEvents.
  ///
  /// In en, this message translates to:
  /// **'Login to manage your events'**
  String get loginToManageEvents;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'{fieldName} is required'**
  String requiredField(String fieldName);

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmail;

  /// No description provided for @invalidPhoneStart.
  ///
  /// In en, this message translates to:
  /// **'Phone number must start with +234 or 0'**
  String get invalidPhoneStart;

  /// No description provided for @invalidPhoneLength.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get invalidPhoneLength;

  /// No description provided for @passwordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordLength;

  /// No description provided for @passwordUppercase.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter'**
  String get passwordUppercase;

  /// No description provided for @passwordLowercase.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one lowercase letter'**
  String get passwordLowercase;

  /// No description provided for @passwordNumber.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one number'**
  String get passwordNumber;

  /// No description provided for @invalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get invalidNumber;

  /// No description provided for @positiveNumber.
  ///
  /// In en, this message translates to:
  /// **'{fieldName} must be greater than 0'**
  String positiveNumber(String fieldName);

  /// No description provided for @valueMustBeGreaterThanZero.
  ///
  /// In en, this message translates to:
  /// **'Value must be greater than 0'**
  String get valueMustBeGreaterThanZero;

  /// No description provided for @thisField.
  ///
  /// In en, this message translates to:
  /// **'This field'**
  String get thisField;

  /// No description provided for @bySigningUpYouAgreeToOur.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our '**
  String get bySigningUpYouAgreeToOur;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @signupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get Started With Event Run'**
  String get signupSubtitle;

  /// No description provided for @accountCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully!'**
  String get accountCreatedSuccessfully;

  /// No description provided for @setupYourBusiness.
  ///
  /// In en, this message translates to:
  /// **'Setup your Business'**
  String get setupYourBusiness;

  /// No description provided for @setupBusinessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get your profile ready for clients.'**
  String get setupBusinessSubtitle;

  /// No description provided for @businessDetails.
  ///
  /// In en, this message translates to:
  /// **'Business Details'**
  String get businessDetails;

  /// No description provided for @businessName.
  ///
  /// In en, this message translates to:
  /// **'Business Name'**
  String get businessName;

  /// No description provided for @businessNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Royal Events & Decor'**
  String get businessNameHint;

  /// No description provided for @businessEmail.
  ///
  /// In en, this message translates to:
  /// **'Business Email'**
  String get businessEmail;

  /// No description provided for @businessPhone.
  ///
  /// In en, this message translates to:
  /// **'Business Phone'**
  String get businessPhone;

  /// No description provided for @officeAddress.
  ///
  /// In en, this message translates to:
  /// **'Office Address'**
  String get officeAddress;

  /// No description provided for @officeAddressHint.
  ///
  /// In en, this message translates to:
  /// **'123 Admiralty Way'**
  String get officeAddressHint;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @cityHint.
  ///
  /// In en, this message translates to:
  /// **'Lekki'**
  String get cityHint;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @chooseLogo.
  ///
  /// In en, this message translates to:
  /// **'Choose Logo'**
  String get chooseLogo;

  /// No description provided for @logoMaxWeight.
  ///
  /// In en, this message translates to:
  /// **'Optional. Max 2MB.'**
  String get logoMaxWeight;

  /// No description provided for @bankDetails.
  ///
  /// In en, this message translates to:
  /// **'Bank Details'**
  String get bankDetails;

  /// No description provided for @bankDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'These details appear on invoices so clients know where to pay.'**
  String get bankDetailsSubtitle;

  /// No description provided for @bankInfoBanner.
  ///
  /// In en, this message translates to:
  /// **'These details are used on client-facing invoices.'**
  String get bankInfoBanner;

  /// No description provided for @bankName.
  ///
  /// In en, this message translates to:
  /// **'Bank Name'**
  String get bankName;

  /// No description provided for @selectBank.
  ///
  /// In en, this message translates to:
  /// **'Select bank'**
  String get selectBank;

  /// No description provided for @bankNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Select a bank'**
  String get bankNameRequired;

  /// No description provided for @accountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get accountNumber;

  /// No description provided for @accountNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Account number is required'**
  String get accountNumberRequired;

  /// No description provided for @accountNumberLength.
  ///
  /// In en, this message translates to:
  /// **'Account number must be 10 digits'**
  String get accountNumberLength;

  /// No description provided for @accountName.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get accountName;

  /// No description provided for @accountNameHint.
  ///
  /// In en, this message translates to:
  /// **'Matches your bank account name'**
  String get accountNameHint;

  /// No description provided for @selectPlan.
  ///
  /// In en, this message translates to:
  /// **'Select a Plan'**
  String get selectPlan;

  /// No description provided for @selectPlanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can change plans later from subscription settings.'**
  String get selectPlanSubtitle;

  /// No description provided for @starterPlan.
  ///
  /// In en, this message translates to:
  /// **'Starter'**
  String get starterPlan;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @starterFeatures.
  ///
  /// In en, this message translates to:
  /// **'5 Events/mo, Basic Invoices'**
  String get starterFeatures;

  /// No description provided for @proBusinessPlan.
  ///
  /// In en, this message translates to:
  /// **'Pro Business'**
  String get proBusinessPlan;

  /// No description provided for @proPrice.
  ///
  /// In en, this message translates to:
  /// **'₦6,000'**
  String get proPrice;

  /// No description provided for @monthSuffix.
  ///
  /// In en, this message translates to:
  /// **'/month'**
  String get monthSuffix;

  /// No description provided for @proFeatures.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Events, Unlimited Invoices, Priority Support'**
  String get proFeatures;

  /// No description provided for @recommended.
  ///
  /// In en, this message translates to:
  /// **'RECOMMENDED'**
  String get recommended;

  /// No description provided for @proceedToPayment.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Payment'**
  String get proceedToPayment;

  /// No description provided for @completeSetup.
  ///
  /// In en, this message translates to:
  /// **'Complete Setup'**
  String get completeSetup;

  /// No description provided for @notSignedInError.
  ///
  /// In en, this message translates to:
  /// **'You are not signed in. Please sign in and try again.'**
  String get notSignedInError;

  /// No description provided for @checkingBusinessProfile.
  ///
  /// In en, this message translates to:
  /// **'Checking your business profile...'**
  String get checkingBusinessProfile;

  /// No description provided for @couldNotVerifyBusinessProfile.
  ///
  /// In en, this message translates to:
  /// **'We could not verify your business profile.'**
  String get couldNotVerifyBusinessProfile;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @nav_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get nav_home;

  /// No description provided for @nav_events.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get nav_events;

  /// No description provided for @nav_clients.
  ///
  /// In en, this message translates to:
  /// **'Clients'**
  String get nav_clients;

  /// No description provided for @nav_invoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get nav_invoices;

  /// No description provided for @nav_inventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get nav_inventory;

  /// No description provided for @nav_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get nav_settings;

  /// No description provided for @inventory_title.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventory_title;

  /// No description provided for @inventory_manageEquipment.
  ///
  /// In en, this message translates to:
  /// **'Manage Your Equipment'**
  String get inventory_manageEquipment;

  /// No description provided for @inventory_trackStock.
  ///
  /// In en, this message translates to:
  /// **'Track your stock and avoid shortages.'**
  String get inventory_trackStock;

  /// No description provided for @inventory_addItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get inventory_addItem;

  /// No description provided for @inventory_searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search inventory...'**
  String get inventory_searchHint;

  /// No description provided for @inventory_noInventory.
  ///
  /// In en, this message translates to:
  /// **'No inventory yet'**
  String get inventory_noInventory;

  /// No description provided for @inventory_emptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add your equipment (Speakers, Chairs, Lights, etc)\nso you can track them in your events.'**
  String get inventory_emptySubtitle;

  /// No description provided for @inventory_addFirstItem.
  ///
  /// In en, this message translates to:
  /// **'Add First Item'**
  String get inventory_addFirstItem;

  /// No description provided for @inventory_noResults.
  ///
  /// In en, this message translates to:
  /// **'No items match your filters'**
  String get inventory_noResults;

  /// No description provided for @inventory_clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get inventory_clearFilters;

  /// No description provided for @inventory_itemTable_name.
  ///
  /// In en, this message translates to:
  /// **'ITEM NAME'**
  String get inventory_itemTable_name;

  /// No description provided for @inventory_itemTable_category.
  ///
  /// In en, this message translates to:
  /// **'CATEGORY'**
  String get inventory_itemTable_category;

  /// No description provided for @inventory_itemTable_quantity.
  ///
  /// In en, this message translates to:
  /// **'QUANTITY OWNED'**
  String get inventory_itemTable_quantity;

  /// No description provided for @inventory_itemTable_actions.
  ///
  /// In en, this message translates to:
  /// **'ACTIONS'**
  String get inventory_itemTable_actions;

  /// No description provided for @inventory_pagination_page.
  ///
  /// In en, this message translates to:
  /// **'Page {current} of {total}'**
  String inventory_pagination_page(int current, int total);

  /// No description provided for @inventory_pagination_previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get inventory_pagination_previous;

  /// No description provided for @inventory_pagination_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get inventory_pagination_next;

  /// No description provided for @inventory_addTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Inventory'**
  String get inventory_addTitle;

  /// No description provided for @inventory_editTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Item'**
  String get inventory_editTitle;

  /// No description provided for @inventory_detailTitle.
  ///
  /// In en, this message translates to:
  /// **'Item Details'**
  String get inventory_detailTitle;

  /// No description provided for @inventory_image_uploadPrompt.
  ///
  /// In en, this message translates to:
  /// **'Tap to upload image'**
  String get inventory_image_uploadPrompt;

  /// No description provided for @inventory_image_formatHint.
  ///
  /// In en, this message translates to:
  /// **'PNG, JPG (MAX. 2MB)'**
  String get inventory_image_formatHint;

  /// No description provided for @inventory_image_change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get inventory_image_change;

  /// No description provided for @inventory_image_noImage.
  ///
  /// In en, this message translates to:
  /// **'No image provided'**
  String get inventory_image_noImage;

  /// No description provided for @inventory_label_itemName.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get inventory_label_itemName;

  /// No description provided for @inventory_hint_itemName.
  ///
  /// In en, this message translates to:
  /// **'e.g. JBL PartyBox 1000'**
  String get inventory_hint_itemName;

  /// No description provided for @inventory_label_quantityOwned.
  ///
  /// In en, this message translates to:
  /// **'Quantity Owned'**
  String get inventory_label_quantityOwned;

  /// No description provided for @inventory_hint_quantityOwned.
  ///
  /// In en, this message translates to:
  /// **'e.g. 10'**
  String get inventory_hint_quantityOwned;

  /// No description provided for @inventory_label_category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get inventory_label_category;

  /// No description provided for @inventory_label_selectExisting.
  ///
  /// In en, this message translates to:
  /// **'Select existing'**
  String get inventory_label_selectExisting;

  /// No description provided for @inventory_hint_newCategory.
  ///
  /// In en, this message translates to:
  /// **'Type new category name...'**
  String get inventory_hint_newCategory;

  /// No description provided for @inventory_label_createNewCategory.
  ///
  /// In en, this message translates to:
  /// **'Create New Category'**
  String get inventory_label_createNewCategory;

  /// No description provided for @inventory_label_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get inventory_label_notes;

  /// No description provided for @inventory_hint_notes.
  ///
  /// In en, this message translates to:
  /// **'Condition, serial numbers, or other details...'**
  String get inventory_hint_notes;

  /// No description provided for @inventory_button_saveItem.
  ///
  /// In en, this message translates to:
  /// **'Save Item'**
  String get inventory_button_saveItem;

  /// No description provided for @inventory_button_saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get inventory_button_saveChanges;

  /// No description provided for @inventory_message_itemUpdated.
  ///
  /// In en, this message translates to:
  /// **'Item updated'**
  String get inventory_message_itemUpdated;

  /// No description provided for @inventory_label_description.
  ///
  /// In en, this message translates to:
  /// **'DESCRIPTION / NOTES'**
  String get inventory_label_description;

  /// No description provided for @inventory_label_noNotes.
  ///
  /// In en, this message translates to:
  /// **'No notes available for this item.'**
  String get inventory_label_noNotes;

  /// No description provided for @inventory_label_itemId.
  ///
  /// In en, this message translates to:
  /// **'Item ID'**
  String get inventory_label_itemId;

  /// No description provided for @inventory_label_inStock.
  ///
  /// In en, this message translates to:
  /// **'IN STOCK'**
  String get inventory_label_inStock;

  /// No description provided for @inventory_category_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get inventory_category_all;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
