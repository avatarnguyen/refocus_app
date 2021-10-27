import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';

class EditDateTimeCell extends StatefulWidget {
  const EditDateTimeCell({Key? key, required this.fetchedTask, this.colorID})
      : super(key: key);

  final TaskEntry fetchedTask;
  final String? colorID;

  @override
  State<EditDateTimeCell> createState() => _EditDateTimeCellState();
}

class _EditDateTimeCellState extends State<EditDateTimeCell> {
  // final _settingOption = getIt<SettingOption>();

  @override
  Widget build(BuildContext context) {
    final _textColor = widget.colorID != null
        ? StyleUtils.darken(StyleUtils.getColorFromString(widget.colorID!))
        : kcPrimary500;

    final _timeTextStyle = context.h6.copyWith(
      color: _textColor,
      fontWeight: FontWeight.w600,
    );
    final _dateTextStyle = context.subtitle1.copyWith(
      color: _textColor,
    );
    return AnimatedContainer(
      duration: 400.milliseconds,
      child: [
        [
          if (widget.fetchedTask.startDateTime != null)
            Text(
              CustomDateUtils.returnTime(
                  widget.fetchedTask.startDateTime!.toLocal()),
              style: _timeTextStyle,
            ),
          if (widget.fetchedTask.endDateTime != null) ...[
            Icon(
              Icons.arrow_right_alt_rounded,
              color: _textColor,
            ).padding(horizontal: 4),
            Text(
              CustomDateUtils.returnTime(
                  widget.fetchedTask.endDateTime!.toLocal()),
              style: _timeTextStyle,
            ),
          ]
        ].toRow(mainAxisAlignment: MainAxisAlignment.center),
        [
          if (widget.fetchedTask.startDateTime != null)
            Text(
              CustomDateUtils.returnDateAndMonth(
                  widget.fetchedTask.startDateTime!.toLocal()),
              style: _dateTextStyle,
            ),
          if (widget.fetchedTask.endDateTime != null &&
              !widget.fetchedTask.endDateTime!
                  .isAtSameDayAs(widget.fetchedTask.startDateTime!)) ...[
            Icon(
              Icons.arrow_right_alt_rounded,
              color: _textColor,
            ).padding(horizontal: 4),
            Text(
              CustomDateUtils.returnDateAndMonth(
                  widget.fetchedTask.endDateTime!.toLocal()),
              style: _dateTextStyle,
            ),
          ]
        ].toRow(mainAxisAlignment: MainAxisAlignment.center),
      ].toColumn(mainAxisSize: MainAxisSize.min),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
