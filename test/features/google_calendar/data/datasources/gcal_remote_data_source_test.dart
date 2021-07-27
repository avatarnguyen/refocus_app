import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/features/google_calendar/data/datasources/gcal_remote_data_source.dart';
import 'package:refocus_app/features/google_calendar/data/models/google_calendar_entry_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late HttpGCalRemoteDataSoure dataSoure;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSoure = HttpGCalRemoteDataSoure(client: mockHttpClient);
  });

  group('getGCalEntry', () {
    final tGCalEntryModel = GoogleCalendarEntryModel.fromJson(
        json.decode(fixture('google_calendar_entry.json')));

    var url = Uri.parse(
        'https://www.googleapis.com/calendar/v3/calendars/in558pn22g34uj8j769poaddpk@group.calendar.google.com/events?key=AIzaSyC-JYOakQBzGvadMpr8ji3zE_AhvZ3bq7k');

    test(
      'should perform a GET request on a URL and with application/json header',
      () {
        // arrange
        // REFACTOR: better to change url to any, but not sure about the syntax
        when(() => mockHttpClient.get(url, headers: any(named: 'headers')))
            .thenAnswer((_) async => http.Response(
                  fixture('google_calendar_entry.json'),
                  200,
                ));
        // act
        dataSoure.getAllRemoteCalendarEntries();
        // assert
        verify(() => mockHttpClient
            .get(url, headers: {'Content-Type': 'application/json'}));
      },
    );

    test(
      'should return GCal Enty when the response code is 200 (success)',
      () async {
        // arrange
        when(() => mockHttpClient.get(url, headers: any(named: 'headers')))
            .thenAnswer((_) async =>
                http.Response(fixture('google_calendar_entry.json'), 200));
        // act
        final result = await dataSoure.getAllRemoteCalendarEntries();
        // assert
        expect(result, equals(tGCalEntryModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(() => mockHttpClient.get(url, headers: any(named: 'headers')))
            .thenAnswer(
          (_) async => http.Response('Something went wrong', 404),
        );
        // act
        final call = dataSoure.getAllRemoteCalendarEntries;
        // assert
        expect(call, throwsA(isA<ServerException>()));
      },
    );
  });
}
