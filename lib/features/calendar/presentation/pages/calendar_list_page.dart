import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_list/bloc/calendar_list_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';

import '../../../../injection.dart';

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
    // final _bloc = BlocProvider.of<CalendarListBloc>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Calendars'),
        ),
        body: BlocBuilder<CalendarListBloc, CalendarListState>(
          builder: (context, state) {
            if (state is CalendarListInitial) {
              return const MessageDisplay(
                message: 'Initial State',
              );
            }
            if (state is Loaded) {
              final calendars = state.calendarList;
              return ListView.builder(
                itemCount: calendars.length,
                itemBuilder: (context, index) => CheckboxListTile(
                  title: Text(calendars[index].name),
                  value: calendars[index].selected ?? false,
                  onChanged: (newValue) {},
                  controlAffinity: ListTileControlAffinity.trailing,
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
        ));
  }
}
