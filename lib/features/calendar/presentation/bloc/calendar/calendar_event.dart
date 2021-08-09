part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class GetCalendarEntries extends CalendarEvent {}

class AddCalendarEvent extends CalendarEvent {
  const AddCalendarEvent(this.params);

  final EventParams params;
}

class UpdateCalendarEvent extends CalendarEvent {
  const UpdateCalendarEvent(this.params);

  final EventParams params;
}

class DeleteCalendarEvent extends CalendarEvent {
  const DeleteCalendarEvent(this.params);

  final EventParams params;
}
