import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:refocus_app/core/util/ui/ui_helpers.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/datetime_stream.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:get/get.dart';

import '../../../../core/util/ui/style_helpers.dart';
import '../../../../injection.dart';
import '../bloc/calendar/calendar_bloc.dart';
import 'appointment_widget.dart';
import 'day_event_widget.dart';

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

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    if (hsl.lightness - amount > 0.1) {
      final hslDark =
          hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
      return hslDark.toColor();
    } else {
      return hsl.withLightness((0.1).clamp(0.0, 1.0)).toColor();
    }
  }

  Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    if (hsl.lightness + amount < 1.0) {
      final hslLight =
          hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
      return hslLight.toColor();
    } else {
      return hsl.withLightness((0.92).clamp(0.0, 1.0)).toColor();
    }
  }

  Widget appointmentBuilder(BuildContext context,
      CalendarAppointmentDetails calendarAppointmentDetails) {
    final CalendarEventEntry event =
        calendarAppointmentDetails.appointments.first;

    var _colorValue = event.colorId!.replaceAll('#', '0xff');
    final _color = Color(int.parse(_colorValue));
    final _backgroudColor = lighten(_color, 0.25);

    final _textColor = darken(_color, 0.32);

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
        appointmentBuilder: appointmentBuilder,
        // appointmentTextStyle: kBodyStyleRegular,
        timeSlotViewSettings: const TimeSlotViewSettings(
          timeIntervalHeight: 56,
        ),
      ).padding(horizontal: 8),
    );
  }
}
