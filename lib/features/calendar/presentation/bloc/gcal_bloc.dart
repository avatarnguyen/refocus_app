import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_datasource.dart';
import 'package:refocus_app/features/calendar/domain/usecases/add_event.dart';
import 'package:refocus_app/features/calendar/domain/usecases/event_params.dart';
import 'package:refocus_app/features/calendar/domain/usecases/get_events.dart';

part 'gcal_event.dart';
part 'gcal_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String invalidInputFailureMessage =
    'Invalid Input - The number must be a positive integer or zero.';

@injectable
class GcalBloc extends Bloc<GcalEvent, GcalState> {
  GcalBloc({
    required this.getCalendarEntry,
    required this.addEvent,
  }) : super(GcalInitial());

  final GetEvents getCalendarEntry;
  final AddEvent addEvent;

  @override
  Stream<GcalState> mapEventToState(
    GcalEvent event,
  ) async* {
    if (event is GetCalendarEntries) {
      yield Loading();
      final failureOrEntry = await getCalendarEntry(NoParams());
      yield failureOrEntry.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (entry) => Loaded(calendarData: entry),
      );
    }
    if (event is AddCalendarEvent) {
      yield Loading();
      final failureOrSuccess = await addEvent(event.params);
      yield* failureOrSuccess.fold(
        (failure) async* {
          yield Error(message: _mapFailureToMessage(failure));
        },
        (unit) async* {
          yield Loading();
          final failureOrEntry = await getCalendarEntry(NoParams());
          yield failureOrEntry.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)),
            (entry) => Loaded(calendarData: entry),
          );
        },
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
