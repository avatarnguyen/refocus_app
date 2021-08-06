import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/network/network_info.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_local_data_source.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_remote_data_source.dart';
import 'package:refocus_app/features/calendar/data/models/gcal_event_entry_model.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_datasource.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
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
        final localGCalEntry =
            await localCalDataSource.getLastCalendarEventEntry();
        var calendarData = CalendarData(events: localGCalEntry);
        return Right(calendarData);
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

  @override
  Future<Either<Failure, Unit>> addEventsData(CalendarEventEntry event,
      {String? calendarId}) async {
    try {
      final model = _eventEntryConverter(event);

      await remoteCalDataSource.addRemoteGoogleEvent(
        calendarId: calendarId,
        eventModel: model,
      );

      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteEventsData(CalendarEventEntry event,
      {required String calendarId}) async {
    try {
      final model = _eventEntryConverter(event);

      await remoteCalDataSource.deleteRemoteGoogleEvent(
        eventModel: model,
        calendarId: calendarId,
      );

      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateEventsData(CalendarEventEntry event,
      {String? calendarId}) async {
    try {
      final model = _eventEntryConverter(event);

      await remoteCalDataSource.updateRemoteGoogleEvent(
        eventModel: model,
        calendarId: calendarId,
      );

      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  GCalEventEntryModel _eventEntryConverter(CalendarEventEntry event) {
    final model = GCalEventEntryModel(
      id: event.id,
      subject: event.subject,
      notes: event.notes,
      startDateTime: event.startDateTime,
      startDate: event.startDate,
      endDate: event.endDate,
      endDateTime: event.endDateTime,
      organizer: event.organizer,
    );
    return model;
  }

  @override
  Future<Either<Failure, List<CalendarEntry>>> getCalendarList() async {
    final calendars = <CalendarEntry>[];

    if (await networkInfo.isConnected) {
      try {
        // Fetch Remote Calendars and update calendars in local storage
        final remoteCalendars =
            await remoteCalDataSource.getRemoteGoogleCalendar();

        await localCalDataSource.cacheRemoteGoogleCalendar(remoteCalendars);

        final localCalendars =
            await localCalDataSource.getLastCachedGoogleCalendar();

        for (var calendar in localCalendars) {
          final calendarEntry = CalendarEntry.fromJson(calendar.toJson());
          calendars.add(calendarEntry);
        }

        return Right(calendars);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCalendar =
            await localCalDataSource.getLastCachedGoogleCalendar();

        for (var calendar in localCalendar) {
          final calendarEntry = CalendarEntry.fromJson(calendar.toJson());
          calendars.add(calendarEntry);
        }

        return Right(calendars);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
