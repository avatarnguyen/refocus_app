import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../constants/failure_message.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/calendar_datasource.dart';
import '../../../domain/usecases/add_event.dart';
import '../../../domain/usecases/delete_event.dart';
import '../../../domain/usecases/get_calendar_list.dart';
import '../../../domain/usecases/get_events.dart';
import '../../../domain/usecases/helpers/event_params.dart';
import '../../../domain/usecases/update_event.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

@injectable
class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc({
    required this.getCalendarEntry,
    required this.addEvent,
    required this.deleteEvent,
    required this.updateEvent,
    required this.getCalendarList,
  }) : super(GcalInitial());

  final GetEvents getCalendarEntry;
  final AddEvent addEvent;
  final DeleteEvent deleteEvent;
  final UpdateEvent updateEvent;
  final GetCalendarList getCalendarList;

  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    if (event is GetCalendarEntries) {
      yield Loading();
      await getCalendarList(NoParams());
      final failureOrEntry = await getCalendarEntry(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrEntry);
    }
    if (event is AddCalendarEvent) {
      yield Loading();
      final failureOrSuccess = await addEvent(event.params);
      print(failureOrSuccess);

      yield* failureOrSuccess.fold(
        (failure) async* {
          yield Error(message: _mapFailureToMessage(failure));
        },
        (unit) async* {
          yield Loading();
          final failureOrEntry = await getCalendarEntry(NoParams());
          yield* _eitherLoadedOrErrorState(failureOrEntry);
        },
      );
    }
    if (event is DeleteCalendarEvent) {
      yield Loading();
      final failureOrSuccess = await deleteEvent(event.params);
      yield* failureOrSuccess.fold(
        (failure) async* {
          yield Error(message: _mapFailureToMessage(failure));
        },
        (unit) async* {
          yield Loading();
          final failureOrEntry = await getCalendarEntry(NoParams());
          yield* _eitherLoadedOrErrorState(failureOrEntry);
        },
      );
    }
    if (event is UpdateCalendarEvent) {
      yield Loading();
      final failureOrSuccess = await updateEvent(event.params);
      yield* failureOrSuccess.fold(
        (failure) async* {
          yield Error(message: _mapFailureToMessage(failure));
        },
        (unit) async* {
          yield Loading();
          final failureOrEntry = await getCalendarEntry(NoParams());
          yield* _eitherLoadedOrErrorState(failureOrEntry);
        },
      );
    }
  }

  Stream<CalendarState> _eitherLoadedOrErrorState(
      Either<Failure, CalendarData> failureOrEntry) async* {
    yield failureOrEntry.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (entry) => Loaded(calendarData: entry),
    );
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
