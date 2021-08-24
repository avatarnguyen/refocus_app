import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:get/get.dart';

import 'package:refocus_app/core/util/ui/ui_helper.dart';

import '../bloc/calendar/calendar_bloc.dart';

class CalendarMonthViewWidget extends StatelessWidget {
  const CalendarMonthViewWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  final CalendarState state;

  Widget loadMoreWidget(
      BuildContext context, LoadMoreCallback loadMoreAppointments) {
    return FutureBuilder<void>(
      future: loadMoreAppointments(),
      builder: (context, snapShot) {
        return Container(
          margin: EdgeInsets.only(top: context.height * 0.55, left: 8),
          child: progressIndicator,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SfCalendar(
        view: CalendarView.month,
        initialSelectedDate: DateTime.now(),
        dataSource: state is Loaded ? (state as Loaded).calendarData : null,
        loadMoreWidgetBuilder: loadMoreWidget,
        headerHeight: 48,
        headerStyle: CalendarHeaderStyle(
          textStyle: kBodyStyleBold.copyWith(
            color: kcPrimary600,
          ),
          backgroundColor: Colors.white,
        ),
        viewHeaderHeight: 48,
        backgroundColor: kcLightBackground,
        cellBorderColor: Colors.white10,
        todayHighlightColor: kcPrimary400,
        selectionDecoration:
            BoxDecoration(border: Border.all(color: kcTertiary500, width: 2)),
        // appointmentTextStyle: kBodyStyleRegular,
        showDatePickerButton: true,
        // showNavigationArrow: true,
        viewHeaderStyle: ViewHeaderStyle(
            backgroundColor: Colors.white,
            dayTextStyle: kCaptionStyleBold.copyWith(color: Colors.black38)),
        monthViewSettings: MonthViewSettings(
          showAgenda: true,
          agendaViewHeight: screenHeightPercentage(context, percentage: 0.4),
          numberOfWeeksInView: 4,
          dayFormat: 'EEE',
          monthCellStyle: MonthCellStyle(
            backgroundColor: Colors.white,
            trailingDatesBackgroundColor: Colors.white,
            leadingDatesBackgroundColor: Colors.white,
            todayBackgroundColor: Colors.white,
            textStyle: kCaptionStyleRegular.copyWith(color: Colors.black87),
          ),
          agendaStyle: AgendaStyle(
            dayTextStyle: kSmallStyleRegular.copyWith(color: Colors.black26),
            dateTextStyle: kLeadStyleBold.copyWith(color: kcPrimary900),
          ),
        ),
      ).padding(horizontal: 16),
    );
  }
}
