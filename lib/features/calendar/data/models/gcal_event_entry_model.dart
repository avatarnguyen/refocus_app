import 'package:refocus_app/features/calendar/domain/entities/gcal_event_entry.dart';

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
    organizer,
    timeZone,
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
          organizer: organizer,
          timeZone: timeZone,
        );

  factory GCalEventEntryModel.fromJson(Map<String, dynamic> json) {
    final startEvent = json.containsKey('start')
        ? (json['start'] as Map<String, dynamic>)
        : null;
    final endEvent =
        json.containsKey('end') ? (json['end'] as Map<String, dynamic>) : null;
    final organizerMap = json.containsKey('organizer')
        ? (json['organizer'] as Map<String, dynamic>)
        : null;

    return GCalEventEntryModel(
      id: json['id'] ?? '',
      subject: json['summary'] ?? '',
      colorId: json['colorId'],
      notes: json['description'],
      location: json['location'],
      recurrence: json['recurrence'],
      recurringEventId: json['recurringEventId'],
      start: startEvent != null
          ? startEvent.containsKey('dateTime')
              ? DateTime.parse(startEvent['dateTime'] as String)
              : null
          : null,
      end: endEvent != null
          ? endEvent.containsKey('dateTime')
              ? DateTime.parse(endEvent['dateTime'] as String)
              : null
          : null,
      timeZone: startEvent != null
          ? startEvent.containsKey('timeZone')
              ? startEvent['timeZone'] as String
              : null
          : null,
      organizer: organizerMap != null
          ? organizerMap.containsKey('displayName')
              ? organizerMap['displayName'] as String
              : null
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'subject': subject,
        if (colorId != null) 'colorId': colorId,
        if (notes != null) 'notes': notes,
        if (location != null) 'location': location,
        if (recurrence != null) 'recurrence': recurrence,
        if (recurringEventId != null) 'recurringEventId': recurringEventId,
        if (start != null)
          'start': {
            'dateTime': start.toString(),
            if (timeZone != null) 'timeZone': {'timeZone': timeZone.toString()},
          },
        if (end != null) 'end': {'dateTime': end.toString()},
        if (organizer != null) 'organizer': {'displayName': organizer},
      };
}
