import 'package:intl/intl.dart';

/// Utility class for formatting values
class Formatters {
  Formatters._();

  /// Format currency in Nigerian Naira
  static String formatNaira(num amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_NG',
      symbol: '₦',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  /// Format date in a readable format
  static String formatDate(DateTime date) {
    return DateFormat('d MMM yyyy').format(date);
  }

  /// Format date with day name
  static String formatDateWithDay(DateTime date) {
    return DateFormat('EEE, d MMM').format(date);
  }

  /// Format date for display in lists
  static String formatDateShort(DateTime date) {
    return DateFormat('d MMM').format(date);
  }

  /// Format phone number
  static String formatPhoneNumber(String phone) {
    // Simple formatting - can be enhanced based on requirements
    return phone;
  }

  /// Get relative time string (e.g., "2 mins ago", "1 hour ago")
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      final mins = difference.inMinutes;
      return '$mins ${mins == 1 ? 'min' : 'mins'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else {
      return formatDate(dateTime);
    }
  }
}
