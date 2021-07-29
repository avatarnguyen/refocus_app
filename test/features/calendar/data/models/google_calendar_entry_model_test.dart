import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:refocus_app/features/calendar/data/models/google_calendar_entry_model.dart';
import 'package:refocus_app/features/calendar/domain/entities/gcal_event_entry.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tGoogleCalendarEntryModel = GCalEventEntryModel(
    subject: 'Event Refocus App',
    id: '4okqcu9vna2ak7jt7545ndlp9n',
    start: {'dateTime': '2021-07-19T16:45:00+02:00'},
    end: {'dateTime': '2021-07-19T18:30:00+02:00'},
  );

  test(
    'should be a subclass of GoogleCalendarEntry',
    () async {
      // arrange
      expect(tGoogleCalendarEntryModel, isA<GCalEventEntry>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model from JSON google calendar entry',
      () {
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
