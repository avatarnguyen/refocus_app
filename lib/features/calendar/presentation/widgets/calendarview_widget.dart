import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:refocus_app/core/util/ui/ui_helpers.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/datetime_stream.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:get/get.dart';
import 'package:dartx/dartx.dart';

import '../../../../core/util/ui/style_helpers.dart';
import '../../../../injection.dart';
import '../bloc/calendar/calendar_bloc.dart';

class CalendarViewWidget extends StatefulWidget {
  const CalendarViewWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  final CalendarState state;

  @override
  _CalendarViewWidgetState createState() => _CalendarViewWidgetState();
}

class _CalendarViewWidgetState extends State<CalendarViewWidget> {
  final DateTimeStream _dateTimeStream = getIt<DateTimeStream>();
  StreamSubscription<DateTime>? _dateTimeSubscription;

  final CalendarController _controller = CalendarController();

  @override
  void initState() {
    _dateTimeSubscription =
        _dateTimeStream.dateTimeStream.listen(_dateTimeReceived);
    super.initState();
  }

  void _dateTimeReceived(DateTime newDate) {
    log('[calendar view] new current Date: $newDate');

    if (_controller.displayDate != null) {
      _controller.displayDate = newDate;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dateTimeSubscription?.cancel();
  }

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
        controller: _controller,
        view: CalendarView.day,
        dataSource: widget.state is Loaded
            ? (widget.state as Loaded).calendarData
            : null,
        loadMoreWidgetBuilder: loadMoreWidget,
        headerHeight: 0,
        // onViewChanged: ,

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
