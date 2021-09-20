part of 'today_bloc.dart';

abstract class TodayEvent extends Equatable {
  const TodayEvent();

  @override
  List<Object> get props => [];
}

/// BLoC Event: Fetch Calendar and Timeblock Entries for a specific day
class GetTodayEntries extends TodayEvent {
  const GetTodayEntries(this.date);

  final DateTime date;

  @override
  List<Object> get props => [date];
}

class GetTomorrowEntries extends TodayEvent {
  const GetTomorrowEntries(this.date);

  final DateTime date;

  @override
  List<Object> get props => [date];
}

class GetUpcomingTask extends TodayEvent {
  const GetUpcomingTask(this.startDate, this.endDate);

  final DateTime startDate;
  final DateTime endDate;

  @override
  List<Object> get props => [startDate, endDate];
}
