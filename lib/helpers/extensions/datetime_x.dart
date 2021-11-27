import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String toStringFormat({String format = 'dd/Mm/yyyy'}) {
    final DateFormat formatter = DateFormat(format);
    return formatter.format(this);
  }

  // string to data
}
