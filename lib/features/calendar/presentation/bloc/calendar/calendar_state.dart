part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();
}

class CalendarInitial extends CalendarState {
  @override
  List<Object?> get props => [];
}

class CalendarLoading extends CalendarState {
  @override
  List<Object?> get props => [];
}

class CalendarLoaded extends CalendarState {
  const CalendarLoaded({required this.calendarData});

  final CalendarData calendarData;

  @override
  List<Object?> get props => calendarData.props.map((e) => e).toList();
}

class CalendarError extends CalendarState {
  const CalendarError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
