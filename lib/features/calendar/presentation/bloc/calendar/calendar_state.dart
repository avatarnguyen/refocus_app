part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => [];
}

class GcalInitial extends CalendarState {}

class Empty extends CalendarState {}

class Loading extends CalendarState {}

class Loaded extends CalendarState {
  const Loaded({required this.calendarData});

  final CalendarData calendarData;

  @override
  List<Object> get props => (calendarData.props.map((e) => e!).toList());
}

class Error extends CalendarState {
  const Error({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
