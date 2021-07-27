import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/features/google_calendar/data/models/google_calendar_entry_model.dart';

abstract class GCalRemoteDataSource {
  /// Calls the google calendar api endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<GoogleCalendarEntryModel> getAllRemoteCalendarEntries();
}

class HttpGCalRemoteDataSoure implements GCalRemoteDataSource {
  HttpGCalRemoteDataSoure({required this.client});

  final http.Client client;

  @override
  Future<GoogleCalendarEntryModel> getAllRemoteCalendarEntries() async {
    var url = Uri.parse(
        'https://www.googleapis.com/calendar/v3/calendars/in558pn22g34uj8j769poaddpk@group.calendar.google.com/events?key=AIzaSyC-JYOakQBzGvadMpr8ji3zE_AhvZ3bq7k');
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return GoogleCalendarEntryModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
