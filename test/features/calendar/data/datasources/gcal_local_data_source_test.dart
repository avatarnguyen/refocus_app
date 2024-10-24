import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_local_data_source.dart';
import 'package:refocus_app/features/calendar/data/models/gcal_event_entry_model.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHiveEventBox extends Mock implements Box<CalendarEventEntry> {}

class MockHiveCalendarBox extends Mock implements Box<CalendarEntry> {}

void main() async {
  late HiveGCalLocalDataSource dataSource;
  late MockHiveEventBox mockHiveEventBox;
  late MockHiveCalendarBox mockHiveCalendarBox;

  setUp(() async {
    // await setUpTestHive();

    mockHiveEventBox = MockHiveEventBox();
    mockHiveCalendarBox = MockHiveCalendarBox();

    dataSource = HiveGCalLocalDataSource(
      gcalEventsBox: mockHiveEventBox,
      calendarBox: mockHiveCalendarBox,
    );
  });

  // tearDown(() async {
  //   await tearDownTestHive();
  // });

  group('getLastGCalEntry', () {
    final tGCalEntryModel = GCalEventEntryModel.fromJson(
        json.decode(fixture('google_calendar_entry_cached.json'))
            as Map<String, dynamic>);
    final tCalendarEventEntry = tGCalEntryModel;
    test(
      'should return calendar entry from Hive Box when there is one in cache',
      () async {
        // arrange
        when(() => mockHiveEventBox.length).thenReturn(1);
        when(() => mockHiveEventBox.getAt(any()))
            .thenReturn(tCalendarEventEntry);

        // act
        final result = await dataSource.getLastCalendarEventEntry();
        // assert{}
        verify(() => mockHiveEventBox.getAt(any()));
        expect(result, equals([tGCalEntryModel]));
      },
    );

    test(
      'should return empty list when there is no cached value',
      () async {
        // arrange
        when(() => mockHiveEventBox.length).thenReturn(0);
        // when(() => mockHiveEventBox.getAt(any())).thenReturn(null);
        // act
        // final call = dataSource.getLastCalendarEventEntry;
        final result = await dataSource.getLastCalendarEventEntry();

        // assert
        expect(result, equals(<GCalEventEntryModel>[]));
      },
    );
  });

  group('cacheGCalEntry', () {
    final tGoogleCalendarEntryModel = GCalEventEntryModel(
      subject: 'Event Refocus App',
      id: '4okqcu9vna2ak7jt7545ndlp9n',
      startDateTime: DateTime.parse('2021-07-19T16:45:00+02:00'),
      endDateTime: DateTime.parse('2021-07-19T18:30:00+02:00'),
      organizer: 'Test Dev',
    );

    var calendarEntry = <String, GCalEventEntryModel>{
      tGoogleCalendarEntryModel.id!: tGoogleCalendarEntryModel
    };

    test(
      'should call Hive to cache the data',
      () async {
        // arrange
        when(() => mockHiveEventBox.isOpen).thenReturn(true);
        when(() => mockHiveEventBox.putAll(any()))
            .thenAnswer((_) async => calendarEntry);
        // act
        await dataSource.cacheGoogleCalendarEntry([tGoogleCalendarEntryModel]);
        // assert

        verify(() => mockHiveEventBox.putAll(calendarEntry));
      },
    );
  });
}
