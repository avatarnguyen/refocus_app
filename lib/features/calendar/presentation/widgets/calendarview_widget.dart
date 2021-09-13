import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/datetime_stream.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/appointment_widget.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/day_event_widget.dart';
import 'package:refocus_app/injection.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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

  Widget appointmentBuilder(BuildContext context,
      CalendarAppointmentDetails calendarAppointmentDetails) {
    final event =
        calendarAppointmentDetails.appointments.first as CalendarEventEntry;

    final _colorValue = event.colorId!.replaceAll('#', '0xff');
    final _color = Color(int.parse(_colorValue));
    final _backgroudColor = StyleUtils.lighten(_color, 0.25);

    final _textColor = StyleUtils.darken(_color, 0.32);

    final _height = calendarAppointmentDetails.bounds.height;
    final _width = calendarAppointmentDetails.bounds.width;

    if (event.allDay != null && event.allDay!) {
      return DayEventCellWidget(
        backgroudColor: _backgroudColor,
        event: event,
        textColor: _textColor,
        height: _height,
        width: _width,
      );
    } else {
      final _diff =
          event.endDateTime!.difference(event.startDateTime!).inMinutes;

      return Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            child: AppointmentEventCellWidget(
              width: _width,
              diff: _diff,
              height: _height,
              backgroudColor: _backgroudColor,
              event: event,
              textColor: _textColor,
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SfCalendar(
        controller: _controller,
        dataSource: widget.state is Loaded
            ? (widget.state as Loaded).calendarData
            : null,
        loadMoreWidgetBuilder: loadMoreWidget,
        headerHeight: 0,
        // onViewChanged: ,

        // viewHeaderHeight: 0,
        backgroundColor: kcLightBackground,
        todayHighlightColor: kcPrimary400,
        appointmentBuilder: appointmentBuilder,
        // appointmentTextStyle: kBodyStyleRegular,
        timeSlotViewSettings: const TimeSlotViewSettings(
          timeIntervalHeight: 56,
        ),
      ).padding(horizontal: 8),
    );
  }
}
