import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/calendarlist_item_widget.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';

import 'package:refocus_app/injection.dart';

class CalendarListPage extends StatelessWidget {
  const CalendarListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalendarListBloc>(
      create: (context) => getIt<CalendarListBloc>(),
      child: const CalendarListWidget(),
    );
  }
}

class CalendarListWidget extends StatefulWidget {
  const CalendarListWidget({Key? key}) : super(key: key);

  @override
  _CalendarListWidgetState createState() => _CalendarListWidgetState();
}

class _CalendarListWidgetState extends State<CalendarListWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CalendarListBloc>(context, listen: false)
        .add(GetCalendarListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarListBloc, CalendarListState>(
      builder: (context, state) {
        if (state is CalendarListInitial) {
          return const LoadingWidget();
        }
        if (state is Loaded) {
          final calendars = state.calendarList;
          return SafeArea(
            top: false,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 16),
              itemCount: calendars.length,
              itemBuilder: (context, index) =>
                  CalendarListItem(calendar: calendars[index]),
            ),
          );
        } else if (state is Error) {
          return MessageDisplay(
            message: state.message,
          );
        } else if (state is Loading) {
          return const LoadingWidget();
        } else {
          return const MessageDisplay(
            message: 'Unexpected State',
          );
        }
      },
    );
  }
}
