import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number) {
    final formatterNumner = NumberFormat.currency(
      decimalDigits:0,
      symbol: '',
      locale: 'en',
    ).format(number);
    return formatterNumner;
  }
}
