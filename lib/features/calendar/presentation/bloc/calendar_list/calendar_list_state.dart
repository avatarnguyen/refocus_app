part of 'calendar_list_bloc.dart';

abstract class CalendarListState extends Equatable {
  const CalendarListState();

  @override
  List<Object> get props => [];
}

class CalendarListInitial extends CalendarListState {}

class Empty extends CalendarListState {}

class Loading extends CalendarListState {}

class Loaded extends CalendarListState {
  const Loaded({required this.calendarList});

  final List<CalendarEntry> calendarList;

  @override
  List<Object> get props => calendarList;
}

class Error extends CalendarListState {
  const Error({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
