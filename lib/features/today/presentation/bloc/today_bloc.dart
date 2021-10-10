import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartx/dartx.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/constants/failure_message.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/calendar/domain/usecases/get_events_between.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/date_range_query_params.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/subtask_params.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';
import 'package:refocus_app/features/task/domain/usecases/subtask/get_subtasks.dart';
import 'package:refocus_app/features/task/domain/usecases/task/get_task.dart';
import 'package:refocus_app/features/today/domain/today_entry.dart';

part 'today_event.dart';
part 'today_state.dart';

@injectable
class TodayBloc extends Bloc<TodayEvent, TodayState> {
  TodayBloc({
    required this.getEventEntry,
    required this.getTasks,
    required this.getSubTasks,
  }) : super(TodayLoading());

  final GetEventsBetween getEventEntry;
  final GetTasks getTasks;
  final GetSubTasks getSubTasks;

  @override
  Stream<TodayState> mapEventToState(
    TodayEvent event,
  ) async* {
    if (event is GetTodayEntries) {
      if (state is! TodayLoaded) {
        yield TodayLoading();
      }

      final _today = DateTime.now();
      final _tomorrow = _today + 1.days;
      final _startDateTime = CustomDateUtils.getBeginngOfDay(_today);
      final _endDateTime = CustomDateUtils.getEndOfDay(_tomorrow);

      // Get Events of Today and Tomorrow
      final _events = await getEventEntry(
        DateRangeParams(
          startDate: _startDateTime,
          endDate: _endDateTime,
        ),
      );

      final _todayTask = await getTasks(TaskParams(
        dueDate: _today,
        startDate: _today,
      ));

      final _tomorrowTask = await getTasks(TaskParams(
        dueDate: _tomorrow,
        startDate: _tomorrow,
      ));

      // Get Task of the next 7 days
      final _fromDate = CustomDateUtils.getBeginngOfDay(_today + 2.days);
      final _untilDate = CustomDateUtils.getEndOfDay(_today + 6.days);
      final _upcomingTask = await getTasks(TaskParams(
        startDate: _fromDate,
        endDate: _untilDate,
      ));

      yield* _eitherTodayLoadedOrErrorState(_events, _todayTask,
          tomorrowTask: _tomorrowTask, upcomingTask: _upcomingTask);
    } else if (event is GetTodayEntriesOfSpecificDate) {
      yield TodayLoading();

      final _startDateTime = CustomDateUtils.getBeginngOfDay(event.date);
      final _endDateTime = CustomDateUtils.getEndOfDay(event.date);
      final _events = await getEventEntry(
        DateRangeParams(
          startDate: _startDateTime,
          endDate: _endDateTime,
        ),
      );
      final _tasks = await getTasks(TaskParams(
        dueDate: event.date,
        startDate: event.date,
      ));
      yield* _eitherTodayLoadedOrErrorState(_events, _tasks);
    }
  }

  TodayEntry returnEntryFromCalendarEvent(CalendarEventEntry eventEntry) {
    return TodayEntry(
      id: eventEntry.id!,
      type: TodayEntryType.event,
      title: eventEntry.subject,
      startDateTime: eventEntry.startDateTime,
      endDateTime: eventEntry.endDateTime,
      color: eventEntry.colorId,
      projectOrCalID: eventEntry.calendarId,
    );
  }

  TodayEntry returnEntryFromTaskEntry(
      TaskEntry taskEntry, List<SubTaskEntry> subtasks) {
    return TodayEntry(
      id: taskEntry.id,
      type: TodayEntryType.task,
      title: taskEntry.title,
      startDateTime: taskEntry.startDateTime,
      endDateTime: taskEntry.endDateTime,
      dueDateTime: taskEntry.dueDate,
      projectOrCalID: taskEntry.projectID,
      calendarEventID: taskEntry.calendarID,
      color: taskEntry.colorID,
      subTaskEntries: subtasks,
    );
  }

  Stream<TodayState> _eitherTodayLoadedOrErrorState(
    Either<Failure, List<CalendarEventEntry>> calendar,
    Either<Failure, List<TaskEntry>> todayTask, {
    Either<Failure, List<TaskEntry>>? tomorrowTask,
    Either<Failure, List<TaskEntry>>? upcomingTask,
  }) async* {
    var _todayItems = <TodayEntry>[];
    var _tomorrowItems = <TodayEntry>[];
    var _upcomingItems = <TodayEntry>[];

    final _log = logger(TodayBloc);

    yield* todayTask.fold(
      (failure) async* {
        yield TodayError(_mapFailureToMessage(failure));
      },
      (tasks) async* {
        //* Handling Calendar Fold
        yield* calendar.fold((failure) async* {
          yield TodayError(_mapFailureToMessage(failure));
        }, (events) async* {
          for (final event in events) {
            final _currentEvent = returnEntryFromCalendarEvent(event);
            if (event.startDateTime != null && event.startDateTime!.isToday) {
              _todayItems.add(_currentEvent);
            } else {
              _tomorrowItems.add(_currentEvent);
            }
          }
        });

        //* Handling Today or Selected Date Tasks
        final _filteredTask = tasks.distinctBy((element) => element.id);

        for (final currentTask in _filteredTask) {
          final _fetchedSubTasks =
              await getSubTasks(SubTaskParams(taskID: currentTask.id));
          final _resultSubTask = _fetchedSubTasks.foldRight<List<SubTaskEntry>>(
              [], (entries, previous) => entries);

          _log.d('Fold Result: $_resultSubTask');

          final _entry = returnEntryFromTaskEntry(currentTask, _resultSubTask);
          _todayItems.add(_entry);
        }

        _todayItems = sortTodayEntries(_todayItems);

        if (tomorrowTask != null && upcomingTask != null) {
          //? Handling Tomorrow Tasks
          final _tomorrowTasks = tomorrowTask
              .foldRight<List<TaskEntry>>([], (entries, previous) => entries);
          for (final _task in _tomorrowTasks) {
            final _fetchedSubTasks =
                await getSubTasks(SubTaskParams(taskID: _task.id));
            final _resultSubTask = _fetchedSubTasks
                .foldRight<List<SubTaskEntry>>(
                    [], (entries, previous) => entries);
            final _todayEntry = returnEntryFromTaskEntry(_task, _resultSubTask);
            _tomorrowItems.add(_todayEntry);
          }
          _tomorrowItems = sortTodayEntries(_tomorrowItems);

          //? Handling Upcoming Tasks
          final _upcomingTask = upcomingTask
              .foldRight<List<TaskEntry>>([], (entries, previous) => entries);
          for (final _task in _upcomingTask) {
            final _fetchedSubTasks =
                await getSubTasks(SubTaskParams(taskID: _task.id));
            final _resultSubTask = _fetchedSubTasks
                .foldRight<List<SubTaskEntry>>(
                    [], (entries, previous) => entries);
            final _todayEntry = returnEntryFromTaskEntry(_task, _resultSubTask);
            _upcomingItems.add(_todayEntry);
          }
          _upcomingItems = sortTodayEntries(_upcomingItems);
        }

        yield TodayLoaded(
          todayEntries: _todayItems,
          tomorrowEntries: _tomorrowItems,
          upcomingTasks: _upcomingItems,
        );
      },
    );
  }

  List<TodayEntry> sortTodayEntries(List<TodayEntry> entries) {
    entries.sort((a, b) {
      if (a.startDateTime != null && b.startDateTime != null) {
        return a.startDateTime!.compareTo(b.startDateTime!);
      } else if (a.dueDateTime != null && b.dueDateTime != null) {
        return a.dueDateTime!.compareTo(b.dueDateTime!);
      } else {
        return a.title!.compareTo(b.title!);
      }
    });
    return entries;
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
