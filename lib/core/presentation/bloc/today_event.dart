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