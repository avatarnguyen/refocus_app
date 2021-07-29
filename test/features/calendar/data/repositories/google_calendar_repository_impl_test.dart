import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/network/network_info.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_local_data_source.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_remote_data_source.dart';
import 'package:refocus_app/features/calendar/data/models/google_calendar_entry_model.dart';
import 'package:refocus_app/features/calendar/data/repositories/google_calendar_repository_impl.dart';
import 'package:refocus_app/features/calendar/domain/entities/gcal_event_entry.dart';
import 'package:googleapis/calendar/v3.dart' as google_api;

import '../../../../fixtures/fixture_reader.dart';

class MockRemoteDataSource extends Mock implements GCalRemoteDataSource {}

class MockLocalDataSource extends Mock implements GCalLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late GoogleCalendarRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = GoogleCalendarRepositoryImpl(
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

  group('getGoogleCalendarEntry', () {
    final event = google_api.Event.fromJson(
        json.decode(fixture('google_calendar_entry.json')));
    final tGoogleCalendarEntryModel = GCalEventEntryModel(appointment: event);

    final GCalEventEntry tGoogleCalendarEntry = tGoogleCalendarEntryModel;
    test(
      'should check if the device is online',
      () {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getAllRemoteCalendarEntries())
            .thenAnswer((_) async => tGoogleCalendarEntryModel);
        // act
        repository.getGoogleEventsData();
        // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getAllRemoteCalendarEntries())
              .thenAnswer((_) async => tGoogleCalendarEntryModel);
          // act
          final result = await repository.getGoogleEventsData();
          // assert
          verify(() => mockRemoteDataSource.getAllRemoteCalendarEntries());
          expect(result, equals(Right(tGoogleCalendarEntry)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getAllRemoteCalendarEntries())
              .thenAnswer((_) async => tGoogleCalendarEntryModel);
          // act
          await repository.getGoogleEventsData();
          // assert
          verify(() => mockRemoteDataSource.getAllRemoteCalendarEntries());
          verify(() => mockLocalDataSource
              .cacheGoogleCalendarEntry(tGoogleCalendarEntryModel));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getAllRemoteCalendarEntries())
              .thenThrow(ServerException());
          // act
          final result = await repository.getGoogleEventsData();
          // assert
          verify(() => mockRemoteDataSource.getAllRemoteCalendarEntries());
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
          when(() => mockLocalDataSource.getLastCalendarEntry())
              .thenAnswer((_) async => tGoogleCalendarEntryModel);
          // act
          final result = await repository.getGoogleEventsData();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(() => mockLocalDataSource.getLastCalendarEntry());
          expect(result, equals(Right(tGoogleCalendarEntry)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(() => mockLocalDataSource.getLastCalendarEntry())
              .thenThrow(CacheException());
          // act
          final result = await repository.getGoogleEventsData();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(() => mockLocalDataSource.getLastCalendarEntry());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
