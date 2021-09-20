part of 'today_bloc.dart';

abstract class TodayState extends Equatable {
  const TodayState();

  @override
  List<Object> get props => [];
}

class TodayLoading extends TodayState {}

class TodayError extends TodayState {
  const TodayError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class TodayLoaded extends TodayState {
  const TodayLoaded({
    required this.todayEntries,
    this.tomorrowEntries,
    this.upcomingTasks,
  });

  final List<TodayEntry> todayEntries;
  final List<TodayEntry>? tomorrowEntries;
  final List<TodayEntry>? upcomingTasks;

  @override
  List<Object> get props => [
        todayEntries,
        tomorrowEntries ?? <TodayEntry>[],
        upcomingTasks ?? <TodayEntry>[]
      ];
}
