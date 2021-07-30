part of 'gcal_bloc.dart';

abstract class GcalState extends Equatable {
  const GcalState();

  @override
  List<Object> get props => [];
}

class GcalInitial extends GcalState {}

class Empty extends GcalState {}

class Loading extends GcalState {}

class Loaded extends GcalState {
  const Loaded({required this.calendarData});

  final CalendarData calendarData;

  @override
  List<Object> get props => (calendarData.props.map((e) => e!).toList());
}

class Error extends GcalState {
  const Error({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
