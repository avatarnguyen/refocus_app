part of 'calendar_list_bloc.dart';

abstract class CalendarListEvent extends Equatable {
  const CalendarListEvent();

  @override
  List<Object> get props => [];
}

class GetCalendarListEvent extends CalendarListEvent {}

class UpdateCalendarEvent extends CalendarListEvent {
  const UpdateCalendarEvent(this.params);

  final CalendarParams params;
}
