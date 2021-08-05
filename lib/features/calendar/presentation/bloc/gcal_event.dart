part of 'gcal_bloc.dart';

abstract class GcalEvent extends Equatable {
  const GcalEvent();

  @override
  List<Object> get props => [];
}

class GetCalendarEntries extends GcalEvent {}

class AddCalendarEvent extends GcalEvent {
  const AddCalendarEvent(this.params);

  final EventParams params;
}
