import 'dart:developer';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as google_api;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as io;
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/features/calendar/data/models/gcal_entry_model.dart';

import '../../../../core/error/exceptions.dart';
import '../models/gcal_event_entry_model.dart';

abstract class GCalRemoteDataSource {
  /// Get Google CalendarListEntries
  Future<List<GCalEntryModel>> getRemoteGoogleCalendar();

  /// Calls the google calendar api endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<GCalEventEntryModel>> getRemoteGoogleEventsData(
      {List<GCalEntryModel>? calendarList,
      required DateTime timeMin,
      required DateTime timeMax});

  /// Add New Event to Google Calendar
  Future<void> addRemoteGoogleEvent(
      {String? calendarId, required GCalEventEntryModel eventModel});

  /// Update Event in Google Calendar
  Future<void> updateRemoteGoogleEvent(
      {String? calendarId, required GCalEventEntryModel eventModel});

  /// Delete Event in Google Calendar
  Future<void> deleteRemoteGoogleEvent(
      {required String calendarId, required GCalEventEntryModel eventModel});
}

@LazySingleton(as: GCalRemoteDataSource)
class GoogleAPIGCalRemoteDataSoure implements GCalRemoteDataSource {
  GoogleAPIGCalRemoteDataSoure({required this.gCalSignIn});

  final GoogleSignIn gCalSignIn;

  @override
  Future<List<GCalEventEntryModel>> getRemoteGoogleEventsData({
    List<GCalEntryModel>? calendarList,
    required DateTime timeMin,
    required DateTime timeMax,
  }) async {
    final log = logger(GCalRemoteDataSource);

    final appointments = <GCalEventEntryModel>[];

    final client = await gCalSignIn.authenticatedClient();

    if (client != null) {
      final calendarApi = google_api.CalendarApi(client);

      try {
        if (calendarList != null) {
          if (calendarList.isNotEmpty) {
            for (final calendar in calendarList) {
              final calEvents = await calendarApi.events.list(
                calendar.id,
                timeMin: timeMin,
                timeMax: timeMax,
              );
              _insertEventsToAppointments(
                calEvents,
                appointments,
                calendar: calendar,
              );
            }
          }
        } else {
          final calEvents = await calendarApi.events.list(
            'primary',
            timeMin: timeMin,
            timeMax: timeMax,
          );
          _insertEventsToAppointments(calEvents, appointments);
        }
      } catch (e) {
        log.e('Catched: ${e.toString()}');
        throw ServerException();
      }
    } else {
      await gCalSignIn.signIn();
    }

    print('Appointments: ${appointments.length}');

    //TODO: Write Test to check # of appointments return
    //! not sure whether this working, login seems off
    return appointments;
  }

  List<GCalEventEntryModel> _insertEventsToAppointments(
      google_api.Events calEvents, List<GCalEventEntryModel> appointments,
      {GCalEntryModel? calendar}) {
    if (calEvents.items != null && calEvents.items!.isNotEmpty) {
      log('Items Total #: ${calEvents.items!.length}');
      for (var i = 0; i < calEvents.items!.length; i++) {
        final event = calEvents.items![i];
        if (event.start != null) {
          final eventJson = event.toJson();

          eventJson['colorId'] = calendar?.color ?? '#3B2DB0';
          eventJson['calendarId'] = calendar?.id ?? 'primary';
          appointments.add(GCalEventEntryModel.fromJson(eventJson));
        }
      }
    }
    return appointments;
  }

  @override
  Future<void> addRemoteGoogleEvent({
    String? calendarId,
    required GCalEventEntryModel eventModel,
  }) async {
    var client = await gCalSignIn.authenticatedClient();
    if (client != null) {
      final calendarApi = google_api.CalendarApi(client);

      try {
        final request = google_api.Event.fromJson(eventModel.toJson());
        await calendarApi.events.insert(request, calendarId ?? 'primary');
      } catch (e) {
        log('Catched: ${e.toString()}');
        throw ServerException();
      }
    } else {
      await gCalSignIn.signIn();
    }
  }

  @override
  Future<void> updateRemoteGoogleEvent({
    String? calendarId,
    required GCalEventEntryModel eventModel,
  }) async {
    final client = await gCalSignIn.authenticatedClient();
    if (client != null) {
      final calendarApi = google_api.CalendarApi(client);

      try {
        if (eventModel.id != null) {
          final request = google_api.Event.fromJson(eventModel.toJson());
          print(eventModel.toJson());
          print(request.toJson());
          print('Calendar ID: $calendarId');
          await calendarApi.events.update(
            request,
            calendarId ?? 'primary',
            eventModel.id!,
          );
        } else {
          log('Event ID is null');
          throw ServerException();
        }
      } catch (e) {
        log('Catched: ${e.toString()}');
        throw ServerException();
      }
    } else {
      await gCalSignIn.signIn();
    }
  }

  @override
  Future<void> deleteRemoteGoogleEvent({
    required String calendarId,
    required GCalEventEntryModel eventModel,
  }) async {
    var client = await gCalSignIn.authenticatedClient();
    if (client != null) {
      final calendarApi = google_api.CalendarApi(client);

      try {
        if (eventModel.id != null) {
          await calendarApi.events.delete(calendarId, eventModel.id!);
        } else {
          log('Event ID is null');
          throw ServerException();
        }
      } catch (e) {
        log('Catched: ${e.toString()}');
        throw ServerException();
      }
    } else {
      await gCalSignIn.signIn();
    }
  }

  @override
  Future<List<GCalEntryModel>> getRemoteGoogleCalendar() async {
    final calendars = <GCalEntryModel>[];
    final log = logger(GCalRemoteDataSource);

    var client = await gCalSignIn.authenticatedClient();
    if (client != null) {
      final calendarApi = google_api.CalendarApi(client);

      try {
        final calendarsList = await calendarApi.calendarList.list();
        final calendarItems = calendarsList.items;
        if (calendarItems != null) {
          for (var item in calendarItems) {
            // log.d('Calendar Items: ${item.toJson()}');
            final calendar = GCalEntryModel.fromJson(item.toJson());
            calendars.add(calendar);
          }
        }
      } catch (e) {
        log.e('Catched: ${e.toString()}');
        throw ServerException();
      }
    } else {
      await gCalSignIn.signIn();
    }

    return calendars;
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
