import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static final _formatter = NumberFormat.currency(
    locale: 'en_NG',
    symbol: '\u20A6',
    decimalDigits: 0,
  );

  static String formatNaira(num amount) => _formatter.format(amount);
}
