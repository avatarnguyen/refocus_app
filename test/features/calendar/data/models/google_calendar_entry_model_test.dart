import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:refocus_app/features/calendar/data/models/google_calendar_entry_model.dart';
import 'package:refocus_app/features/calendar/domain/entities/gcal_event_entry.dart';
import 'package:googleapis/calendar/v3.dart' as google_api;

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final event = google_api.Event.fromJson(
      json.decode(fixture('google_calendar_entry.json')));
  final tGoogleCalendarEntryModel = GCalEventEntryModel(appointment: event);

  test(
    'should be a subclass of GoogleCalendarEntry',
    () async {
      // arrange
      expect(tGoogleCalendarEntryModel, isA<GCalEventEntry>());
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
        final result = GCalEventEntryModel.fromJson(jsonMap);
        // assert
        expect(result, tGoogleCalendarEntryModel);
      },
    );
  });
}
