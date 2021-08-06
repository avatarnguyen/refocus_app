import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_local_data_source.dart';
import 'package:googleapis/calendar/v3.dart' as google_api;
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';

@module
abstract class RegisterModule {
  // @preResolve
  // Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @preResolve
  Future<Box<CalendarEventEntry>> get gcalEventsBox =>
      Hive.openBox(cachedGCalEntry,
          compactionStrategy: (entries, deletedEntries) {
        return entries > 300;
      });

  @preResolve
  Future<Box<CalendarEntry>> get calendarBox =>
      Hive.openBox(cachedCalendarList);

  @lazySingleton
  InternetConnectionChecker get internetChecker => InternetConnectionChecker();

  @singleton
  GoogleSignIn get gCalSignIn => GoogleSignIn(
        clientId:
            '478862318784-jl05jk9ujotlfdk0v3a6dkg8jkdt8ecm.apps.googleusercontent.com',
        scopes: <String>[
          google_api.CalendarApi.calendarScope,
        ],
      );
}
