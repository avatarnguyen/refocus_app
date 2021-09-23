import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/calendar_params.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart';

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

    return Material(
      child: CheckboxListTile(
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
      ),
    );
  }
}
