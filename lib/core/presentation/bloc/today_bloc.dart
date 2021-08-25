import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/constants/failure_message.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/calendar/domain/usecases/get_events_between.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/date_range_query_params.dart';
import 'package:refocus_app/features/task/domain/usecases/task/get_task.dart';
import 'package:dartx/dartx.dart';
import 'package:refocus_app/features/today/domain/today_entry.dart';

part 'today_event.dart';
part 'today_state.dart';

@injectable
class TodayBloc extends Bloc<TodayEvent, TodayState> {
  TodayBloc({
    required this.getEventEntry,
    required this.getTasks,
  }) : super(TodayLoading());

  final GetEventsBetween getEventEntry;
  // final GetCalendarList getCalendarList;
  final GetTasks getTasks;

  @override
  Stream<TodayState> mapEventToState(
    TodayEvent event,
  ) async* {
    if (event is GetTodayEntries) {
      yield* _mapTodayLoadedToState(event);
    }
  }

  Stream<TodayState> _mapTodayLoadedToState(GetTodayEntries event) async* {
    try {
      final _todayItems = <TodayEntry>[];

      final _startDateTime = event.date.copyWith(hour: 0, minute: 0, second: 0);
      final _endDateTime =
          _startDateTime.copyWith(hour: 23, minute: 59, second: 59);

      final _calendarEvents = await getEventEntry(
        DateRangeParams(
          startDate: _startDateTime,
          endDate: _endDateTime,
        ),
      );
      //TODO: Get Task within specific DateTime Range
      // final _tasks = await getTasks();

      yield* _calendarEvents.fold((failure) async* {
        yield TodayError(_mapFailureToMessage(failure));
      }, (events) async* {
        print('[Today Bloc] $events');
        final _entries = events
            .map((event) => TodayEntry(
                  id: event.id!,
                  type: TodayEntryType.event,
                  title: event.subject,
                  startDateTime: event.startDateTime,
                  endDateTime: event.endDateTime,
                  calendarEventID: event.calendarId,
                  color: event.colorId,
                ))
            .toList();
        _todayItems.addAll(_entries);
        yield TodayLoaded(todayEntries: _todayItems);
      });
    } catch (e) {
      log(e.toString());
      yield const TodayError('Try to get todays entries failed');
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
