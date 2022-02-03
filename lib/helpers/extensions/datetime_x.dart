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

  static DateTime get empty => DateTime(-1);

  static String get ctime => DateTime.now().microsecondsSinceEpoch.toString();

  bool isEqual(DateTime? otherDate) =>
      otherDate == null ? false : DateTimeX.compare(this, otherDate);

  DateTime get startDay => DateTime(year, month, day, 0, 0, 0);

  DateTime get endDay => DateTime(year, month, day, 23, 59, 59);

  bool get isEmpty => isEqual(DateTimeX.empty);
}
