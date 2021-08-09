import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/network/network_info.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_local_data_source.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_remote_data_source.dart';
import 'package:refocus_app/features/calendar/data/models/gcal_entry_model.dart';
import 'package:refocus_app/features/calendar/data/models/gcal_event_entry_model.dart';
import 'package:refocus_app/features/calendar/data/repositories/calendar_repository_impl.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_datasource.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:googleapis/calendar/v3.dart' as google_api;

class MockRemoteDataSource extends Mock implements GCalRemoteDataSource {}

class MockLocalDataSource extends Mock implements GCalLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late CalendarRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CalendarRepositoryImpl(
      localCalDataSource: mockLocalDataSource,
      remoteCalDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('addEventsData', () {
    final tGoogleCalendarEntryModel = GCalEventEntryModel(
      subject: 'Event Refocus App',
      id: '4okqcu9vna2ak7jt7545ndlp9n',
      startDateTime: DateTime.parse('2021-07-19T16:45:00+02:00'),
      endDateTime: DateTime.parse('2021-07-19T18:30:00+02:00'),
      organizer: 'Test Dev',
    );
    final tEvent = tGoogleCalendarEntryModel;

    test(
      'should add remote google event and return successful',
      () async {
        // arrange
        when(() => mockRemoteDataSource.addRemoteGoogleEvent(
                eventModel: tGoogleCalendarEntryModel))
            .thenAnswer((_) async => const Right(unit));
        // act
        final result = await repository.addEventsData(tEvent);
        // assert
        verify(() => mockRemoteDataSource.addRemoteGoogleEvent(
            eventModel: tGoogleCalendarEntryModel));

        expect(result, isA<Right<Failure, Unit>>());
      },
    );
  });

  group('getEventsData', () {
    final tGoogleCalendarEntryModel = GCalEventEntryModel(
      subject: 'Event Refocus App',
      id: '4okqcu9vna2ak7jt7545ndlp9n',
      startDateTime: DateTime.parse('2021-07-19T16:45:00+02:00'),
      endDateTime: DateTime.parse('2021-07-19T18:30:00+02:00'),
      organizer: 'Test Dev',
    );
    final timeMin = DateUtils.firstDayOfCurrentMonth();
    final timeMax = DateUtils.lastDayOfFutureMonthIn(2);

    final startDate = DateTime(2021, 7, 19);
    final endDate = DateTime(2021, 7, 19, 23, 59, 59);

    final CalendarEventEntry tGoogleCalendarEntry = tGoogleCalendarEntryModel;

    // Hive Database: using id as key
    var calendarEntry = <String, GCalEventEntryModel>{
      tGoogleCalendarEntryModel.id!: tGoogleCalendarEntryModel
    };
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getRemoteGoogleEventsData(
                  calendarList: any(named: 'calendarList'),
                  timeMin: timeMin,
                  timeMax: timeMax,
                ))
            .thenAnswer(
                (_) async => <GCalEventEntryModel>[tGoogleCalendarEntryModel]);
        when(() => mockLocalDataSource
                .cacheGoogleCalendarEntry([tGoogleCalendarEntryModel]))
            .thenAnswer((_) async => calendarEntry);
        when(() => mockLocalDataSource.getLastCachedGoogleCalendar())
            .thenAnswer((_) async => <GCalEntryModel>[]);
        // act
        await repository.getEventsData();
        // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getRemoteGoogleEventsData(
                calendarList: any(named: 'calendarList'),
                timeMin: timeMin,
                timeMax: timeMax,
              )).thenAnswer((_) async => [tGoogleCalendarEntryModel]);
          when(() => mockLocalDataSource
                  .cacheGoogleCalendarEntry([tGoogleCalendarEntryModel]))
              .thenAnswer((_) async => calendarEntry);
          when(() => mockLocalDataSource.getLastCachedGoogleCalendar())
              .thenAnswer((_) async => <GCalEntryModel>[]);
          // act
          final result = await repository.getEventsData();
          // assert
          verify(() => mockRemoteDataSource.getRemoteGoogleEventsData(
              timeMin: timeMin, timeMax: timeMax));

          expect(result, isA<Right<Failure, CalendarData>>());

          final resultSubject = result.fold((l) => l, (r) => r);
          expect((resultSubject as CalendarData).appointments,
              equals([tGoogleCalendarEntry]));
        },
      );

      test(
        'should return remote data of specific day when call to remote data source is successful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getRemoteGoogleEventsData(
                calendarList: any(named: 'calendarList'),
                timeMin: DateUtils.toGoogleRFCDateTime(startDate),
                timeMax: DateUtils.toGoogleRFCDateTime(endDate),
              )).thenAnswer((_) async => [tGoogleCalendarEntryModel]);
          // act
          final result =
              await repository.getEventsDataBetween(startDate, endDate);
          // assert
          verify(() => mockRemoteDataSource.getRemoteGoogleEventsData(
                timeMin: DateUtils.toGoogleRFCDateTime(startDate),
                timeMax: DateUtils.toGoogleRFCDateTime(endDate),
              ));

          expect(result, isA<Right<Failure, List<CalendarEventEntry>>>());

          final resultSubject = result.fold((l) => l, (r) => r);
          expect(resultSubject, equals([tGoogleCalendarEntry]));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getRemoteGoogleEventsData(
                calendarList: any(named: 'calendarList'),
                timeMin: timeMin,
                timeMax: timeMax,
              )).thenAnswer((_) async => [tGoogleCalendarEntryModel]);
          when(() => mockLocalDataSource
                  .cacheGoogleCalendarEntry([tGoogleCalendarEntryModel]))
              .thenAnswer((_) async => calendarEntry);
          // act
          await repository.getEventsData();
          // assert
          verify(() => mockRemoteDataSource.getRemoteGoogleEventsData(
              timeMin: timeMin, timeMax: timeMax));
          verify(() => mockLocalDataSource
              .cacheGoogleCalendarEntry([tGoogleCalendarEntryModel]));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getRemoteGoogleEventsData(
                calendarList: any(named: 'calendarList'),
                timeMin: timeMin,
                timeMax: timeMax,
              )).thenThrow(ServerException());
          // act
          final result = await repository.getEventsData();
          // assert
          verify(() => mockRemoteDataSource.getRemoteGoogleEventsData(
              timeMin: timeMin, timeMax: timeMax));
          verifyZeroInteractions(mockLocalDataSource);

          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(() => mockLocalDataSource.getLastCalendarEventEntry())
              .thenAnswer((_) async => [tGoogleCalendarEntryModel]);
          // act
          final result = await repository.getEventsData();
          // assert

          verifyZeroInteractions(mockRemoteDataSource);
          verify(() => mockLocalDataSource.getLastCalendarEventEntry());

          expect(result, isA<Right<Failure, CalendarData>>());

          final resultSubject = result.fold((l) => l, (r) => r);
          expect((resultSubject as CalendarData).appointments,
              equals([tGoogleCalendarEntry]));
          // expect(result,
          //     equals(Right(CalendarData(events: [tGoogleCalendarEntry]))));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(() => mockLocalDataSource.getLastCalendarEventEntry())
              .thenThrow(CacheException());
          // act
          final result = await repository.getEventsData();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(() => mockLocalDataSource.getLastCalendarEventEntry());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
