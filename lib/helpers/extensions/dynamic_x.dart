// ignore_for_file: file_names
import 'package:intl/intl.dart';

extension DynamicX on dynamic {
  String toCurrencyFormat({
    String formating = '\$#,##0.00',
    String local = 'en-us',
  }) {
    final oCcy = NumberFormat(formating, local);
    final currency = double.tryParse('${this}') ?? 0.0;
    return oCcy.format(currency);
  }
}
