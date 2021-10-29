import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';

// ignore_for_file: implicit_dynamic_parameter
class GCalEventEntryModel extends CalendarEventEntry {
  const GCalEventEntryModel({
    required String subject,
    String? id,
    String? colorId,
    String? calendarId,
    String? notes,
    String? location,
    List<String>? recurrence,
    String? recurringEventId,
    DateTime? startDateTime,
    DateTime? startDate,
    DateTime? endDateTime,
    DateTime? endDate,
    bool? allDay,
    String? organizer,
    String? timeZone,
  }) : super(
          id: id,
          colorId: colorId,
          calendarId: calendarId,
          notes: notes,
          subject: subject,
          location: location,
          recurrence: recurrence,
          recurringEventId: recurringEventId,
          startDateTime: startDateTime,
          startDate: startDate,
          endDateTime: endDateTime,
          endDate: endDate,
          allDay: allDay,
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
      subject: json['summary'] as String? ?? '',
      id: json['id'] as String?,
      calendarId: json['calendarId'] as String?,
      colorId: json['colorId'] as String?,
      notes: json['description'] as String?,
      location: json['location'] as String?,
      recurrence: json['recurrence'] as List<String>?,
      recurringEventId: json['recurringEventId'] as String?,
      startDateTime: startEvent != null
          ? startEvent.containsKey('dateTime')
              ? DateTime.parse(startEvent['dateTime'] as String)
              : null
          : null,
      startDate: startEvent != null
          ? startEvent.containsKey('date')
              ? DateTime.parse(startEvent['date'] as String)
              : null
          : null,
      endDateTime: endEvent != null
          ? endEvent.containsKey('dateTime')
              ? DateTime.parse(endEvent['dateTime'] as String)
              : null
          : null,
      endDate: endEvent != null
          ? endEvent.containsKey('date')
              ? DateTime.parse(endEvent['date'] as String)
              : null
          : null,
      allDay: startEvent != null
          ? startEvent.containsKey('date')
              ? true
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

  Map<String, dynamic> toJson() => <String, dynamic>{
        'summary': subject,
        if (id != null) 'id': id,
        if (colorId != null) 'colorId': colorId,
        if (calendarId != null) 'calendarId': calendarId,
        if (notes != null) 'description': notes,
        if (location != null) 'location': location,
        if (recurrence != null) 'recurrence': recurrence,
        if (recurringEventId != null) 'recurringEventId': recurringEventId,
        // if (allDay != null) 'allDay': allDay,
        'start': {
          if (startDateTime != null) 'dateTime': startDateTime.toString(),
          if (startDate != null) 'date': startDate.toString(),
          if (timeZone != null) 'timeZone': {'timeZone': timeZone.toString()},
        },
        if (endDateTime != null || endDate != null)
          'end': {
            if (endDate != null) 'date': endDate.toString(),
            if (endDateTime != null) 'dateTime': endDateTime.toString(),
          },
        if (organizer != null) 'organizer': {'displayName': organizer},
      };
}
