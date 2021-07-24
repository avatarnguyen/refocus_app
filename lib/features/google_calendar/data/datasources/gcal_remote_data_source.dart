import 'package:refocus_app/features/google_calendar/data/models/google_calendar_entry_model.dart';

abstract class GCalRemoteDataSource {
  /// Calls the google calendar api endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<GoogleCalendarEntryModel> getAllRemoteCalendarEntries();
}
