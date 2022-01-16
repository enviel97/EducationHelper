import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  // string to data
  String toStringFormat({String format = 'dd/Mm/yyyy'}) {
    final DateFormat formatter = DateFormat(format);
    return formatter.format(this);
  }

  static DateTime cast(String date, {String format = 'dd/MM/yyyy'}) {
    try {
      return DateFormat(format).parse(date);
    } catch (e) {
      return DateTime.parse(date);
    }
  }

  static bool compare(DateTime date, DateTime otherDate) {
    return date.day == otherDate.day &&
        date.month == otherDate.month &&
        date.year == otherDate.year;
  }

  static String get ctime => DateTime.now().microsecondsSinceEpoch.toString();

  bool isEqual(DateTime otherDate) => DateTimeX.compare(this, otherDate);
}
