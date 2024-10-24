part of 'tomorrow_bloc.dart';

abstract class TomorrowEvent extends Equatable {
  const TomorrowEvent();
}

class GetTomorrowEvent extends TomorrowEvent {
  const GetTomorrowEvent(this.date);

  final DateTime date;

  @override
  List<Object?> get props => [date];
}
