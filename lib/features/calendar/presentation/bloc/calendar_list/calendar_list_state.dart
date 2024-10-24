part of 'calendar_list_bloc.dart';

abstract class CalendarListState extends Equatable {
  const CalendarListState();
}

class CalendarListInitial extends CalendarListState {
  @override
  List<Object?> get props => [];
}

class CalendarListLoading extends CalendarListState {
  @override
  List<Object?> get props => [];
}

class CalendarListLoaded extends CalendarListState {
  const CalendarListLoaded({required this.calendarList});

  final List<CalendarEntry> calendarList;

  @override
  List<Object?> get props => calendarList;
}

class CalendarListError extends CalendarListState {
  const CalendarListError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
