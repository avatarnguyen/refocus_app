import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:refocus_app/features/calendar/data/models/google_calendar_entry_model.dart';
import 'package:refocus_app/features/calendar/domain/entities/google_calendar_entry.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tGoogleCalendarEntryModel =
      GoogleCalendarEntryModel(summary: 'Event Refocus App');

  test(
    'should be a subclass of GoogleCalendarEntry',
    () async {
      // arrange
      expect(tGoogleCalendarEntryModel, isA<GoogleCalendarEntry>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON google calendar entry',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('google_calendar_entry.json'));
        // act
        final result = GoogleCalendarEntryModel.fromJson(jsonMap);
        // assert
        expect(result, tGoogleCalendarEntryModel);
      },
    );
  });
}
