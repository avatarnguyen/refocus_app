import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/network/network_info.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_local_data_source.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_remote_data_source.dart';
import 'package:refocus_app/features/calendar/data/models/gcal_entry_model.dart';
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
    final log = logger(CalendarRepositoryImpl);

    if (await networkInfo.isConnected) {
      try {
        final timeMin = DateUtils.firstDayOfCurrentMonth();
        final timeMax = DateUtils.lastDayOfFutureMonthIn(2);

        var _calendarList = await _filterSelectedCalendars();

        final remoteGCalEntries =
            await remoteCalDataSource.getRemoteGoogleEventsData(
          calendarList: _calendarList,
          timeMin: timeMin,
          timeMax: timeMax,
        );

        await localCalDataSource.cacheGoogleCalendarEntry(remoteGCalEntries);

        final calendarData = CalendarData(events: remoteGCalEntries);
        log.i('Appointments: ${calendarData.appointments?.length}');
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

  //* Fetch Calendar List from Local Database
  // Filter selected calendars
  Future<List<GCalEntryModel>> _filterSelectedCalendars() async {
    final log = logger(CalendarRepositoryImpl);

    final _calendarList = <GCalEntryModel>[];
    final _storedCalendars =
        await localCalDataSource.getLastCachedGoogleCalendar();
    log.i('Stored Calendar List: ${_storedCalendars.length}');
    for (var _calendar in _storedCalendars) {
      if (_calendar.selected != null && _calendar.selected == true) {
        log.v('Calendar --> ${_calendar.toJson()}');
        _calendarList.add(_calendar);
      }
    }
    return _calendarList;
  }

  // DateTime.parse('2021-08-01T01:00:00+02:00')

  @override
  Future<Either<Failure, List<CalendarEventEntry>>> getEventsDataBetween(
      DateTime startDate, DateTime endDate) async {
    final log = logger(CalendarRepositoryImpl);

    final timeMin = DateUtils.toGoogleRFCDateTime(startDate);
    final timeMax = DateUtils.toGoogleRFCDateTime(endDate);

    log.v('TimeMin: $timeMin - TimeMax: $timeMax');

    try {
      var _calendarList = await _filterSelectedCalendars();

      final remoteGCalEntries =
          await remoteCalDataSource.getRemoteGoogleEventsData(
        calendarList: _calendarList,
        timeMin: timeMin,
        timeMax: timeMax,
      );

      log.i('[getEventsDataBetween] Appointments: ${remoteGCalEntries.length}');
      return Right(remoteGCalEntries);
    } on ServerException {
      log.e('ServerException');
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

  // TODO: Change this to JSON Serialiable approach instead of manual
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

// {id: e_2_de#weeknum@group.v.calendar.google.com, summary: Kalenderwochen, color: #9fc6e7, selected: true, timeZone: Europe/Berlin}
        await localCalDataSource.cacheRemoteGoogleCalendar(remoteCalendars);

        // Get Calendar from Local Storage
        final localCalendars =
            await localCalDataSource.getLastCachedGoogleCalendar();

        for (var calendar in localCalendars) {
          // final calendarEntry = CalendarEntry.fromJson(calendar.toJson());
          calendars.add(calendar);
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
          // final calendarEntry = CalendarEntry.fromJson(calendar.toJson());
          calendars.add(calendar);
        }

        return Right(calendars);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, CalendarEntry>> updateCalendarList(
      CalendarEntry calendar) async {
    try {
      final gCalEntry = GCalEntryModel.fromJson(calendar.toGCalJson());

      final result =
          await localCalDataSource.updateCachedCalendarEntry(gCalEntry);

      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
