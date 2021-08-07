import 'package:flutter/material.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:refocus_app/core/util/ui/ui_helpers.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:styled_widget/styled_widget.dart';

class CalendarMonthViewWidget extends StatelessWidget {
  const CalendarMonthViewWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  final CalendarState state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SfCalendar(
        view: CalendarView.month,
        dataSource: state is Loaded ? (state as Loaded).calendarData : null,
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
