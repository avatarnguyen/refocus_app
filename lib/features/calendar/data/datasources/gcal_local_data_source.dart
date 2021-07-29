import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/google_calendar_entry_model.dart';

abstract class GCalLocalDataSource {
  /// Gets the cached [GCalEventEntryModel] which was gotten the last time
  /// the user had an internet connection.  ///
  /// Throws a [CacheException] for all error codes.
  Future<GCalEventEntryModel> getLastCalendarEntry();

  Future<void>? cacheGoogleCalendarEntry(
      GCalEventEntryModel calendarEntryToCache);
}

const cachedGCalEntry = 'CACHED_GCAL_ENTRY';

class SharedPrefGCalLocalDataSource implements GCalLocalDataSource {
  SharedPrefGCalLocalDataSource({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<GCalEventEntryModel> getLastCalendarEntry() {
    final jsonString = sharedPreferences.getString(cachedGCalEntry);
    if (jsonString != null) {
      // Future which is immediately completed
      return Future.value(
          GCalEventEntryModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? cacheGoogleCalendarEntry(
      GCalEventEntryModel calendarEntryToCache) {
    sharedPreferences.setString(
      cachedGCalEntry,
      json.encode(calendarEntryToCache.toJson()),
    );
  }
}
