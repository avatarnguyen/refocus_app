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
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/datetime_stream.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';
import 'package:refocus_app/features/today/presentation/bloc/today_bloc.dart';
import 'package:refocus_app/features/today/presentation/widgets/persistent_header_delegate.dart';
import 'package:refocus_app/features/today/presentation/widgets/today_list_item.dart';
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

  @override
  void initState() {
    _dateTimeSubscription =
        _dateTimeStream.dateTimeStream.listen(_dateTimeReceived);
    super.initState();
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
            final _entry = state.todayEntries[index];
            return ListItemWidget(
              entry: _entry,
              selectedDate: _selectedDate ?? DateTime.now(),
            );
          }, childCount: state.todayEntries.length),
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
              final _entries = state.tomorrowEntries!;
              final _entry = _entries[index];
              return ListItemWidget(
                entry: _entry,
                selectedDate: 1.days.fromNow,
              );
            }, childCount: state.tomorrowEntries!.length),
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
              final _entry = state.upcomingTasks![index];
              return ListItemWidget(
                entry: _entry,
                selectedDate: 2.days.fromNow,
              );
            }, childCount: state.upcomingTasks!.length),
          ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
      ],
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
