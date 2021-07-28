import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/features/google_calendar/presentation/bloc/gcal_bloc.dart';
import 'package:refocus_app/features/google_calendar/presentation/widgets/widgets.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../injection_container.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GcalBloc>(
      create: (context) => sl<GcalBloc>(),
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
              return MessageDisplay(
                message: state.gCalEntry.summary,
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
      ].toColumn().parent((page)),
    );
  }

  Widget page({required Widget child}) => Styled.widget(child: child)
      .padding(vertical: 30, horizontal: 20)
      .scrollable();
}
