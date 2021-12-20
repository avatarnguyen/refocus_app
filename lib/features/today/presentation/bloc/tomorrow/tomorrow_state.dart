part of 'tomorrow_bloc.dart';

abstract class TomorrowState extends Equatable {
  const TomorrowState();
}

class TomorrowLoading extends TomorrowState {
  @override
  List<Object> get props => [];
}

class TomorrowLoaded extends TomorrowState {
  const TomorrowLoaded(this.entries);

  final List<TodayEntry> entries;
  @override
  List<Object> get props => [entries];
}

class TomorrowError extends TomorrowState {
  const TomorrowError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
