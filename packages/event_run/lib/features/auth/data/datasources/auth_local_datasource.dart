import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:event_run/features/auth/data/models/vendor_model.dart';

/// Local data source for authentication using SharedPreferences
class AuthLocalDataSource {
  AuthLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  static const String _keyUser = 'eventrun_user';
  static const String _keyOnboarding = 'eventrun_onboarding_complete';

  /// Check if user is authenticated
  bool isAuthenticated() {
    return _prefs.containsKey(_keyUser);
  }

  /// Check if onboarding is complete
  bool hasCompletedOnboarding() {
    return _prefs.getBool(_keyOnboarding) ?? false;
  }

  /// Mark onboarding as complete
  Future<void> completeOnboarding() async {
    await _prefs.setBool(_keyOnboarding, true);
  }

  /// Get current user
  VendorModel? getCurrentUser() {
    final userJson = _prefs.getString(_keyUser);
    if (userJson == null) return null;

    final Map<String, dynamic> json = jsonDecode(userJson);
    return VendorModel.fromJson(json);
  }

  /// Save user
  Future<void> saveUser(VendorModel user) async {
    final userJson = jsonEncode(user.toJson());
    await _prefs.setString(_keyUser, userJson);
  }

  /// Remove user (logout)
  Future<void> removeUser() async {
    await _prefs.remove(_keyUser);
  }
}
