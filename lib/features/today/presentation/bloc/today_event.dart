part of 'today_bloc.dart';

abstract class TodayEvent extends Equatable {
  const TodayEvent();

  @override
  List<Object> get props => [];
}

/// BLoC Event: Fetch Calendar and Timeblock Entries for a specific day
class GetTodayEntriesOfSpecificDate extends TodayEvent {
  const GetTodayEntriesOfSpecificDate(this.date);

  final DateTime date;

  @override
  List<Object> get props => [date];
}

class GetTodayEntries extends TodayEvent {
  const GetTodayEntries();

  @override
  List<Object> get props => [];
}

class UpdateTaskEntries extends TodayEvent {
  const UpdateTaskEntries({this.date, required this.eventType});

  final DateTime? date;
  final TodayEventType eventType;

  @override
  List<Object> get props => [date ?? DateTime.now(), eventType];
}
