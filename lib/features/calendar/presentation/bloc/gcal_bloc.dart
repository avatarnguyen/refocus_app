import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/calendar/domain/entities/gcal_event_entry.dart';
import 'package:refocus_app/features/calendar/domain/usecases/get_google_events.dart';

part 'gcal_event.dart';
part 'gcal_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String invalidInputFailureMessage =
    'Invalid Input - The number must be a positive integer or zero.';

class GcalBloc extends Bloc<GcalEvent, GcalState> {
  GcalBloc({required this.getAllCalendarEntry}) : super(GcalInitial());

  final GetGoogleEvents getAllCalendarEntry;

  @override
  Stream<GcalState> mapEventToState(
    GcalEvent event,
  ) async* {
    if (event is GetAllCalendarEntries) {
      print("Event is GetAllCalendarEntries");
      yield Loading();
      final failureOrEntry = await getAllCalendarEntry(NoParams());
      yield failureOrEntry.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (entry) => Loaded(gCalEntry: entry),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
}
