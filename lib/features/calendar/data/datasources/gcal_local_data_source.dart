import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
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
class HiveGCalLocalDataSource implements GCalLocalDataSource {
  HiveGCalLocalDataSource({required this.gcalBox});

  final Box gcalBox;

  @override
  Future<void>? cacheGoogleCalendarEntry(
      List<GCalEventEntryModel> calendarEntryToCache) {
    for (var entry in calendarEntryToCache) {
      final CalendarEventEntry calendarEntry = entry;
      gcalBox.put(
        calendarEntry.id ?? calendarEntry.subject,
        calendarEntry,
      );
    }
  }

  @override
  Future<List<GCalEventEntryModel>> getLastCalendarEntry() {
    final entryList = <GCalEventEntryModel>[];
    for (var i = 0; i < gcalBox.length; i++) {
      final entry = gcalBox.getAt(i) as CalendarEventEntry;
      entryList.add(_eventEntryConverter(entry));
    }
    return Future.value(entryList);
  }

  GCalEventEntryModel _eventEntryConverter(CalendarEventEntry event) {
    final model = GCalEventEntryModel(
      id: event.id,
      subject: event.subject,
      notes: event.notes,
      startDateTime: event.startDateTime,
      startDate: event.startDate,
      endDate: event.endDate,
      endDateTime: event.endDateTime,
      organizer: event.organizer,
    );
    return model;
  }
}

// @LazySingleton(as: GCalLocalDataSource)
// class SharedPrefGCalLocalDataSource implements GCalLocalDataSource {
//   SharedPrefGCalLocalDataSource({required this.sharedPreferences});

//   final SharedPreferences sharedPreferences;

//   @override
//   Future<List<GCalEventEntryModel>> getLastCalendarEntry() {
//     final jsonListString = sharedPreferences.getStringList(cachedGCalEntry);

//     if (jsonListString != null) {
//       return Future.value(jsonListString
//           .map((item) => GCalEventEntryModel.fromJson(json.decode(item)))
//           .toList());
//     } else {
//       throw CacheException();
//     }
//   }

//   @override
//   Future<void>? cacheGoogleCalendarEntry(
//       List<GCalEventEntryModel> calendarEntryToCache) {
//     sharedPreferences.setStringList(
//       cachedGCalEntry,
//       calendarEntryToCache.map((item) => json.encode(item.toJson())).toList(),
//     );
//   }
// }
