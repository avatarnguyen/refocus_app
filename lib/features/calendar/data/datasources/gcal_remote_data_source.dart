import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
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
  Future<List<GCalEventEntryModel>> getRemoteGoogleEventsData();
}

@LazySingleton(as: GCalRemoteDataSource)
class GoogleAPIGCalRemoteDataSoure implements GCalRemoteDataSource {
  GoogleAPIGCalRemoteDataSoure({required this.gCalSignIn});

  final GoogleSignIn gCalSignIn;

  @override
  Future<List<GCalEventEntryModel>> getRemoteGoogleEventsData() async {
    final appointments = <GCalEventEntryModel>[];

    var client = await gCalSignIn.authenticatedClient();

    if (client != null) {
      final calendarApi = google_api.CalendarApi(client);

      // TODO: retrive dynamicly calendar ID
      final calEvents = await calendarApi.events
          .list('in558pn22g34uj8j769poaddpk@group.calendar.google.com');

      if (calEvents.items != null && calEvents.items!.isNotEmpty) {
        print('Items Total #: ${calEvents.items!.length}');
        print('Items: ${calEvents.items!.first.start}');

        for (var i = 0; i < calEvents.items!.length; i++) {
          print("Event: ${calEvents.items![i]}");
          final event = calEvents.items![i] as Event;
          if (event.start != null) {
            appointments.add(GCalEventEntryModel.fromJson(event.toJson()));
          }
        }
      } else {
        throw ServerException();
      }
    } else {
      await gCalSignIn.signIn();
    }

    print('Appointments: ${appointments.length}');

    //TODO: Write Test to check # of appointments return
    return appointments;
  }
}

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
