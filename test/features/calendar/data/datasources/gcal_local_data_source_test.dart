import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_local_data_source.dart';
import 'package:refocus_app/features/calendar/data/models/google_calendar_entry_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:googleapis/calendar/v3.dart' as google_api;

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPrefGCalLocalDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = SharedPrefGCalLocalDataSource(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastGCalEntry', () {
    final tGCalEntryModel = GCalEventEntryModel.fromJson(
        json.decode(fixture('google_calendar_entry_cached.json')));
    test(
      'should return calendar entry form SharedPreferences when there is one in cache',
      () async {
        // arrange
        when(() => mockSharedPreferences.getString(any()))
            .thenReturn(fixture('google_calendar_entry_cached.json'));
        // act
        final result = await dataSource.getLastCalendarEntry();
        // assert{}
        verify(() => mockSharedPreferences.getString(cachedGCalEntry));
        expect(result, equals(tGCalEntryModel));
      },
    );

    test(
      'should throw a CacheExeption when there is no cached value',
      () async {
        // arrange
        when(() => mockSharedPreferences.getString(any())).thenReturn(null);
        // act
        final call = dataSource.getLastCalendarEntry;
        // assert
        expect(call, throwsA(isA<CacheException>()));
      },
    );
  });

  group('cacheGCalEntry', () {
    final event = google_api.Event.fromJson(
        json.decode(fixture('google_calendar_entry.json')));
    final tGoogleCalendarEntryModel = GCalEventEntryModel(appointment: event);

    test(
      'should call SharedPreferences to cache the data',
      () {
        // arrange
        when(() => mockSharedPreferences.setString(any(), any()))
            .thenAnswer((_) async => true);
        // act
        dataSource.cacheGoogleCalendarEntry(tGoogleCalendarEntryModel);
        // assert
        final expectedJsonString = json.encode(tGoogleCalendarEntryModel);
        verify(() => mockSharedPreferences.setString(
            cachedGCalEntry, expectedJsonString));
      },
    );
  });
}
