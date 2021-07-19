import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'google_calendar_event.dart';
part 'google_calendar_state.dart';
class GoogleCalendarBloc extends Bloc<GoogleCalendarEvent, GoogleCalendarState> {
  GoogleCalendarBloc() : super(GoogleCalendarInitial());
  @override
  Stream<GoogleCalendarState> mapEventToState(
    GoogleCalendarEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
