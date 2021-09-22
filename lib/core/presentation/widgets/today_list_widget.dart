import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:refocus_app/core/presentation/bloc/today_bloc.dart';
import 'package:refocus_app/core/presentation/widgets/persistent_header_delegate.dart';
import 'package:refocus_app/core/presentation/widgets/today_list_item.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';

class TodayListWidget extends StatefulWidget {
  const TodayListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TodayListWidget> createState() => _TodayListWidgetState();
}

class _TodayListWidgetState extends State<TodayListWidget> {
  // final _log = logger(TodayListWidget);
  Future<void> _pullToRefresh(BuildContext context) async {
    context.read<TodayBloc>()
      ..add(GetTodayEntries(DateTime.now()))
      ..add(GetTomorrowEntries(1.days.fromNow))
      ..add(GetUpcomingTask(2.days.fromNow, 5.days.fromNow));
    await Future<dynamic>.delayed(1000.milliseconds);
  }

  @override
  Widget build(BuildContext context) {
    final _headerTextStyle = context.textTheme.headline5!.copyWith(
      fontWeight: FontWeight.bold,
      color: context.theme.colorScheme.primary,
    );
    const _headerPadding = EdgeInsets.only(left: 10, bottom: 8);

    return BlocBuilder<TodayBloc, TodayState>(
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
          return const FullScreenLoadingWidget();
        } else if (state is TodayError) {
          return MessageDisplay(
            message: state.message,
          );
        } else {
          return const MessageDisplay(
            message: 'Unexpected State',
          );
        }
      },
    );
  }

  CustomScrollView _buildBodyScrollView(
      BuildContext context,
      EdgeInsets _headerPadding,
      TextStyle _headerTextStyle,
      TodayLoaded state) {
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
              'Today',
              contentPadding: _headerPadding,
              textStyle: _headerTextStyle,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final _entry = state.todayEntries[index];
            return ListItemWidget(
              title: _entry.title,
              color: _entry.color,
              type: _entry.type,
              startDateTime: _entry.startDateTime,
              endDateTime: _entry.endDateTime,
              eventID: _entry.calendarEventID,
              projectOrCal: _entry.projectOrCal,
            );
          }, childCount: state.todayEntries.length),
        ),
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
              final _entries = state.tomorrowEntries!;
              final _entry = _entries[index];
              return ListItemWidget(
                title: _entry.title,
                color: _entry.color,
                type: _entry.type,
                startDateTime: _entry.startDateTime,
                endDateTime: _entry.endDateTime,
                eventID: _entry.calendarEventID,
                projectOrCal: _entry.projectOrCal,
              );
            }, childCount: state.tomorrowEntries!.length),
          ),
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
              final _entry = state.upcomingTasks![index];
              return ListItemWidget(
                title: _entry.title,
                color: _entry.color,
                type: _entry.type,
                startDateTime: _entry.startDateTime,
                endDateTime: _entry.endDateTime,
                eventID: _entry.calendarEventID,
                projectOrCal: _entry.projectOrCal,
              );
            }, childCount: state.upcomingTasks!.length),
          ),
      ],
    );
  }

//   List<TodayEntry> _getFilteredEntries(List<TodayEntry> entries) {
//     final _fetchedEntries =
//         entries.filter((TodayEntry entry) => entry.startDateTime != null);
//     final _allDayEntries =
//         entries.filter((entry) => entry.startDateTime == null);

//     return _allDayEntries +
//         _fetchedEntries.sortedBy((entry) => entry.startDateTime!);
//   }
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
          color: context.theme.colorScheme.primary,
        ),
      ).padding(top: 8, bottom: 4, left: 8),
    );
  }
}
