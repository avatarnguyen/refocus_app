import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/calendar_params.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart';

class CalendarListItem extends StatefulWidget {
  const CalendarListItem({
    Key? key,
    required this.calendar,
  }) : super(key: key);

  final CalendarEntry calendar;

  @override
  _CalendarListItemState createState() => _CalendarListItemState();
}

class _CalendarListItemState extends State<CalendarListItem> {
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
    final _color =
        StyleUtils.getColorFromString(widget.calendar.color ?? '#8879FC');
    final _backgroundColor = StyleUtils.darken(_color);
    const _textColor = Colors.white;

    return [
      widget.calendar.name.toBodyText1(color: _textColor).flexible(),
      // Material(
      //   color: Colors.transparent,
      //   child: Checkbox(
      //     visualDensity: const VisualDensity(
      //       horizontal: VisualDensity.minimumDensity,
      //       vertical: VisualDensity.minimumDensity,
      //     ),
      //     value: _isSelected,
      //     onChanged: _changeCheckBoxState,
      //   ),
      // ),
    ]
        .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
        .padding(all: 16)
        .ripple()
        .card(
          color: _isSelected ? _backgroundColor : Colors.transparent,
          elevation: 4,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            side: _isSelected
                ? BorderSide.none
                : BorderSide(color: _backgroundColor),
          ),
        )
        .gestures(
      onTap: () {
        _changeCheckBoxState(!_isSelected);
      },
    );
  }

  void _changeCheckBoxState(bool? newValue) {
    final _bloc = context.read<CalendarListBloc>();

    _bloc.add(
      UpdateCalendarEvent(CalendarParams(
        calendar: widget.calendar.copyWith(selected: newValue),
      )),
    );
    setState(() {
      _isSelected = newValue ?? false;
    });
    //TODO: Reload Calendar after change
    // context.read<CalendarBloc>().add(GetCalendarEntries());
  }
}
