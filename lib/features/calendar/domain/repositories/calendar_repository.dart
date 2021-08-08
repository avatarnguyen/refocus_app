import 'package:dartz/dartz.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';

import '../../../../core/error/failures.dart';
import '../entities/calendar_datasource.dart';

abstract class CalendarRepository {
  // Use for when the App start
  ///* Get Calendar Events of current month and + 2 months ahead
  ///
  /// And cache locally. If no internet connection, data will be retrive from local cache
  Future<Either<Failure, CalendarData>> getEventsData();
  // Update the month when user scroll to certain month
  Future<Either<Failure, List<CalendarEventEntry>>> getEventsDataBetween(
      DateTime startDate, DateTime endDate);
  // Update the day when user scroll to certain day
  Future<Either<Failure, List<CalendarEventEntry>>> getEventsDataOfDay(
      int year, int month, int day);

  /// Get List of available Calendars
  Future<Either<Failure, List<CalendarEntry>>> getCalendarList();

  /// Insert New Event to Calendar
  ///
  /// Take [CalendarEventEntry] as argument
  Future<Either<Failure, Unit>> addEventsData(CalendarEventEntry event,
      {String? calendarId});

  /// Update Calendar Event
  ///
  /// Take [CalendarEventEntry] as argument
  Future<Either<Failure, Unit>> updateEventsData(CalendarEventEntry event,
      {String? calendarId});

  /// Delete Calendar Event
  ///
  /// Take [CalendarEventEntry] as argument
  Future<Either<Failure, Unit>> deleteEventsData(CalendarEventEntry event,
      {required String calendarId});
}
