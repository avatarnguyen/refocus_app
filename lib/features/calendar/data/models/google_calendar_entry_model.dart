import 'package:refocus_app/features/calendar/domain/entities/gcal_event_entry.dart';
import 'package:googleapis/calendar/v3.dart' as google_api;

class GCalEventEntryModel extends GCalEventEntry {
  const GCalEventEntryModel({
    required google_api.Event appointment,
  }) : super(appointment: appointment);

  factory GCalEventEntryModel.fromJson(Map<String, dynamic> json) {
    return GCalEventEntryModel(
      appointment: google_api.Event.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() => appointment.toJson();
}
