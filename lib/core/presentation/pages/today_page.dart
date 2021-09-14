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
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';
import 'package:refocus_app/injection.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key}) : super(key: key);

  // final VoidCallback onDrawerSelected;

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
            InkWell(
              onTap: () {},
              child: const Icon(
                Icons.menu,
                size: 26,
                color: kcPrimary500,
              ),
            ),
            InkWell(
              onTap: () async {},
              child: const Icon(
                Icons.inbox,
                size: 26,
                color: kcPrimary500,
              ),
            ),
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
            InkWell(
              onTap: () {},
              child: Icon(
                Icons.calendar_view_month_rounded,
                size: 24,
                color: showMonthView ? kcPrimary600 : kcPrimary500,
              )
                  .decorated(
                    color: showMonthView ? kcPrimary200 : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  )
                  .constrained(height: 32, width: 32),
            ),
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
            ..add(
              GetTodayEntries(DateTime.now()),
            ),
          child: const Expanded(
            child: TodayListWidget(),
          ),
        ),
      ]
          .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
          .parent(todayPage),
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

class TodayListWidget extends StatelessWidget {
  const TodayListWidget({
    Key? key,
  }) : super(key: key);

  Future<void> _pullToRefresh(BuildContext context) async {
    context.read<TodayBloc>().add(GetTodayEntries(DateTime.now()));
    await Future<dynamic>.delayed(1000.milliseconds);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodayBloc, TodayState>(
      builder: (context, state) {
        if (state is TodayLoaded) {
          final _todayEntries = state.todayEntries;
          final _fetchedEntries =
              _todayEntries.filter((entry) => entry.startDateTime != null);
          final _allDayEntries =
              _todayEntries.filter((entry) => entry.startDateTime == null);

          final _entries = _allDayEntries +
              _fetchedEntries.sortedBy((entry) => entry.startDateTime!);

          return RefreshIndicator(
            onRefresh: () async => _pullToRefresh(context),
            child: ListView.builder(
              // padding: const EdgeInsets.only(right: 4),
              itemCount: _entries.length + 2,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return const TodayListHeader(text: 'Today');
                }

                if (index == (_entries.length + 1)) {
                  return const TodayListHeader(text: 'Tomorrow');
                }

                index -= 1;
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
        } else if (state is TodayLoading) {
          return const LoadingWidget();
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
        style: context.textTheme.headline4!.copyWith(
          fontWeight: FontWeight.bold,
          color: context.theme.colorScheme.primary,
        ),
      ).padding(top: 4, bottom: 4, left: 8),
    );
  }
}
