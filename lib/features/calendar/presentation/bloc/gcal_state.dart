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
  const Loaded({required this.gCalEntry});

  final GoogleCalendarEntry gCalEntry;

  @override
  List<Object> get props => [gCalEntry];
}

class Error extends GcalState {
  const Error({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
