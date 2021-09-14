import 'package:intl/intl.dart';

class CustomDateUtils {
  // TODO: Change TimeZone
  static String getTimeZone() {
    final today = DateTime.now();
    return today.timeZoneOffset.toString();
  }

  static String returnMonth(DateTime date) {
    return DateFormat.MMMM().format(date);
  }

  static String returnTime(DateTime date) {
    return DateFormat.Hm().format(date);
  }

  static String returnDateAndMonth(DateTime date) {
    return DateFormat.MMMd().format(date);
  }

  static String returnDateWithDay(DateTime date) {
    return DateFormat.yMEd().format(date);
  }

  /// The last day of a given month
  static DateTime lastDayOfMonth(DateTime month) {
    final beginningNextMonth = (month.month < 12)
        ? DateTime(month.year, month.month + 1)
        : DateTime(month.year + 1);
    return beginningNextMonth.subtract(const Duration(days: 1));
  }

  /// get the first day of current month in RFC DateTime Format
  static DateTime firstDayOfCurrentMonth() {
    final today = DateTime.now();
    return firstDateOfSpecificMonth(today.year, today.month);
  }

  /// get the last day in [int value] month from now in RFC DateTime Format
  static DateTime lastDayOfFutureMonthIn(int monthsAhead) {
    final today = DateTime.now();
    final currentMonth = today.month;

    final month = currentMonth <= (12 - monthsAhead)
        ? today.month + monthsAhead
        : (currentMonth + monthsAhead - 12);
    final year =
        currentMonth <= (12 - monthsAhead) ? today.year : today.year + 1;
    return lastDateOfSpecificMonth(year, month);
  }

  static DateTime firstDateOfSpecificMonth(int year, int month) {
    final monthStr = month.toString().padLeft(2, '0');
    return DateTime.parse('${year.toString()}-$monthStr-01T00:00:00+02:00');
  }

  static DateTime lastDateOfSpecificMonth(int year, int month) {
    final monthStr = month.toString().padLeft(2, '0');
    final lastDay = lastDayOfMonth(DateTime(year, month)).day;
    return DateTime.parse(
        '${year.toString()}-$monthStr-${lastDay.toString()}T23:59:59+02:00');
  }

  // static DateTime beginningOfDay(int year, int month, int day) {
  //   final monthStr = month.toString().padLeft(2, '0');
  //   final dayStr = day.toString().padLeft(2, '0');
  //   return DateTime.parse(
  //       '${year.toString()}-$monthStr-${dayStr}T00:00:00+02:00');
  // }

  // static DateTime endOfDay(int year, int month, int day) {
  //   final monthStr = month.toString().padLeft(2, '0');
  //   final dayStr = day.toString().padLeft(2, '0');
  //   return DateTime.parse(
  //       '${year.toString()}-$monthStr-${dayStr}T23:59:59+02:00');
  // }

  static DateTime toGoogleRFCDateTime(DateTime dateTime) {
    final yearStr = dateTime.year.toString();
    final monthStr = dateTime.month.toString().padLeft(2, '0');
    final dayStr = dateTime.day.toString().padLeft(2, '0');
    final hourStr = dateTime.hour.toString().padLeft(2, '0');
    final minuteStr = dateTime.minute.toString().padLeft(2, '0');
    final secondStr = dateTime.second.toString().padLeft(2, '0');
    final timeZoneStr =
        '${dateTime.timeZoneOffset.isNegative ? '-' : '+'}${dateTime.timeZoneOffset.inHours.toString().padLeft(2, '0')}:00';
    final result =
        '$yearStr-$monthStr-${dayStr}T$hourStr:$minuteStr:$secondStr$timeZoneStr';

    // print('Resulted String: $result');
    return DateTime.parse(result); //+02:00
  }
}
