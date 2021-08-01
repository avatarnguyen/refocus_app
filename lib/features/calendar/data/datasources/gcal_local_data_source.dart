import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/gcal_event_entry_model.dart';

abstract class GCalLocalDataSource {
  /// Gets the cached [GCalEventEntryModel] which was gotten the last time
  /// the user had an internet connection.  ///
  /// Throws a [CacheException] for all error codes.
  Future<List<GCalEventEntryModel>> getLastCalendarEntry();

  Future<void>? cacheGoogleCalendarEntry(
      List<GCalEventEntryModel> calendarEntryToCache);
}

const cachedGCalEntry = 'CACHED_GCAL_ENTRY';

@LazySingleton(as: GCalLocalDataSource)
class SharedPrefGCalLocalDataSource implements GCalLocalDataSource {
  SharedPrefGCalLocalDataSource({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<List<GCalEventEntryModel>> getLastCalendarEntry() {
    final jsonListString = sharedPreferences.getStringList(cachedGCalEntry);

    if (jsonListString != null) {
      return Future.value(jsonListString
          .map((item) => GCalEventEntryModel.fromJson(json.decode(item)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? cacheGoogleCalendarEntry(
      List<GCalEventEntryModel> calendarEntryToCache) {
    sharedPreferences.setStringList(
      cachedGCalEntry,
      calendarEntryToCache.map((item) => json.encode(item.toJson())).toList(),
    );
  }
}
