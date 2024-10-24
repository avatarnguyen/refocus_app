import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'calendar_event_entry.g.dart';

@HiveType(typeId: 1)
class CalendarEventEntry extends Equatable {
  const CalendarEventEntry({
    required this.subject,
    this.id,
    this.calendarId,
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

  @HiveField(0)
  final String subject; // Event summary
  @HiveField(1)
  final String? id;
  @HiveField(2)
  final String? calendarId;
  @HiveField(3)
  final String? colorId;
  @HiveField(4)
  final String? notes; // Event description
  @HiveField(5)
  final String? location;
  @HiveField(6)
  final List<String>? recurrence;
  @HiveField(7)
  final String? recurringEventId;
  @HiveField(8)
  final DateTime? startDateTime;
  @HiveField(9)
  final DateTime? startDate;
  @HiveField(10)
  final DateTime? endDateTime;
  @HiveField(11)
  final DateTime? endDate;
  @HiveField(12)
  final bool? allDay;
  @HiveField(13)
  final String? organizer;
  @HiveField(14)
  final String? timeZone;

  @override
  List<Object?> get props => [
        id,
        calendarId,
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
