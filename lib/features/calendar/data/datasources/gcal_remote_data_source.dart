import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as google_api;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as io;
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../models/gcal_event_entry_model.dart';

abstract class GCalRemoteDataSource {
  /// Calls the google calendar api endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<GCalEventEntryModel>> getRemoteGoogleEventsData(
      {List<String>? calendarList,
      required DateTime timeMin,
      required DateTime timeMax});
}

@LazySingleton(as: GCalRemoteDataSource)
class GoogleAPIGCalRemoteDataSoure implements GCalRemoteDataSource {
  GoogleAPIGCalRemoteDataSoure({required this.gCalSignIn});

  final GoogleSignIn gCalSignIn;

  @override
  Future<List<GCalEventEntryModel>> getRemoteGoogleEventsData({
    List<String>? calendarList,
    required DateTime timeMin,
    required DateTime timeMax,
  }) async {
    final appointments = <GCalEventEntryModel>[];

    var client = await gCalSignIn.authenticatedClient();

    if (client != null) {
      final calendarApi = google_api.CalendarApi(client);

      try {
        //Test Dev Calendar ID: in558pn22g34uj8j769poaddpk@group.calendar.google.com
        // final calEvents = await calendarApi.events.list(
        //   'nguyenanh12.vn@gmail.com',
        //   timeMin: DateTime.parse('2021-08-01T01:00:00+02:00'),
        //   timeMax: DateTime.parse('2021-08-30T23:55:00+02:00'),
        // );
        if (calendarList != null) {
          for (var calendar in calendarList) {
            final calEvents = await calendarApi.events.list(
              calendar,
              timeMin: timeMin,
              timeMax: timeMax,
            );
            _addEventsToAppointments(calEvents, appointments);
          }
        } else {
          final calEvents = await calendarApi.events.list(
            'primary',
            timeMin: timeMin,
            timeMax: timeMax,
          );
          _addEventsToAppointments(calEvents, appointments);
        }
      } catch (e) {
        print(e);
        throw ServerException();
      }
    } else {
      await gCalSignIn.signIn();
    }

    print('Appointments: ${appointments.length}');

    //TODO: Write Test to check # of appointments return
    return appointments;
  }

  void _addEventsToAppointments(
      google_api.Events calEvents, List<GCalEventEntryModel> appointments) {
    if (calEvents.items != null && calEvents.items!.isNotEmpty) {
      print('Items Total #: ${calEvents.items!.length}');
      for (var i = 0; i < calEvents.items!.length; i++) {
        final event = calEvents.items![i];
        if (event.start != null) {
          appointments.add(GCalEventEntryModel.fromJson(event.toJson()));
        }
      }
    }
  }
}

// TODO: retrive dynamicly calendar ID & save ID locally
// final calendarsList = await calendarApi.calendarList.list();
// final calendarItems = calendarsList.items;
// if (calendarItems != null) {
//   print('List of Calendar:');
//   calendarItems.forEach((element) {
//     final calendar = element.summary;
//     final calendarId = element.id;
//     print('$calendar - $calendarId');
//   });
// }

class GoogleAPIClient extends io.IOClient {
  GoogleAPIClient(this._headers) : super();

  final Map<String, String> _headers;

  @override
  Future<io.IOStreamedResponse> send(http.BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) =>
      super.head(url, headers: headers?..addAll(_headers));
}
