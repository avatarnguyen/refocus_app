import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/network/network_info.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_local_data_source.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_remote_data_source.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_datasource.dart';
import 'package:refocus_app/features/calendar/domain/repositories/calendar_repository.dart';

@LazySingleton(as: CalendarRepository)
class CalendarRepositoryImpl implements CalendarRepository {
  CalendarRepositoryImpl(
      {required this.remoteCalDataSource,
      required this.localCalDataSource,
      required this.networkInfo});

  final GCalRemoteDataSource remoteCalDataSource;
  final GCalLocalDataSource localCalDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, CalendarData>> getEventsData() async {
    if (await networkInfo.isConnected) {
      try {
        final timeMin = DateUtils.firstDayOfCurrentMonth();
        final timeMax = DateUtils.lastDayOfFutureMonthIn(2);

        final remoteGCalEntries = await remoteCalDataSource
            .getRemoteGoogleEventsData(timeMin: timeMin, timeMax: timeMax);

        await localCalDataSource.cacheGoogleCalendarEntry(remoteGCalEntries);

        final calendarData = CalendarData(events: remoteGCalEntries);
        print(
            '[Repository Impl] Appointments: ${calendarData.appointments?.length}');
        return Right(calendarData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localGCalEntry = await localCalDataSource.getLastCalendarEntry();
        return Right(CalendarData(events: localGCalEntry));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  // DateTime.parse('2021-08-01T01:00:00+02:00')

  @override
  Future<Either<Failure, CalendarData>> getEventsDataOfDay(
      int year, int month, int day) async {
    try {
      final timeMin = DateUtils.beginningOfDay(year, month, day);
      final timeMax = DateUtils.endOfDay(year, month, day);

      final remoteGCalEntries = await remoteCalDataSource
          .getRemoteGoogleEventsData(timeMin: timeMin, timeMax: timeMax);

      final calendarData = CalendarData(events: remoteGCalEntries);
      print(
          '[Repository Impl] Appointments: ${calendarData.appointments?.length}');
      return Right(calendarData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CalendarData>> getEventsDataOfMonth(
      int year, int month) async {
    try {
      final timeMin = DateUtils.firstDateOfSpecificMonth(year, month);
      final timeMax = DateUtils.lastDateOfSpecificMonth(year, month);

      final remoteGCalEntries = await remoteCalDataSource
          .getRemoteGoogleEventsData(timeMin: timeMin, timeMax: timeMax);

      final calendarData = CalendarData(events: remoteGCalEntries);
      print(
          '[Repository Impl] Appointments: ${calendarData.appointments?.length}');
      return Right(calendarData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
