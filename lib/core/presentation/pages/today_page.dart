import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:refocus_app/core/presentation/bloc/today_bloc.dart';
import 'package:refocus_app/core/presentation/widgets/today_list_item.dart';
import 'package:refocus_app/core/util/helpers/logging.dart' as custom_log;
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';
import 'package:refocus_app/features/today/domain/today_entry.dart';
import 'package:refocus_app/injection.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key, required this.changePage}) : super(key: key);

  final VoidCallback changePage;

  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  final log = custom_log.logger(TodayPage);

  bool showMonthView = false;

  String returnDate(DateTime date) {
    return DateFormat.yMMMMEEEEd().format(date);
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return PlatformScaffold(
      backgroundColor: kcLightBackground,
      body: [
        [
          [
            [
              const Icon(
                Icons.menu,
                size: 28,
                color: kcPrimary500,
              ).ripple().gestures(onTap: () {
                widget.changePage();
              }),
              horizontalSpaceRegular,
              const Icon(
                Icons.search,
                size: 26,
                color: kcPrimary500,
              ).ripple().gestures(onTap: () {
                widget.changePage();
              }),
            ].toRow(),
            [
              const Icon(
                Icons.inbox,
                size: 28,
                color: kcPrimary500,
              ).ripple().gestures(onTap: () {}),
              horizontalSpaceRegular,
              const Icon(
                Icons.person,
                size: 28,
                color: kcPrimary500,
              ).ripple().gestures(onTap: () {})
            ].toRow(),
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
          verticalSpaceRegular,
          [
            [
              PlatformText(
                _getGreeting(),
                overflow: TextOverflow.fade,
                style: context.textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              //TODO: Fetch Weather Info here
              verticalSpaceSmall,
              PlatformText(
                returnDate(today),
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: true,
                textScaleFactor: context.mediaQuery.textScaleFactor,
                style: context.textTheme.bodyText2!.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
          ].toRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
          )
        ]
            .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
            .parent(headerTodayContainer),

        verticalSpaceRegular,
        //* Body: List View
        BlocProvider<TodayBloc>(
          create: (context) => getIt<TodayBloc>()
            ..add(GetTodayEntries(DateTime.now()))
            ..add(GetTomorrowEntries(1.days.fromNow))
            ..add(GetUpcomingTask(2.days.fromNow, 5.days.fromNow)),
          child: const Expanded(
            child: TodayListWidget(),
          ),
        ),
      ]
          .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
          .parent(({required child}) => todayPage(context, child: child)),
    );
  }

  String _getGreeting() {
    final _currentHour = DateTime.now().hour;
    if (_currentHour.isGreaterThan(11) && _currentHour.isLowerThan(18)) {
      return 'Good Afternoon!';
    } else if (_currentHour.isGreaterThan(5) && _currentHour.isLowerThan(12)) {
      return 'Good Morning!';
    } else if (_currentHour.isGreaterThan(17) && _currentHour.isLowerThan(22)) {
      return 'Good Evening!';
    } else {
      return 'Good Night!';
    }
  }
}

class TodayListWidget extends StatefulWidget {
  const TodayListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TodayListWidget> createState() => _TodayListWidgetState();
}

class _TodayListWidgetState extends State<TodayListWidget> {
  final _log = logger(TodayListWidget);

  var _entries = <TodayEntry>[];

  Future<void> _pullToRefresh(BuildContext context) async {
    context.read<TodayBloc>()
      ..add(GetTodayEntries(DateTime.now()))
      ..add(GetTomorrowEntries(1.days.fromNow))
      ..add(GetUpcomingTask(2.days.fromNow, 5.days.fromNow));
    await Future<dynamic>.delayed(1000.milliseconds);
  }

  var _todayLength = 0;
  var _tomorrowLength = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodayBloc, TodayState>(
      builder: (context, state) {
        if (state is TodayLoaded) {
          _log.i(
              'TodayLoaded: ${state.todayEntries}, ${state.tomorrowEntries}');
          _log.i('Upcoming Task: ${state.upcomingTasks}');

          _entries.clear();
          _entries
            ..addAll(state.todayEntries)
            ..addAll(state.tomorrowEntries ?? [])
            ..addAll(state.upcomingTasks ?? []);
          if (_todayLength == 0) {
            _todayLength = state.todayEntries.length;
          }
          if (_tomorrowLength == 0 && state.tomorrowEntries != null) {
            _tomorrowLength = state.tomorrowEntries!.length;
          }

          _log.d(_entries.length);

          return RefreshIndicator(
            onRefresh: () async => _pullToRefresh(context),
            child: ListView.builder(
              itemCount: _entries.length + 3, // add 3 header
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return const TodayListHeader(text: 'Today');
                }
                if (index == (_todayLength + 1)) {
                  return const TodayListHeader(text: 'Tomorrow');
                }
                if (index == (_todayLength + _tomorrowLength + 2)) {
                  return const TodayListHeader(text: 'Upcoming Tasks');
                }
                index = (index < _todayLength + 1)
                    ? index - 1
                    : (index < (_todayLength + _tomorrowLength + 2))
                        ? index - 2
                        : index - 3;
                // _log.i('Current Index: $index');
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
              },
            ),
          );

          // return const FullScreenLoadingWidget();
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

  List<TodayEntry> _getFilteredEntries(List<TodayEntry> entries) {
    final _fetchedEntries =
        entries.filter((TodayEntry entry) => entry.startDateTime != null);
    final _allDayEntries =
        entries.filter((entry) => entry.startDateTime == null);

    return _allDayEntries +
        _fetchedEntries.sortedBy((entry) => entry.startDateTime!);
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
          color: context.theme.colorScheme.primary,
        ),
      ).padding(top: 8, bottom: 4, left: 8),
    );
  }
}
