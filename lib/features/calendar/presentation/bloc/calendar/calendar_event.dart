part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();
}

class GetCalendarEntries extends CalendarEvent {
  const GetCalendarEntries({required this.start, required this.end});

  final DateTime start;
  final DateTime end;

  @override
  List<Object?> get props => [start, end];
}

class AddCalendarEvent extends CalendarEvent {
  const AddCalendarEvent(this.params);

  final EventParams params;

  @override
  List<Object?> get props => [params];
}

class UpdateCalendarEvent extends CalendarEvent {
  const UpdateCalendarEvent(this.params);

  final EventParams params;

  @override
  List<Object?> get props => [params];
}

class DeleteCalendarEvent extends CalendarEvent {
  const DeleteCalendarEvent(this.params);

  final EventParams params;

  @override
  List<Object?> get props => [params];
}
