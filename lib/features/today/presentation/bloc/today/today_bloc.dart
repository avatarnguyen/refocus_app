import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/constants/failure_message.dart';
import 'package:refocus_app/core/aws_stream.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/enum/today_event_type.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/calendar/domain/usecases/calendar_event/get_events_between.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/date_range_query_params.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';
import 'package:refocus_app/features/task/domain/usecases/subtask/get_subtasks.dart';
import 'package:refocus_app/features/task/domain/usecases/task/get_task.dart';
import 'package:refocus_app/features/today/domain/today_entry.dart';

part 'today_event.dart';
part 'today_state.dart';

@injectable
class TodayBloc extends Bloc<TodayEvent, TodayState> {
  TodayBloc({
    required GetEventsBetween getEventEntry,
    required GetTasks getTasks,
    required GetSubTasks getSubTasks,
    required AwsStream dataStream,
  })  : _getEventEntry = getEventEntry,
        _getTasks = getTasks,
        _getSubTasks = getSubTasks,
        _dataStream = dataStream,
        super(TodayLoading()) {
    on<GetCurrentDayEntries>(_onGetCurrentDayEntries);
    on<UpdateTaskEntries>(_onUpdateTaskEntries);
  }

  final GetEventsBetween _getEventEntry;
  final GetTasks _getTasks;
  final GetSubTasks _getSubTasks;
  final AwsStream _dataStream;

  Future<void> _onGetCurrentDayEntries(
      GetCurrentDayEntries event, Emitter<TodayState> emit) async {
    emit(TodayLoading());

    final _today = DateTime.now();
    final _startDateTime = CustomDateUtils.getBeginngOfDay(_today);
    final _endDateTime = CustomDateUtils.getEndOfDay(_today);

    final _events = await _getEventEntry(
      DateRangeParams(
        startDate: _startDateTime,
        endDate: _endDateTime,
      ),
    );

    final _todayTask = await _getTasks(TaskParams(
      dueDate: _today,
      startDate: _today,
    ));
    _events.fold((failure) => emit(TodayError(_mapFailureToMessage(failure))),
        (_eventResults) {
      return _todayTask
          .fold((failure) => emit(TodayError(_mapFailureToMessage(failure))),
              (_taskResults) {
        final _todayTask = _taskResults
            .map((task) => returnEntryFromTaskEntry(task, []))
            .toList();
        final _todayEvents =
            _eventResults.map(returnEntryFromCalendarEvent).toList();
        final _todayEntries = sortTodayEntries(_todayEvents + _todayTask);
        return emit(TodayLoaded(todayEntries: _todayEntries));
      });
    });
  }

  void _onUpdateTaskEntries(
      UpdateTaskEntries event, Emitter<TodayState> emit) {}

  TodayEntry returnEntryFromCalendarEvent(CalendarEventEntry eventEntry) {
    print('[TodayBloc] Calendar Event: ${eventEntry.toString()}');
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
    TaskEntry taskEntry,
    List<SubTaskEntry> subtasks,
  ) {
    var _subTaskCompleted = <SubTaskEntry>[];
    if (subtasks.isNotEmpty) {
      _subTaskCompleted =
          subtasks.filter((element) => element.isCompleted == false).toList();
    }

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
      subTaskEntries: _subTaskCompleted,
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

  // void _observerTodos() {
  //   final todoStream = dataStream.getTaskStream;
  //   todoStream.listen((dynamic _) {
  //     if (state is TodayLoaded) {
  //       final _currentState = state as TodayLoaded;
  //       if (_currentState.tomorrowEntries != null &&
  //           _currentState.upcomingTasks != null) {
  //       } else {}
  //     }
  //   });
  // }

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

  // @override
  // Stream<TodayState> mapEventToState(
  //   TodayEvent event,
  // ) async* {
  //   if (event is GetTodayEntries) {
  //     if (state is! TodayLoaded) {
  //       yield TodayLoading();
  //     }
  //
  //     final _today = DateTime.now();
  //     final _tomorrow = _today + 1.days;
  //     final _startDateTime = CustomDateUtils.getBeginngOfDay(_today);
  //     final _endDateTime = CustomDateUtils.getEndOfDay(_tomorrow);
  //
  //     // Get Events of Today and Tomorrow
  //
  //     final _tomorrowTask = await getTasks(TaskParams(
  //       dueDate: _tomorrow,
  //       startDate: _tomorrow,
  //     ));
  //
  //     // Get Task of the next 7 days
  //     final _fromDate = CustomDateUtils.getBeginngOfDay(_today + 2.days);
  //     final _untilDate = CustomDateUtils.getEndOfDay(_today + 6.days);
  //     final _upcomingTask = await getTasks(TaskParams(
  //       startDate: _fromDate,
  //       endDate: _untilDate,
  //     ));
  //
  //     yield* _eitherTodayLoadedOrErrorState(_events, _todayTask,
  //         tomorrowTask: _tomorrowTask, upcomingTask: _upcomingTask);
  //     //* --------------------------------
  //   } else if (event is GetCurrentDayEntries) {
  //     //* Get Event and Task of 1 specific date
  //     yield TodayLoading();
  //
  //     final _startDateTime = CustomDateUtils.getBeginngOfDay(event.date);
  //     final _endDateTime = CustomDateUtils.getEndOfDay(event.date);
  //     final _events = await getEventEntry(
  //       DateRangeParams(
  //         startDate: _startDateTime,
  //         endDate: _endDateTime,
  //       ),
  //     );
  //     final _tasks = await getTasks(TaskParams(
  //       dueDate: event.date,
  //       startDate: event.date,
  //     ));
  //     yield* _eitherTodayLoadedOrErrorState(_events, _tasks,
  //         selectedDate: event.date);
  //
  //     //* --------------------------------
  //   } else if (event is UpdateTaskEntries) {
  //     //* Only Update certain section
  //     if (state is TodayLoaded) {
  //       switch (event.eventType) {
  //         case TodayEventType.today:
  //           final _today = DateTime.now();
  //           final _todayTask = await getTasks(TaskParams(
  //             dueDate: _today,
  //             startDate: _today,
  //           ));
  //           yield* _eitherTaskLoadedOrErrorState(
  //               _todayTask, state, event.eventType);
  //           break;
  //         case TodayEventType.tomorrow:
  //           final _tomorrow = DateTime.now() + 1.days;
  //           final _tomorrowTask = await getTasks(TaskParams(
  //             dueDate: _tomorrow,
  //             startDate: _tomorrow,
  //           ));
  //           yield* _eitherTaskLoadedOrErrorState(
  //               _tomorrowTask, state, event.eventType);
  //           break;
  //         case TodayEventType.specificDate:
  //           //Reload Task in selected Date
  //           final _selectedDate = event.date;
  //           final _tasks = await getTasks(TaskParams(
  //             dueDate: _selectedDate,
  //             startDate: _selectedDate,
  //           ));
  //           yield* _eitherTaskLoadedOrErrorState(
  //               _tasks, state, event.eventType);
  //           break;
  //         // ignore: no_default_cases
  //         default:
  //           // Reload Upcoming Tasks
  //           final _today = DateTime.now();
  //
  //           final _fromDate = CustomDateUtils.getBeginngOfDay(_today + 2.days);
  //           final _untilDate = CustomDateUtils.getEndOfDay(_today + 6.days);
  //           final _upcomingTask = await getTasks(TaskParams(
  //             startDate: _fromDate,
  //             endDate: _untilDate,
  //           ));
  //           yield* _eitherTaskLoadedOrErrorState(
  //               _upcomingTask, state, TodayEventType.upcoming);
  //
  //           break;
  //       }
  //     }
  //   }
  // }
  //
  // Stream<TodayState> _eitherTaskLoadedOrErrorState(
  //     Either<Failure, List<TaskEntry>> failureOrEntry,
  //     TodayState currentState,
  //     TodayEventType type) async* {
  //   //Get previous Entries
  //   final _currentEntries =
  //       (type == TodayEventType.today || type == TodayEventType.specificDate)
  //           ? (currentState as TodayLoaded).todayEntries
  //           : type == TodayEventType.tomorrow
  //               ? (currentState as TodayLoaded).tomorrowEntries
  //               : (currentState as TodayLoaded).upcomingTasks;
  //   final _newEntries = _currentEntries!
  //       .filter((element) => element.type == TodayEntryType.event)
  //       .toList();
  //
  //   yield* failureOrEntry.fold(
  //     (failure) async* {
  //       yield TodayError(_mapFailureToMessage(failure));
  //     },
  //     (entries) async* {
  //       for (final currentTask in entries) {
  //         final _fetchedSubTasks =
  //             await getSubTasks(SubTaskParams(taskID: currentTask.id));
  //         final _resultSubTask = _fetchedSubTasks.foldRight<List<SubTaskEntry>>(
  //             [], (entries, previous) => entries);
  //
  //         final _entry = returnEntryFromTaskEntry(currentTask, _resultSubTask);
  //         _newEntries.add(_entry);
  //       }
  //
  //       print('Current Type: $type');
  //
  //       yield TodayLoaded(
  //         todayEntries: (type == TodayEventType.today ||
  //                 type == TodayEventType.specificDate)
  //             ? _newEntries
  //             : currentState.todayEntries,
  //         tomorrowEntries: type == TodayEventType.tomorrow
  //             ? _newEntries
  //             : currentState.tomorrowEntries,
  //         upcomingTasks: type == TodayEventType.upcoming
  //             ? _newEntries
  //             : currentState.upcomingTasks,
  //       );
  //     },
  //   );
  // }
  // Stream<TodayState> _eitherTodayLoadedOrErrorState(
  //   Either<Failure, List<CalendarEventEntry>> calendar,
  //   Either<Failure, List<TaskEntry>> todayTask, {
  //   DateTime? selectedDate,
  //   Either<Failure, List<TaskEntry>>? tomorrowTask,
  //   Either<Failure, List<TaskEntry>>? upcomingTask,
  // }) async* {
  //   var _todayItems = <TodayEntry>[];
  //   var _tomorrowItems = <TodayEntry>[];
  //   var _upcomingItems = <TodayEntry>[];
  //
  //   final _log = logger(TodayBloc);
  //
  //   yield* todayTask.fold(
  //     (failure) async* {
  //       yield TodayError(_mapFailureToMessage(failure));
  //     },
  //     (tasks) async* {
  //       //* Handling Calendar Fold
  //       yield* calendar.fold((failure) async* {
  //         yield TodayError(_mapFailureToMessage(failure));
  //       }, (events) async* {
  //         //*Adding Calendar Events
  //         for (final event in events) {
  //           final _currentEvent = returnEntryFromCalendarEvent(event);
  //           if (selectedDate != null) {
  //             //Adding all calendar events to [_todayItems]
  //             _todayItems.add(_currentEvent);
  //           } else {
  //             // Determine whether start date is today or tomorrow
  //             if (event.startDateTime != null && event.startDateTime!.isToday) {
  //               _todayItems.add(_currentEvent);
  //             } else if (event.startDate != null && event.startDate!.isToday) {
  //               _todayItems.add(_currentEvent);
  //             } else {
  //               _tomorrowItems.add(_currentEvent);
  //             }
  //           }
  //         }
  //       });
  //
  //       //* Handling Today or Selected Date Tasks
  //       final _filteredTask = tasks.distinctBy((element) => element.id);
  //
  //       for (final currentTask in _filteredTask) {
  //         final _fetchedSubTasks =
  //             await getSubTasks(SubTaskParams(taskID: currentTask.id));
  //         final _resultSubTask = _fetchedSubTasks.foldRight<List<SubTaskEntry>>(
  //             [], (entries, previous) => entries);
  //
  //         _log.d('Fold Result: $_resultSubTask');
  //
  //         final _entry = returnEntryFromTaskEntry(currentTask, _resultSubTask);
  //         _todayItems.add(_entry);
  //       }
  //
  //       _todayItems = sortTodayEntries(_todayItems);
  //
  //       if (tomorrowTask != null && upcomingTask != null) {
  //         //? Handling Tomorrow Tasks
  //         final _tomorrowTasks = tomorrowTask
  //             .foldRight<List<TaskEntry>>([], (entries, previous) => entries);
  //         final _filteredTmrTask =
  //             _tomorrowTasks.distinctBy((element) => element.id);
  //         for (final _task in _filteredTmrTask) {
  //           final _fetchedSubTasks =
  //               await getSubTasks(SubTaskParams(taskID: _task.id));
  //           final _resultSubTask = _fetchedSubTasks
  //               .foldRight<List<SubTaskEntry>>(
  //                   [], (entries, previous) => entries);
  //           final _todayEntry = returnEntryFromTaskEntry(_task, _resultSubTask);
  //           _tomorrowItems.add(_todayEntry);
  //         }
  //         _tomorrowItems = sortTodayEntries(_tomorrowItems);
  //
  //         //? Handling Upcoming Tasks
  //         final _upcomingTask = upcomingTask
  //             .foldRight<List<TaskEntry>>([], (entries, previous) => entries);
  //         final _filteredUpcTask =
  //             _upcomingTask.distinctBy((element) => element.id);
  //
  //         for (final _task in _filteredUpcTask) {
  //           final _fetchedSubTasks =
  //               await getSubTasks(SubTaskParams(taskID: _task.id));
  //           final _resultSubTask = _fetchedSubTasks
  //               .foldRight<List<SubTaskEntry>>(
  //                   [], (entries, previous) => entries);
  //           final _todayEntry = returnEntryFromTaskEntry(_task, _resultSubTask);
  //           _upcomingItems.add(_todayEntry);
  //         }
  //         _upcomingItems = sortTodayEntries(_upcomingItems);
  //       }
  //
  //       yield TodayLoaded(
  //         todayEntries: _todayItems,
  //         tomorrowEntries: selectedDate != null ? null : _tomorrowItems,
  //         upcomingTasks: selectedDate != null ? null : _upcomingItems,
  //       );
  //     },
  //   );
  // }
  //
}
