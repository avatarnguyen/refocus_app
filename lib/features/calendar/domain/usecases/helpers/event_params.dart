import 'package:equatable/equatable.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';

class EventParams extends Equatable {
  const EventParams({required this.eventEntry, this.calendarId});

  final CalendarEventEntry eventEntry;
  final String? calendarId;

  @override
  List<Object?> get props => [eventEntry, calendarId];
}
