import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dartx/dartx.dart';

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
    return DateFormat.yMMMMEEEEd('de_DE').format(date);
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
          verticalSpaceRegular,
          [
            [
              PlatformText(
                'Good Morning!',
                overflow: TextOverflow.fade,
                style: context.textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
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
        [
          const LinearProgressIndicator(
            value: 0.3,
            minHeight: 8.0,
            color: kcPrimary500,
            backgroundColor: kcPrimary200,
          )
              .clipRRect(all: 4.0)
              .parent(({required child}) => Flexible(child: child)),
          horizontalSpaceSmall,
          Text(
            '30 %',
            style: context.textTheme.subtitle1!.copyWith(color: Colors.black54),
          )
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).parent(
              ({required child}) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                height: 32,
                decoration: BoxDecoration(
                  boxShadow: const [
                    kShadowLightBase,
                    kShadowLight60,
                  ],
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: child,
              ),
            ),
        verticalSpaceSmall,
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
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).parent((page)),
    );
  }
}

class TodayListWidget extends StatelessWidget {
  const TodayListWidget({
    Key? key,
  }) : super(key: key);

  Future<void> _pullToRefresh(BuildContext context) async {
    context.read<TodayBloc>().add(GetTodayEntries(DateTime.now()));
    await Future.delayed(1000.milliseconds);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodayBloc, TodayState>(
      builder: (context, state) {
        if (state is TodayLoaded) {
          final _entries =
              state.todayEntries.sortedBy((entry) => entry.startDateTime!);
          return RefreshIndicator(
            onRefresh: () async => await _pullToRefresh(context),
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
  }) : super(key: key);

  final String? title;
  final TodayEntryType type;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final String? color;
  final String? eventID;
  final String? taskID;

  @override
  Widget build(BuildContext context) {
    final _isEvent = type == TodayEntryType.event;
    final _isPassed = endDateTime!.compareTo(DateTime.now()) <= 0;

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
              CustomDateUtils.returnTime(startDateTime!.toLocal()),
              textAlign: TextAlign.end,
              style: context.textTheme.subtitle2!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              CustomDateUtils.returnTime(endDateTime!.toLocal()),
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
            horizontal: 12,
          ),
          decoration: BoxDecoration(
              color: _backgroudColor,
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: [
            [
              _isEvent
                  ? Icon(Icons.calendar_today, color: _textColor)
                      .paddingOnly(right: 10)
                      .gestures(onTap: () {
                      print('Select Item');
                    })
                  : Icon(Icons.done_all, color: _textColor)
                      .paddingOnly(right: 10)
                      .gestures(onTap: () {
                      print('Select Item');
                    }),
              Text(
                title ?? '',
                overflow: TextOverflow.fade,
                maxLines: 2,
                textScaleFactor: context.textScaleFactor,
                style: context.textTheme.headline5!.copyWith(
                  color: _textColor,
                ),
              ).expanded(),
              Icon(
                Icons.more_horiz,
                color: _textColor,
              ).gestures(onTap: () {
                print('More Option');
              }),
            ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
            verticalSpaceSmall,
            if (!_isEvent) const InsideTaskItem(),
            if (!_isEvent) const InsideTaskItem(),
            verticalSpaceTiny,
            [
              horizontalSpaceLarge,
              if (!_isEvent)
                Icon(
                  Icons.arrow_drop_down,
                  color: _textColor,
                ),
              Chip(
                backgroundColor: _chipColor,
                visualDensity: const VisualDensity(
                  horizontal: 0.0,
                  vertical: VisualDensity.minimumDensity,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
                labelPadding: EdgeInsets.zero,
                labelStyle: context.textTheme.caption!.copyWith(
                  color: _textColor,
                ),
                label: const Text('Work'),
              )
            ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
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
      ),
      horizontalSpaceTiny,
      Text(
        'Task A Ajhdu lkjasdofj kjasdföljasoiejr jköldska jf',
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.subtitle1!.copyWith(
          color: kcPrimary700,
        ),
      ).expanded(),
    ].toRow().paddingOnly(left: 34, right: 16).gestures(onTap: () {
      print('Check');
    });
  }
}
