/// Utilities for normalising Nigerian phone numbers.
class PhoneUtils {
  PhoneUtils._();

  /// Country code for Nigeria (without the '+').
  static const String ngCode = '234';

  /// Full international prefix.
  static const String ngPrefix = '+234';

  /// Takes the raw local input (e.g. "08012345678" or "8012345678")
  /// and returns the full E.164 string "+2348012345678".
  ///
  /// Strips all non-digit characters first, then removes a leading '0'
  /// if present, and prepends +234.
  static String normalise(String raw) {
    String digits = raw.replaceAll(RegExp(r'\D'), '');

    // Drop leading zero (common Nigerian convention)
    if (digits.startsWith('0')) {
      digits = digits.substring(1);
    }

    return '+$ngCode$digits';
  }

  /// Validates that the local part (after stripping leading 0) is 10 digits,
  /// which is the standard length for Nigerian mobile numbers.
  static bool isValidLocal(String raw) {
    String digits = raw.replaceAll(RegExp(r'\D'), '');
    if (digits.startsWith('0')) {
      digits = digits.substring(1);
    }
    return digits.length == 10;
  }
}
