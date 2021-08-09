import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/features/calendar/data/models/gcal_entry_model.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';

import '../../../../core/error/exceptions.dart';
import '../models/gcal_event_entry_model.dart';

abstract class GCalLocalDataSource {
  /// Gets the cached [GCalEventEntryModel] which was gotten the last time
  /// the user had an internet connection.  ///
  /// Throws a [CacheException] for all error codes.
  Future<List<GCalEventEntryModel>> getLastCalendarEventEntry();

  Future<void> cacheGoogleCalendarEntry(
      List<GCalEventEntryModel> calendarEntryToCache);

  /// Cache Calendar List [GCalEntryModel] in Local Database
  ///
  /// And return the same list of calendars [GCalEntryModel] back.
  Future<void> cacheRemoteGoogleCalendar(List<GCalEntryModel> calendars);

  /// Get Cached Google CalendarList Entries
  Future<List<GCalEntryModel>> getLastCachedGoogleCalendar();
}

const cachedGCalEntry = 'CACHED_GCAL_ENTRY';
const cachedCalendarList = 'CACHED_CALENDAR_LIST';

@LazySingleton(as: GCalLocalDataSource)
class HiveGCalLocalDataSource implements GCalLocalDataSource {
  HiveGCalLocalDataSource({
    required this.calendarBox,
    required this.gcalEventsBox,
  });

  final Box<CalendarEventEntry> gcalEventsBox;
  final Box<CalendarEntry> calendarBox;

  @override
  Future<void> cacheGoogleCalendarEntry(
      List<GCalEventEntryModel> calendarEntryToCache) async {
    var calendarEntry = <String, GCalEventEntryModel>{};

    try {
      await Future.forEach(
        calendarEntryToCache,
        (GCalEventEntryModel entry) => calendarEntry.addAll({
          entry.id ?? '': entry,
        }),
      );

      if (!gcalEventsBox.isOpen) {
        throw CacheException();
      }

      return gcalEventsBox.putAll(calendarEntry);
    } catch (e) {
      // ignore: avoid_print
      print(e);
      throw CacheException();
    }
  }

  @override
  Future<List<GCalEventEntryModel>> getLastCalendarEventEntry() {
    final entryList = <GCalEventEntryModel>[];

    for (var i = 0; i < gcalEventsBox.length; i++) {
      final entry = gcalEventsBox.getAt(i) as CalendarEventEntry;
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

  @override
  Future<void> cacheRemoteGoogleCalendar(List<GCalEntryModel> calendars) async {
    try {
      await Future.forEach(calendars, (GCalEntryModel entry) {
        // selected param should store locally and not sync with remote end point
        final calendarEntry = CalendarEntry(
          id: entry.id,
          name: entry.name,
          selected: calendarBox.get(entry.id)?.selected ?? entry.selected,
          color: entry.color,
          isDefault: entry.isDefault,
          timeZone: entry.timeZone,
        );

        // logger(GCalLocalDataSource).d(calendarEntry.toGCalJson());
        // {id: e_2_de#weeknum@group.v.calendar.google.com, summary: Kalenderwochen, color: #9fc6e7, selected: true, timeZone: Europe/Berlin}

        calendarBox.put(
          calendarEntry.id,
          calendarEntry,
        );
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
      throw CacheException();
    }
  }

  @override
  Future<List<GCalEntryModel>> getLastCachedGoogleCalendar() {
    final calendarList = <GCalEntryModel>[];
    for (var i = 0; i < calendarBox.length; i++) {
      final entry = calendarBox.getAt(i);
      if (entry != null) {
        calendarList.add(GCalEntryModel.fromJson(entry.toGCalJson()));
      }
    }
    return Future.value(calendarList);
  }
}
