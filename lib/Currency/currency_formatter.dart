import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String format(double number, String currency) {
    number = double.parse(number.toStringAsFixed(2));
    NumberFormat formatter = NumberFormat.simpleCurrency(name: currency);
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = 2;
    formatter.turnOffGrouping();
    return formatter.format(number);
  }
}