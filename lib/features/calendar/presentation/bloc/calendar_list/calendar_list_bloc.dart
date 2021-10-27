import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/calendar_params.dart';
import 'package:refocus_app/features/calendar/domain/usecases/update_calendar_list.dart';

import '../../../../../../constants/failure_message.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/calendar_entry.dart';
import '../../../domain/usecases/get_calendar_list.dart';

part 'calendar_list_event.dart';
part 'calendar_list_state.dart';

@injectable
class CalendarListBloc extends Bloc<CalendarListEvent, CalendarListState> {
  CalendarListBloc({
    required this.getCalendarList,
    required this.updateCalendarList,
  }) : super(CalendarListInitial());

  final GetCalendarList getCalendarList;
  final UpdateCalendarList updateCalendarList;

  @override
  Stream<CalendarListState> mapEventToState(
    CalendarListEvent event,
  ) async* {
    if (event is GetCalendarListEvent) {
      log('Get Calendar List');
      yield Loading();
      final failureOrEntry = await getCalendarList(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrEntry);
    }
    if (event is UpdateCalendarEvent) {
      log('Update Calendar List');
      // yield Loading();
      await updateCalendarList(event.params);
      // final failureOrUpdated = await updateCalendarList(event.params);
      // yield* failureOrUpdated.fold((failure) async* {
      //   yield Error(message: _mapFailureToMessage(failure));
      // }, (updated) async* {
      //   yield Loading();
      //   final failureOrEntry = await getCalendarList(NoParams());
      //   yield* _eitherLoadedOrErrorState(failureOrEntry);
      // });
    }
  }

  Stream<CalendarListState> _eitherLoadedOrErrorState(
      Either<Failure, List<CalendarEntry>> failureOrEntry) async* {
    yield failureOrEntry.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (entries) => Loaded(calendarList: entries),
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
