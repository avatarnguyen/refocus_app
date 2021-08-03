import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/core/util/ui/widget_helpers.dart';
import 'package:refocus_app/injection.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../bloc/gcal_bloc.dart';
import '../widgets/widgets.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GcalBloc>(
      create: (context) => getIt<GcalBloc>(),
      child: const CalendarWidget(),
    );
  }
}

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Page'),
      ),
      body: <Widget>[
        BlocBuilder<GcalBloc, GcalState>(
          builder: (context, state) {
            if (state is GcalInitial) {
              return const MessageDisplay(
                message: 'Start Searching!',
              );
            } else if (state is Loading) {
              return const LoadingWidget();
            } else if (state is Error) {
              return MessageDisplay(
                message: state.message,
              );
            } else if (state is Loaded) {
              return Container(
                height: 700,
                child: SfCalendar(
                  view: CalendarView.day,
                  dataSource: state.calendarData,
                  // monthViewSettings: const MonthViewSettings(
                  //   appointmentDisplayMode:
                  //       MonthAppointmentDisplayMode.appointment,
                  // ),
                ).center(),
              );
            } else {
              return const MessageDisplay(
                message: 'Unexpected State',
              );
            }
          },
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<GcalBloc>(context, listen: false)
                .add(GetAllCalendarEntries());
          },
          child: const Text('Get Events'),
        ).center(),
      ].toColumn().parent((scrollablePage)),
    );
  }
}
