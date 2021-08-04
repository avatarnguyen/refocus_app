import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/calendar_datasource.dart';

abstract class CalendarRepository {
  //* Get Google Events of current month and + 2 months ahead
  // Use for when the App start
  Future<Either<Failure, CalendarData>> getGoogleEventsData();
  // Update the month when user scroll to certain month
  Future<Either<Failure, CalendarData>> getGoogleEventsDataOfMonth(
      String year, String month);
  // Update the day when user scroll to certain day
  Future<Either<Failure, CalendarData>> getGoogleEventsDataOfDay(
      String year, String month, String day);
}
