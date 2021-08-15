import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:refocus_app/core/util/helpers/logging.dart' as custom_log;
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:refocus_app/core/util/ui/ui_helpers.dart';
import 'package:refocus_app/core/util/ui/widget_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key}) : super(key: key);

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

    return Scaffold(
      backgroundColor: kcLightBackground,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // return BlocProvider.of<CalendarBloc>(context).add(
          //   DeleteCalendarEvent(testEvent),
          // );
        },
        backgroundColor: kcPrimary500,
        child: const Icon(Icons.add),
      ),
      body: <Widget>[
        [
          verticalSpaceRegular,
          [
            InkWell(
              onTap: () async {},
              child: const Icon(
                Icons.calendar_view_day,
                size: 26,
                color: kcPrimary500,
              ),
            ),
            InkWell(
              onTap: () async {},
              child: const Icon(
                Icons.menu,
                size: 26,
                color: kcPrimary500,
              ),
            ),
          ]
              .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
              .padding(horizontal: 8),
          verticalSpaceRegular,
          [
            [
              Text(
                'Good Morning!',
                style: context.textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              verticalSpaceSmall,
              Text(
                returnDate(today),
                style: context.textTheme.headline6!.copyWith(
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
            ).padding(right: 4),
          ].toRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
          )
        ]
            .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
            .parent(headerContainer),
        verticalSpaceRegular,
        SfCalendar(
          view: CalendarView.timelineDay,
          initialSelectedDate: DateTime.now(),
          headerHeight: 0.0,
          viewHeaderHeight: 0,
        ).parent(({required child}) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(2),
              height: 112,
              decoration: BoxDecoration(
                boxShadow: const [
                  kShadowLightBase,
                  kShadowLight60,
                ],
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: child,
            )),
        //* Body: List View
        Expanded(
          child: ListView.builder(
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return const ListTile(
                  title: Text('Test Cell'),
                );
              }),
        ),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).parent((page)),
    );
  }
}
