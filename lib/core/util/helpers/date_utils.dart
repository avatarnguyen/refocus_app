class DateUtils {
  // TODO: Change TimeZone
  static String getTimeZone() {
    final today = DateTime.now();
    return today.timeZoneOffset.toString();
  }

  /// The last day of a given month
  static DateTime lastDayOfMonth(DateTime month) {
    var beginningNextMonth = (month.month < 12)
        ? DateTime(month.year, month.month + 1, 1)
        : DateTime(month.year + 1, 1, 1);
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
    final monthStr = month < 10 ? '0${month.toString()}' : month.toString();
    return DateTime.parse('${year.toString()}-$monthStr-01T00:00:00+02:00');
  }

  static DateTime lastDateOfSpecificMonth(int year, int month) {
    final monthStr = month < 10 ? '0${month.toString()}' : month.toString();
    final lastDay = lastDayOfMonth(DateTime(year, month)).day;
    return DateTime.parse(
        '${year.toString()}-$monthStr-${lastDay.toString()}T23:59:59+02:00');
  }

  static DateTime beginningOfDay(int year, int month, int day) {
    final monthStr = month < 10 ? '0${month.toString()}' : month.toString();
    final dayStr = day < 10 ? '0${day.toString()}' : day.toString();
    return DateTime.parse(
        '${year.toString()}-$monthStr-${dayStr}T00:00:00+02:00');
  }

  static DateTime endOfDay(int year, int month, int day) {
    final monthStr = month < 10 ? '0${month.toString()}' : month.toString();
    final dayStr = day < 10 ? '0${day.toString()}' : day.toString();
    return DateTime.parse(
        '${year.toString()}-$monthStr-${dayStr}T23:59:59+02:00');
  }
}
