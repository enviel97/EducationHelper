import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  // string to data
  String toStringFormat({String format = 'dd/Mm/yyyy'}) {
    final DateFormat formatter = DateFormat(format);
    return formatter.format(this);
  }

  static bool compare(DateTime date, DateTime otherDate) {
    return date.day == otherDate.day &&
        date.month == otherDate.month &&
        date.year == otherDate.year;
  }

  bool isEqual(DateTime otherDate) => DateTimeX.compare(this, otherDate);
}
