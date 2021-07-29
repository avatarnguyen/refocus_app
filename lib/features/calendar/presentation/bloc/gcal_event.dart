part of 'gcal_bloc.dart';

abstract class GcalEvent extends Equatable {
  const GcalEvent();

  @override
  List<Object> get props => [];
}

class GetAllCalendarEntries extends GcalEvent {}
