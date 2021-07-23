import 'package:refocus_app/features/google_calendar/data/models/google_calendar_entry_model.dart';

abstract class GoogleCalendarLocalDataSource {
  /// Gets the cached [GoogleCalendarEntryModel] which was gotten the last time
  /// the user had an internet connection.  ///
  /// Throws a [CacheException] for all error codes.
  Future<GoogleCalendarEntryModel> getLastCalendarEntry();

  Future<void>? cacheGoogleCalendarEntry(
      GoogleCalendarEntryModel calendarEntryToCache);
}
