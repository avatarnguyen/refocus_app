import 'package:refocus_app/features/calendar/domain/entities/gcal_event_entry.dart';
import 'package:googleapis/calendar/v3.dart' as google_api;

class GCalEventEntryModel extends GCalEventEntry {
  const GCalEventEntryModel({
    required id,
    required subject,
    colorId,
    notes,
    location,
    recurrence,
    recurringEventId,
    start,
    end,
  }) : super(
          id: id,
          colorId: colorId,
          notes: notes,
          subject: subject,
          location: location,
          recurrence: recurrence,
          recurringEventId: recurringEventId,
          start: start,
          end: end,
        );

  factory GCalEventEntryModel.fromJson(Map<String, dynamic> json) {
    return GCalEventEntryModel(
      id: json['id'] ?? '',
      subject: json['summary'] ?? '',
      colorId: json['colorId'],
      notes: json['description'],
      location: json['location'],
      recurrence: json['recurrence'],
      recurringEventId: json['recurringEventId'],
      start: json.containsKey('start') ? json['start'] : null,
      end: json.containsKey('end') ? json['end'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'colorId': colorId,
      'notes': notes,
      'subject': subject,
      'location': location,
      'recurrence': recurrence,
      'recurringEventId': recurringEventId,
      'start': start,
      'end': end,
    };
  }
}
