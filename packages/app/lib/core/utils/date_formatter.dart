import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String formatDate(DateTime date) => DateFormat('d MMM yyyy').format(date);

  static String formatDateWithDay(DateTime date) =>
      DateFormat('EEE, d MMM').format(date);

  static String formatDateShort(DateTime date) => DateFormat('d MMM').format(date);

  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) return 'Just now';
    if (difference.inMinutes < 60) {
      final m = difference.inMinutes;
      return '$m ${m == 1 ? 'min' : 'mins'} ago';
    }
    if (difference.inHours < 24) {
      final h = difference.inHours;
      return '$h ${h == 1 ? 'hour' : 'hours'} ago';
    }
    if (difference.inDays < 7) {
      final d = difference.inDays;
      return '$d ${d == 1 ? 'day' : 'days'} ago';
    }
    return formatDate(dateTime);
  }
}
