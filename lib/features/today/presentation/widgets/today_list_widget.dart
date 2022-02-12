import 'dart:async';
import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/event_params.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/datetime_stream.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/features/today/domain/today_entry.dart';
import 'package:refocus_app/features/today/presentation/bloc/today/today_bloc.dart';
import 'package:refocus_app/features/today/presentation/widgets/change_datetime_widget.dart';
import 'package:refocus_app/features/today/presentation/widgets/list_item_widget.dart';
import 'package:refocus_app/features/today/presentation/widgets/persistent_header_delegate.dart';
import 'package:refocus_app/features/today/presentation/widgets/tomorrow_list_widget.dart';
import 'package:refocus_app/features/today/presentation/widgets/upcoming_list_widget.dart';
import 'package:refocus_app/injection.dart';

class TodayListWidget extends StatefulWidget {
  const TodayListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TodayListWidget> createState() => _TodayListWidgetState();
}

class _TodayListWidgetState extends State<TodayListWidget> {
  final _log = logger(TodayListWidget);

  final DateTimeStream _dateTimeStream = getIt<DateTimeStream>();
  StreamSubscription<DateTime>? _dateTimeSubscription;

  late DateTime _selectedDate;

  @override
  void initState() {
    _dateTimeSubscription = _dateTimeStream.dateTimeStream.listen(_dateTimeReceived);
    super.initState();
    _selectedDate = DateTime.now();
  }

  void _dateTimeReceived(DateTime newDate) {
    _selectedDate = newDate;
    context.read<TodayBloc>().add(GetCurrentDayEntries(newDate));
  }

  @override
  void dispose() {
    super.dispose();
    _dateTimeSubscription?.cancel();
  }

  Future<void> _pullToRefresh(BuildContext context) async {
    _reloadData();
    await Future<dynamic>.delayed(500.milliseconds);
  }

  void _reloadData() {
    context.read<TodayBloc>().add(GetCurrentDayEntries(_selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    return const CurrentDateListWidget();
    /* return PlatformScaffold(
      body: Platform.isIOS
          ? _buildBodyScrollView(context)
          : RefreshIndicator(
              onRefresh: () async => _pullToRefresh(context),
              child: _buildBodyScrollView(context),
            ),
    ); */
  }

  CustomScrollView _buildBodyScrollView(BuildContext context) {
    final _headerTextStyle = context.textTheme.headline5!.copyWith(
      fontWeight: FontWeight.bold,
      color: context.colorScheme.primary,
    );
    const _headerPadding = EdgeInsets.only(left: 10, bottom: 8, top: 4);

    return CustomScrollView(
      slivers: [
        if (Platform.isIOS)
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await _pullToRefresh(context);
            },
          ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 8),
          sliver: SliverPersistentHeader(
            delegate: PersistentHeaderDelegate(
              _selectedDate.isToday ? CustomDateUtils.returnDateWithDay(_selectedDate) : 'Today',
              contentPadding: _headerPadding,
              textStyle: _headerTextStyle,
            ),
          ),
        ),
        const CurrentDateListWidget(),
        // Tomorrow and Upcoming
        if (_selectedDate.isToday) ...[
          SliverPersistentHeader(
            delegate: PersistentHeaderDelegate(
              'Tomorrow',
              contentPadding: _headerPadding,
              textStyle: _headerTextStyle,
            ),
          ),
          const TomorrowListWidget(),
          SliverPersistentHeader(
            delegate: PersistentHeaderDelegate(
              'Upcoming Task',
              contentPadding: _headerPadding,
              textStyle: _headerTextStyle,
            ),
          ),
          const UpcomingListWidget(),
        ],
        const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
      ],
    );
  }

  Future<void> _changeDateTime(TodayEntry entry) async {
    final dynamic result = await showModalBottomSheet<dynamic>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      builder: (BuildContext builder) {
        return ChangeDateTimeWidget(
          startDateTime: entry.startDateTime,
          endDateTime: entry.endDateTime,
        );
      },
    );
    if (result != null && result is List) {
      _log.v(result);
      _log.v('Project / Calendar ID: ${entry.projectOrCalID}');

      final _newStartTime = result[0] as DateTime?;
      final _newEndTime = result[1] as DateTime?;

      _updateDate(entry, _newStartTime, _newEndTime);

      _reloadData();
    }
  }

  void _updateDate(TodayEntry entry, DateTime? start, DateTime? end) {
    if (entry.type == TodayEntryType.event) {
      context.read<CalendarBloc>().add(
            UpdateCalendarEvent(
              EventParams(
                eventEntry: CalendarEventEntry(
                  id: entry.id,
                  subject: entry.title ?? '',
                  colorId: entry.color,
                  calendarId: entry.projectOrCalID,
                  startDateTime: CustomDateUtils.toGoogleRFCDateTime(start!),
                  endDateTime: CustomDateUtils.toGoogleRFCDateTime(end!),
                  // timeZone: entry.startDateTime?.timeZoneName,
                  allDay: false,
                ),
              ),
            ),
          );
    } else {
      context.read<TaskBloc>().add(
            EditTaskEntryEvent(
              params: TaskParams(
                task: _returnTaskFromTodayEntry(
                  entry,
                  startDate: start,
                  endDate: end,
                ),
              ),
            ),
          );
    }
  }

  // void _markTaskAsDone(TodayEntry entry, TodayEventType type) {
  //   context.read<TaskBloc>().add(
  //         EditTaskEntryEvent(
  //           params: TaskParams(
  //             task: _returnTaskFromTodayEntry(
  //               entry,
  //               isCompleted: true,
  //             ),
  //           ),
  //         ),
  //       );
  //   setState(() {
  //     switch (type) {
  //       case TodayEventType.today:
  //         _todayList.remove(entry);
  //         break;
  //       case TodayEventType.tomorrow:
  //         _tomorrowList.remove(entry);
  //         break;
  //       case TodayEventType.upcoming:
  //         _upcomingList.remove(entry);
  //         break;
  //       // ignore: no_default_cases
  //       default:
  //         _todayList.remove(entry);
  //         _tomorrowList.remove(entry);
  //         _upcomingList.remove(entry);
  //         break;
  //     }
  //   });
  // }
  //
  // void _postponeItem(TodayEventType type, TodayEntry? entry) {
  //   if (entry != null) {
  //     final _newStartDate =
  //         entry.startDateTime != null ? entry.startDateTime! + 1.days : null;
  //     final _newDueDate =
  //         entry.dueDateTime != null ? entry.dueDateTime! + 1.days : null;
  //     context.read<TaskBloc>().add(
  //           EditTaskEntryEvent(
  //             params: TaskParams(
  //               task: _returnTaskFromTodayEntry(
  //                 entry,
  //                 startDate: _newStartDate,
  //                 dueDate: _newDueDate,
  //               ),
  //             ),
  //           ),
  //         );
  //
  //     // Handling List because Slidable item has to be remove from list
  //     setState(() {
  //       switch (type) {
  //         case TodayEventType.today:
  //           _tomorrowList.add(entry);
  //           _todayList.remove(entry);
  //
  //           break;
  //         case TodayEventType.tomorrow:
  //           _upcomingList.add(entry);
  //           _tomorrowList.remove(entry);
  //
  //           break;
  //         case TodayEventType.upcoming:
  //           _upcomingList.remove(entry);
  //           // Adding Entry Back to the list
  //           if (entry.endDateTime != null &&
  //               entry.endDateTime!.isBefore(4.days.fromNow)) {
  //             _upcomingList.add(
  //               entry.copyWith(endDateTime: entry.endDateTime! + 1.days),
  //             );
  //           } else if (entry.dueDateTime != null &&
  //               entry.dueDateTime!.isBefore(4.days.fromNow)) {
  //             _upcomingList.add(
  //               entry.copyWith(dueDateTime: entry.dueDateTime! + 1.days),
  //             );
  //           }
  //           break;
  //         // ignore: no_default_cases
  //         default:
  //           _todayList.remove(entry);
  //           _tomorrowList.remove(entry);
  //           _upcomingList.remove(entry);
  //           break;
  //       }
  //     });
  //   }
  // }

  TaskEntry _returnTaskFromTodayEntry(
    TodayEntry todayEntry, {
    bool? isCompleted,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? dueDate,
  }) {
    final _startDateTime = startDate != null && todayEntry.startDateTime != null ? startDate : todayEntry.startDateTime;

    final _endDateTime = endDate != null && todayEntry.endDateTime != null ? endDate : todayEntry.endDateTime;

    final _dueDate = dueDate != null && todayEntry.dueDateTime != null ? dueDate : todayEntry.dueDateTime;

    return TaskEntry(
      id: todayEntry.id,
      isCompleted: isCompleted ?? todayEntry.isCompleted ?? false,
      completedDate: (isCompleted != null && isCompleted) ? DateTime.now() : null,
      projectID: todayEntry.projectOrCalID!,
      calendarID: todayEntry.calendarEventID,
      colorID: todayEntry.color,
      title: todayEntry.title,
      dueDate: _dueDate,
      startDateTime: _startDateTime,
      endDateTime: _endDateTime,
      description: todayEntry.description,
      priority: todayEntry.priority,
      isHabit: todayEntry.type == TodayEntryType.habit,
    );
  }
}

class CurrentDateListWidget extends StatelessWidget {
  const CurrentDateListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodayBloc, TodayState>(
      builder: (context, state) {
        if (state is TodayLoaded) {
          final _todayList = state.todayEntries;
          return Column(
              children: _todayList
                  .map((_entry) => ListItemWidget(
                        key: Key(
                          '${_entry.id}_${_entry.startDateTime}_${_entry.dueDateTime}',
                        ),
                        entry: _entry,
                      ))
                  .toList());
          // } else if (state is TodayLoading) {
          //   return const LoadingWidget();
        }
        return const SizedBox();
      },
    );
  }
}

class DateTypeSegmentedCtrlWidget extends StatefulWidget {
  const DateTypeSegmentedCtrlWidget({Key? key}) : super(key: key);

  @override
  _DateTypeSegmentedCtrlWidgetState createState() => _DateTypeSegmentedCtrlWidgetState();
}

class _DateTypeSegmentedCtrlWidgetState extends State<DateTypeSegmentedCtrlWidget> {
  int _currentSegmentedIdx = 0;

  Widget _buildSegment(String text, int index) => Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          text,
          style: context.bodyText1.copyWith(
            color: index == _currentSegmentedIdx ? kcPrimary900 : kcPrimary100,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<int>(
      padding: const EdgeInsets.all(4),
      groupValue: _currentSegmentedIdx,
      thumbColor: kcPrimary100,
      children: {
        0: _buildSegment('Start', 0),
        1: _buildSegment('End', 1),
      },
      onValueChanged: (value) {
        if (value != null) {
          setState(() {
            _currentSegmentedIdx = value;
          });
        }
      },
    );
  }
}

class TodayListHeader extends StatelessWidget {
  const TodayListHeader({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Text(
        text,
        style: context.textTheme.headline5!.copyWith(
          fontWeight: FontWeight.bold,
          color: context.colorScheme.primary,
        ),
      ).padding(top: 8, bottom: 4, left: 8),
    );
  }
}
