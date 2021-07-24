import 'dart:convert';

import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/features/google_calendar/data/models/google_calendar_entry_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GCalLocalDataSource {
  /// Gets the cached [GoogleCalendarEntryModel] which was gotten the last time
  /// the user had an internet connection.  ///
  /// Throws a [CacheException] for all error codes.
  Future<GoogleCalendarEntryModel> getLastCalendarEntry();

  Future<void>? cacheGoogleCalendarEntry(
      GoogleCalendarEntryModel calendarEntryToCache);
}

const cachedGCalEntry = 'CACHED_GCAL_ENTRY';

class SharedPrefGCalLocalDataSource implements GCalLocalDataSource {
  SharedPrefGCalLocalDataSource({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<GoogleCalendarEntryModel> getLastCalendarEntry() {
    final jsonString = sharedPreferences.getString(cachedGCalEntry);
    if (jsonString != null) {
      // Future which is immediately completed
      return Future.value(
          GoogleCalendarEntryModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? cacheGoogleCalendarEntry(
      GoogleCalendarEntryModel calendarEntryToCache) {
    sharedPreferences.setString(
      cachedGCalEntry,
      json.encode(calendarEntryToCache.toJson()),
    );
  }
}
