import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:refocus_app/core/presentation/bloc/today_bloc.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/helpers/logging.dart' as custom_log;
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
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
                  // fontSize: kSmallTextSize,
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
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).parent(page),
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
              itemCount: _entries.length,
              itemBuilder: (BuildContext context, int index) {
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

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    Key? key,
    this.title,
    required this.type,
    this.startDateTime,
    this.endDateTime,
    this.color,
    this.eventID,
    this.taskID,
    this.projectOrCal,
  }) : super(key: key);

  final String? title;
  final TodayEntryType type;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final String? color;
  final String? eventID;
  final String? taskID;
  final String? projectOrCal;

  @override
  Widget build(BuildContext context) {
    final _isEvent = type == TodayEntryType.event;
    final _isPassed =
        endDateTime != null && endDateTime!.compareTo(DateTime.now()) <= 0;

    final _color = _isPassed
        ? Colors.grey.shade600
        : StyleUtils.getColorFromString(color ?? '#115FFB');
    final _backgroudColor = StyleUtils.lighten(_color, 0.32).withOpacity(0.4);
    final _chipColor = StyleUtils.lighten(_color, 0.32);
    final _textColor = StyleUtils.darken(_color, 0.32);

    return Container(
      width: context.width - 32,
      margin: const EdgeInsets.all(8),
      child: [
        SizedBox(
          width: 48,
          child: [
            verticalSpaceSmall,
            Text(
              startDateTime != null
                  ? CustomDateUtils.returnTime(startDateTime!.toLocal())
                  : '',
              textAlign: TextAlign.end,
              style: context.textTheme.subtitle2!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              endDateTime != null
                  ? CustomDateUtils.returnTime(endDateTime!.toLocal())
                  : '',
              textAlign: TextAlign.end,
              style: context.textTheme.subtitle2,
            ),
          ]
              .toColumn(crossAxisAlignment: CrossAxisAlignment.end)
              .paddingOnly(right: 8),
        ),
        horizontalSpaceTiny,
        Container(
          width: context.width - 84,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
              color: _backgroudColor,
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: [
            [
              if (_isEvent)
                Icon(Icons.calendar_today, color: _textColor, size: 22)
                    .paddingOnly(right: 10)
                    .gestures(onTap: () {
                  print('Select Item');
                })
              else
                Icon(Icons.done_all, color: _textColor)
                    .paddingOnly(right: 10)
                    .gestures(onTap: () {
                  print('Select Item');
                }),
              Text(
                title ?? '',
                overflow: TextOverflow.fade,
                maxLines: 2,
                textScaleFactor: context.textScaleFactor,
                style: context.textTheme.bodyText1!.copyWith(
                  color: _textColor,
                  // fontSize: kBodyTextSize,
                ),
              ).expanded(),
              Icon(
                Icons.more_horiz,
                color: _textColor,
              ).gestures(onTap: () {
                print('More Option');
              }),
            ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
            verticalSpaceTiny,
            if (!_isEvent) const InsideTaskItem(),
            // if (!_isEvent) const InsideTaskItem(),
            // verticalSpaceTiny,
            if (!_isEvent)
              [
                if (projectOrCal != null) horizontalSpaceLarge,
                Icon(
                  Icons.arrow_drop_down,
                  color: _textColor,
                ),
                if (projectOrCal != null)
                  Chip(
                    backgroundColor: _chipColor,
                    visualDensity: const VisualDensity(
                      vertical: VisualDensity.minimumDensity,
                      horizontal: VisualDensity.minimumDensity,
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    labelPadding: EdgeInsets.zero,
                    labelStyle: kXSmallStyleRegular.copyWith(
                      color: _textColor,
                    ),
                    label: Text(projectOrCal!),
                  )
              ].toRow(
                mainAxisAlignment: projectOrCal != null
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
              )
          ].toColumn(mainAxisSize: MainAxisSize.min),
        ),
      ].toRow(crossAxisAlignment: CrossAxisAlignment.start),
    );
  }
}

class InsideTaskItem extends StatelessWidget {
  const InsideTaskItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return [
      const Icon(
        Icons.check_box_outline_blank,
        color: kcPrimary700,
        size: 16,
      ),
      horizontalSpaceTiny,
      Text(
        'Task A Ajhdu lkjasdofj kjasdföljasoiejr jköldska jf',
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.caption!.copyWith(
          color: kcPrimary700,
        ),
      ).expanded(),
    ].toRow().paddingOnly(left: 34, right: 16).gestures(onTap: () {
      print('Check');
    });
  }
}
