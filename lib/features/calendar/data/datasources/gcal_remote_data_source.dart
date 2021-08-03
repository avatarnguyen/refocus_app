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

    GoogleSignInAccount? _currentUser;

    // final googleUser = await gCalSignIn.signIn();
    // final _authHeaders = await googleUser?.authHeaders;

    if (gCalSignIn.currentUser == null) {
      await gCalSignIn.signIn();
    }

    var client = (await gCalSignIn.authenticatedClient())!;

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

    // gCalSignIn.onCurrentUserChanged
    //     .listen((GoogleSignInAccount? account) async {
    //   print('USER CHANGES');

    //   _currentUser = account;

    //   if (_currentUser != null) {
    //     final _header = await _currentUser!.authHeaders;
    //   }
    //   // Sign In if user not exist
    //   _currentUser = await gCalSignIn.signIn();
    // });

    // if (_authHeaders != null) {
    // } else {
    //   throw ServerException();
    // }

    print('Appointments: ${appointments.length}');

    //TODO: Write Test to check # of appointments return
    return appointments;

    // var url = Uri.parse(
    //     'https://www.googleapis.com/calendar/v3/calendars/in558pn22g34uj8j769poaddpk@group.calendar.google.com/events?key=AIzaSyC-JYOakQBzGvadMpr8ji3zE_AhvZ3bq7k');
    // final response = await client.get(
    //   url,
    //   headers: {'Content-Type': 'application/json'},
    // );

    // if (response.statusCode == 200) {
    //   return GCalEventEntryModel.fromJson(json.decode(response.body));
    // } else {
    //   throw ServerException();
    // }
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
