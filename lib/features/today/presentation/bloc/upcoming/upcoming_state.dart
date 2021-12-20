part of 'upcoming_cubit.dart';

abstract class UpcomingState extends Equatable {
  const UpcomingState();
}

class UpcomingLoading extends UpcomingState {
  const UpcomingLoading();
  @override
  List<Object> get props => [];
}

class UpcomingLoaded extends UpcomingState {
  const UpcomingLoaded(this.entries);

  final List<TodayEntry> entries;
  @override
  List<Object> get props => [entries];
}

class UpcomingError extends UpcomingState {
  const UpcomingError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
