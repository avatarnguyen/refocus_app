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
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/enum/today_event_type.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/datetime_stream.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/features/today/domain/today_entry.dart';
import 'package:refocus_app/features/today/presentation/bloc/today_bloc.dart';
import 'package:refocus_app/features/today/presentation/widgets/list_item_widget.dart';
import 'package:refocus_app/features/today/presentation/widgets/persistent_header_delegate.dart';
import 'package:refocus_app/injection.dart';

class TodayListWidget extends StatefulWidget {
  const TodayListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TodayListWidget> createState() => _TodayListWidgetState();
}

class _TodayListWidgetState extends State<TodayListWidget> {
  final DateTimeStream _dateTimeStream = getIt<DateTimeStream>();
  StreamSubscription<DateTime>? _dateTimeSubscription;

  DateTime? _selectedDate;

  late List<TodayEntry> _todayList;
  late List<TodayEntry> _tomorrowList;
  late List<TodayEntry> _upcomingList;

  @override
  void initState() {
    _dateTimeSubscription =
        _dateTimeStream.dateTimeStream.listen(_dateTimeReceived);
    super.initState();

    _todayList = [];
    _tomorrowList = [];
    _upcomingList = [];
  }

  void _dateTimeReceived(DateTime newDate) {
    // print('Date Time Received $newDate');
    if (newDate.isToday) {
      if (_selectedDate != null) {
        _selectedDate = null;
        context.read<TodayBloc>().add(const GetTodayEntries());
      }
    } else {
      _selectedDate = newDate;
      context
          .read<TodayBloc>()
          .add(GetTodayEntriesOfSpecificDate(_selectedDate!));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dateTimeSubscription?.cancel();
  }

  // final _log = logger(TodayListWidget);
  Future<void> _pullToRefresh(BuildContext context) async {
    if (_selectedDate != null && _selectedDate!.isToday == false) {
      context
          .read<TodayBloc>()
          .add(GetTodayEntriesOfSpecificDate(_selectedDate!));
    } else {
      context.read<TodayBloc>().add(const GetTodayEntries());
    }
    await Future<dynamic>.delayed(1000.milliseconds);
  }

  @override
  Widget build(BuildContext context) {
    final _headerTextStyle = context.textTheme.headline5!.copyWith(
      fontWeight: FontWeight.bold,
      color: context.colorScheme.primary,
    );
    const _headerPadding = EdgeInsets.only(left: 10, bottom: 8, top: 4);

    return PlatformScaffold(
      body: BlocBuilder<TodayBloc, TodayState>(
        builder: (context, state) {
          if (state is TodayLoaded) {
            return Platform.isIOS
                ? _buildBodyScrollView(
                    context, _headerPadding, _headerTextStyle, state)
                : RefreshIndicator(
                    onRefresh: () async => _pullToRefresh(context),
                    child: _buildBodyScrollView(
                        context, _headerPadding, _headerTextStyle, state),
                  );
          } else if (state is TodayLoading) {
            return const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 32),
                child: progressIndicator,
              ),
            );
          } else if (state is TodayError) {
            return MessageDisplay(message: state.message);
          } else {
            return const MessageDisplay(message: 'Unexpected State');
          }
        },
      ),
    );
  }

  CustomScrollView _buildBodyScrollView(
      BuildContext context,
      EdgeInsets _headerPadding,
      TextStyle _headerTextStyle,
      TodayLoaded state) {
    _todayList = state.todayEntries;
    _tomorrowList = state.tomorrowEntries ?? [];
    _upcomingList = state.upcomingTasks ?? [];
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
              _selectedDate != null
                  ? CustomDateUtils.returnDateWithDay(_selectedDate!)
                  : 'Today',
              contentPadding: _headerPadding,
              textStyle: _headerTextStyle,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final _entry = _todayList[index];
            return ListItemWidget(
              key: Key(_entry.id),
              entry: _entry,
              selectedDate: _selectedDate ?? DateTime.now(),
              postponeItem: () => _postponeItem(TodayEventType.today, _entry),
              markItemAsDone: () =>
                  _markTaskAsDone(_entry, TodayEventType.today),
            );
          }, childCount: _todayList.length),
        ),
        if (_selectedDate == null)
          SliverPersistentHeader(
            delegate: PersistentHeaderDelegate(
              'Tomorrow',
              contentPadding: _headerPadding,
              textStyle: _headerTextStyle,
            ),
          ),
        if (state.tomorrowEntries != null)
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final _entry = _tomorrowList[index];
              return ListItemWidget(
                key: Key(_entry.id),
                entry: _entry,
                selectedDate: 1.days.fromNow,
                postponeItem: () =>
                    _postponeItem(TodayEventType.tomorrow, _entry),
                markItemAsDone: () =>
                    _markTaskAsDone(_entry, TodayEventType.tomorrow),
              );
            }, childCount: _tomorrowList.length),
          ),
        if (_selectedDate == null)
          SliverPersistentHeader(
            delegate: PersistentHeaderDelegate(
              'Upcoming Task',
              contentPadding: _headerPadding,
              textStyle: _headerTextStyle,
            ),
          ),
        if (state.upcomingTasks != null)
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final _entry = _upcomingList[index];
              return ListItemWidget(
                key: Key(
                    '${_entry.id}_${_entry.endDateTime}_${_entry.dueDateTime}'),
                entry: _entry,
                selectedDate: 2.days.fromNow,
                markItemAsDone: () =>
                    _markTaskAsDone(_entry, TodayEventType.upcoming),
                postponeItem: () =>
                    _postponeItem(TodayEventType.upcoming, _entry),
              );
            }, childCount: _upcomingList.length),
          ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
      ],
    );
  }

  void _markTaskAsDone(TodayEntry entry, TodayEventType type) {
    context.read<TaskBloc>().add(EditTaskEntryEvent(
          params: TaskParams(
              task: _returnTaskFromTodayEntry(
            entry,
            isCompleted: true,
          )),
        ));
    context.read<TodayBloc>().add(const GetTodayEntries());
  }

  void _deleteItem(TodayEventType type) {
    switch (type) {
      case TodayEventType.today:
        break;
      case TodayEventType.tomorrow:
        break;
      case TodayEventType.upcoming:
        break;
      default:
        break;
    }
  }

  void _postponeItem(TodayEventType type, TodayEntry? entry) {
    switch (type) {
      case TodayEventType.today:
        if (entry != null) {
          _tomorrowList.add(entry);
          _todayList.remove(entry);
        }
        break;
      case TodayEventType.tomorrow:
        if (entry != null) {
          _upcomingList.add(entry);
          _tomorrowList.remove(entry);
        }
        break;
      case TodayEventType.upcoming:
        if (entry != null) {
          _upcomingList.remove(entry);
          if (entry.endDateTime != null &&
              entry.endDateTime!.isBefore(4.days.fromNow)) {
            _upcomingList.add(entry.copyWith(
              endDateTime: entry.endDateTime! + 1.days,
            ));
          }
        }
        break;
      default:
        if (entry != null) {
          _upcomingList.removeWhere((element) => element.id == entry.id);
        }
        break;
    }
    // if (entry != null) {
    //   final _currentDate =
    //       entry.startDateTime ?? entry.dueDateTime ?? DateTime.now();
    //   final _newDate = _currentDate + 1.days;
    //   context.read<TaskBloc>().add(EditTaskEntryEvent(
    //         params: TaskParams(
    //           task: _returnTaskFromTodayEntry(entry, newDate: _newDate),
    //         ),
    //       ));
    // }

    setState(() {});
  }

  TaskEntry _returnTaskFromTodayEntry(TodayEntry todayEntry,
      {bool? isCompleted, DateTime? newDate}) {
    final _startDateTime = newDate != null && todayEntry.startDateTime != null
        ? todayEntry.startDateTime!.copyWith(
            day: newDate.day,
            month: newDate.month,
            year: newDate.year,
          )
        : todayEntry.startDateTime;

    final _endDateTime = newDate != null && todayEntry.endDateTime != null
        ? todayEntry.endDateTime!.copyWith(
            day: newDate.day,
            month: newDate.month,
            year: newDate.year,
          )
        : todayEntry.endDateTime;

    final _dueDate = newDate != null && todayEntry.dueDateTime != null
        ? todayEntry.dueDateTime!.copyWith(
            day: newDate.day,
            month: newDate.month,
            year: newDate.year,
          )
        : todayEntry.dueDateTime;

    return TaskEntry(
      id: todayEntry.id,
      isCompleted: isCompleted ?? todayEntry.isCompleted ?? false,
      completedDate:
          (isCompleted != null && isCompleted) ? DateTime.now() : null,
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
