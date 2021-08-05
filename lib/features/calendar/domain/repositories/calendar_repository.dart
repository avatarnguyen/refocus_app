import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/calendar_datasource.dart';

abstract class CalendarRepository {
  // Use for when the App start
  ///* Get Google Events of current month and + 2 months ahead
  ///
  /// And cache locally. If no internet connection, data will be retrive from local cache
  Future<Either<Failure, CalendarData>> getEventsData();
  // Update the month when user scroll to certain month
  Future<Either<Failure, CalendarData>> getEventsDataOfMonth(
      int year, int month);
  // Update the day when user scroll to certain day
  Future<Either<Failure, CalendarData>> getEventsDataOfDay(
      int year, int month, int day);
}