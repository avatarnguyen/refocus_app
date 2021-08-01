import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:googleapis/calendar/v3.dart' as google_api;

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  InternetConnectionChecker get internetChecker => InternetConnectionChecker();

  @lazySingleton
  GoogleSignIn get gCalSignIn => GoogleSignIn(
        clientId:
            '478862318784-jl05jk9ujotlfdk0v3a6dkg8jkdt8ecm.apps.googleusercontent.com',
        scopes: <String>[
          google_api.CalendarApi.calendarScope,
        ],
      );
}
