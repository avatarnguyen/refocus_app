import 'dart:async';

import 'package:flutter/material.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/datetime_stream.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/appointment_widget.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/day_event_widget.dart';
import 'package:refocus_app/injection.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:refocus_app/core/util/ui/ui_helper.dart';

import '../bloc/calendar/calendar_bloc.dart';

class CalendarMonthViewWidget extends StatefulWidget {
  const CalendarMonthViewWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  final CalendarState state;

  @override
  State<CalendarMonthViewWidget> createState() =>
      _CalendarMonthViewWidgetState();
}

class _CalendarMonthViewWidgetState extends State<CalendarMonthViewWidget> {
  final DateTimeStream _dateTimeStream = getIt<DateTimeStream>();
  late StreamSubscription<DateTime> _dateTimeSubscription;

  final CalendarController _controller = CalendarController();

  @override
  void initState() {
    _dateTimeSubscription =
        _dateTimeStream.dateTimeStream.listen(_dateTimeReceived);
    super.initState();
  }

  @override
  void dispose() {
    _dateTimeSubscription.cancel();
    super.dispose();
  }

  void _dateTimeReceived(DateTime newDate) {
    if (_controller.displayDate != null) {
      _controller.displayDate = newDate;
      _controller.selectedDate = newDate;
    }
  }

  Widget loadMoreWidget(
      BuildContext context, LoadMoreCallback loadMoreAppointments) {
    return FutureBuilder<void>(
      future: loadMoreAppointments(),
      builder: (context, snapShot) {
        return Container(
          margin: EdgeInsets.only(top: context.height * 0.65, left: 8),
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
        view: CalendarView.month,
        initialSelectedDate: DateTime.now(),
        dataSource: widget.state is Loaded
            ? (widget.state as Loaded).calendarData
            : null,
        loadMoreWidgetBuilder: loadMoreWidget,
        headerHeight: 48,
        headerStyle: CalendarHeaderStyle(
          textStyle: kBodyStyleBold.copyWith(
            color: kcPrimary600,
          ),
          backgroundColor: context.backgroundColor,
        ),
        viewHeaderHeight: 48,
        backgroundColor: context.backgroundColor,
        cellBorderColor: Colors.white10,
        todayHighlightColor: kcPrimary400,
        selectionDecoration:
            BoxDecoration(border: Border.all(color: kcTertiary500, width: 2)),
        showDatePickerButton: true,
        // showNavigationArrow: true,
        viewHeaderStyle: ViewHeaderStyle(
            backgroundColor: context.backgroundColor,
            dayTextStyle: kCaptionStyleBold.copyWith(color: Colors.black38)),
        appointmentBuilder: appointmentBuilder,
        monthViewSettings: MonthViewSettings(
          showAgenda: true,
          agendaViewHeight: screenHeightPercentage(context, percentage: 0.35),
          numberOfWeeksInView: 4,
          dayFormat: 'EEE',
          monthCellStyle: MonthCellStyle(
            backgroundColor: context.backgroundColor,
            trailingDatesBackgroundColor: context.backgroundColor,
            leadingDatesBackgroundColor: context.backgroundColor,
            todayBackgroundColor: context.backgroundColor,
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
