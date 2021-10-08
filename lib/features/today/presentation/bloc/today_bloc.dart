import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartx/dartx.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/constants/failure_message.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/calendar/domain/usecases/get_events_between.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/date_range_query_params.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';
import 'package:refocus_app/features/task/domain/usecases/task/get_task.dart';
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
  final GetTasks getTasks;

  @override
  Stream<TodayState> mapEventToState(
    TodayEvent event,
  ) async* {
    if (event is GetTodayEntries) {
      final _startDateTime = CustomDateUtils.getBeginngOfDay(event.date);
      final _endDateTime = CustomDateUtils.getEndOfDay(event.date);
      final _events = await getEventEntry(
        DateRangeParams(
          startDate: _startDateTime,
          endDate: _endDateTime,
        ),
      );
      final _task = await getTasks(TaskParams(
        dueDate: event.date,
        startDate: event.date,
      ));

      yield* _eitherTodayLoadedOrErrorState(_events, _task);
      // yield* _mapTodayLoadedToState(event);
    } else if (event is GetTomorrowEntries) {
      if (state is TodayLoaded) {
        final _startDateTime = CustomDateUtils.getBeginngOfDay(event.date);
        final _endDateTime = CustomDateUtils.getEndOfDay(event.date);
        final _events = await getEventEntry(
          DateRangeParams(
            startDate: _startDateTime,
            endDate: _endDateTime,
          ),
        );
        final _task = await getTasks(TaskParams(
          dueDate: event.date,
          startDate: event.date,
        ));

        final _currentState = state as TodayLoaded;

        yield* _eitherTodayLoadedOrErrorState(_events, _task,
            todayEntries: _currentState.todayEntries);
      }
    } else if (event is GetUpcomingTask) {
      if (state is TodayLoaded) {
        final _items = <TodayEntry>[];

        final _startDate = event.startDate;
        final _endDate = event.endDate;

        final _upcomingTask = await getTasks(
            TaskParams(startDate: _startDate, endDate: _endDate));

        yield* _upcomingTask.fold((failure) async* {
          yield TodayError(_mapFailureToMessage(failure));
        }, (tasks) async* {
          final _filteredTask = tasks.distinctBy((element) => element.id);
          final _taskEntries = _filteredTask
              .map((task) => TodayEntry(
                    id: task.id,
                    type: TodayEntryType.task,
                    title: task.title,
                    startDateTime: task.startDateTime,
                    endDateTime: task.endDateTime,
                    dueDateTime: task.dueDate,
                    color: task.colorID,
                  ))
              .toList();
          _items.addAll(_taskEntries);

          final _currentState = state as TodayLoaded;

          yield TodayLoaded(
            todayEntries: _currentState.todayEntries,
            tomorrowEntries: _currentState.tomorrowEntries,
            upcomingTasks: _items,
          );
        });
      }
    }
  }

  Stream<TodayState> _eitherTodayLoadedOrErrorState(
      Either<Failure, List<CalendarEventEntry>> calendar,
      Either<Failure, List<TaskEntry>> tasks,
      {List<TodayEntry>? todayEntries}) async* {
    final _items = <TodayEntry>[];

    yield* tasks.fold(
      (failure) async* {
        yield TodayError(_mapFailureToMessage(failure));
      },
      (tasks) async* {
        // Calendar Fold
        yield* calendar.fold((failure) async* {
          yield TodayError(_mapFailureToMessage(failure));
        }, (events) async* {
          // print('[Today Bloc] $events');
          final _entries = events
              .map((event) => TodayEntry(
                    id: event.id!,
                    type: TodayEntryType.event,
                    title: event.subject,
                    startDateTime: event.startDateTime,
                    endDateTime: event.endDateTime,
                    // calendarEventID: event.calendarId,
                    color: event.colorId,
                    projectOrCal: event.calendarId,
                  ))
              .toList();
          _items.addAll(_entries);
        });
        final _filteredTask = tasks.distinctBy((element) => element.id);
        final _taskEntries = _filteredTask
            .map(
              (task) => TodayEntry(
                id: task.id,
                type: TodayEntryType.task,
                title: task.title,
                startDateTime:
                    (task.startDateTime != null) ? task.startDateTime! : null,
                endDateTime: task.endDateTime,
                dueDateTime: task.dueDate,
                projectOrCal: task.projectID,
                calendarEventID: task.calendarID,
                color: task.colorID,
              ),
            )
            .toList();
        _items.addAll(_taskEntries);
        if (todayEntries != null) {
          yield TodayLoaded(
              todayEntries: todayEntries, tomorrowEntries: _items);
        } else {
          yield TodayLoaded(todayEntries: _items);
        }
      },
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
