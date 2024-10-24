import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as google_api;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:refocus_app/constants/app_constants.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_local_data_source.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/task/data/datasources/task_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @preResolve
  Future<Box<CalendarEventEntry>> get gcalEventsBox =>
      Hive.openBox(cachedGCalEntry,
          compactionStrategy: (entries, deletedEntries) {
        return entries > 300;
      });

  @preResolve
  Future<Box<CalendarEntry>> get calendarBox =>
      Hive.openBox(cachedCalendarList);

  @preResolve
  Future<Box<String>> get projectColorBox => Hive.openBox(cachedProjectsColor);

  @lazySingleton
  InternetConnectionChecker get internetChecker => InternetConnectionChecker();

  @singleton
  GoogleSignIn get gCalSignIn => GoogleSignIn(
        clientId: Platform.isIOS
            ? kGoogleCalendarClientIdDevIos
            : kGoogleCalendarClientIdDevAndroid,
        scopes: <String>[
          google_api.CalendarApi.calendarScope,
        ],
      );
}
