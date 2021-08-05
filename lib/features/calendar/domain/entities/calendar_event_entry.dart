import 'package:equatable/equatable.dart';

class CalendarEventEntry extends Equatable {
  const CalendarEventEntry({
    required this.subject,
    this.id,
    this.colorId,
    this.notes,
    this.location,
    this.recurrence,
    this.recurringEventId,
    this.startDateTime,
    this.startDate,
    this.endDateTime,
    this.endDate,
    this.allDay,
    this.organizer,
    this.timeZone,
  });

  final String subject; // Event summary
  final String? id;
  final String? colorId;
  final String? notes; // Event description
  final String? location;
  final List<String>? recurrence;
  final String? recurringEventId;
  final DateTime? startDateTime;
  final DateTime? startDate;
  final DateTime? endDateTime;
  final DateTime? endDate;
  final bool? allDay;
  final String? organizer;
  final String? timeZone;

  @override
  List<Object?> get props => [
        id,
        colorId,
        notes,
        subject,
        location,
        recurrence,
        recurringEventId,
        startDateTime,
        startDate,
        endDateTime,
        endDate,
        allDay,
        organizer,
        timeZone,
      ];
}
