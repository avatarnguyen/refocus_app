import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/calendar_params.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart';
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
                itemBuilder: (context, index) =>
                    CheckBoxListItem(calendar: calendars[index]),
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

class CheckBoxListItem extends StatefulWidget {
  const CheckBoxListItem({
    Key? key,
    required this.calendar,
  }) : super(key: key);

  final CalendarEntry calendar;

  @override
  _CheckBoxListItemState createState() => _CheckBoxListItemState();
}

class _CheckBoxListItemState extends State<CheckBoxListItem> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isSelected = widget.calendar.selected ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<CalendarListBloc>(context, listen: false);

    return CheckboxListTile(
      title: Text(widget.calendar.name),
      value: _isSelected,
      onChanged: (newValue) {
        _bloc.add(
          UpdateCalendarEvent(CalendarParams(
            calendar: widget.calendar.copyWith(selected: newValue),
          )),
        );
        setState(() {
          _isSelected = newValue ?? false;
        });
      },
      controlAffinity: ListTileControlAffinity.trailing,
    );
  }
}
