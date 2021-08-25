part of 'today_bloc.dart';

abstract class TodayState extends Equatable {
  const TodayState();
  
  @override
  List<Object> get props => [];
}

class TodayInitial extends TodayState {}
