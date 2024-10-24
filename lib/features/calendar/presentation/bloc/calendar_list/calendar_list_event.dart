part of 'calendar_list_bloc.dart';

abstract class CalendarListEvent extends Equatable {
  const CalendarListEvent();
}

class GetCalendarListEvent extends CalendarListEvent {
  @override
  List<Object?> get props => [];
}

class UpdateCalendarListEvent extends CalendarListEvent {
  const UpdateCalendarListEvent(this.params);

  final CalendarParams params;

  @override
  List<Object?> get props => [params];
}
