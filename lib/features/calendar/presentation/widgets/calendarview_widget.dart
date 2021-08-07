import 'package:flutter/material.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:styled_widget/styled_widget.dart';

class CalendarViewWidget extends StatelessWidget {
  const CalendarViewWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  final CalendarState state;

  Widget loadMoreWidget(
      BuildContext context, LoadMoreCallback loadMoreAppointments) {
    return FutureBuilder<void>(
      initialData: 'loading',
      future: loadMoreAppointments(),
      builder: (context, snapShot) {
        return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator.adaptive());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SfCalendar(
        view: CalendarView.day,
        dataSource: state is Loaded ? (state as Loaded).calendarData : null,
        loadMoreWidgetBuilder: loadMoreWidget,
        headerHeight: 0,

        // viewHeaderHeight: 0,
        backgroundColor: kcLightBackground,
        todayHighlightColor: kcPrimary400,
        // appointmentTextStyle: kBodyStyleRegular,
        timeSlotViewSettings: const TimeSlotViewSettings(
          timeIntervalHeight: 56,
        ),
      ).padding(horizontal: 8),
    );
  }
}
