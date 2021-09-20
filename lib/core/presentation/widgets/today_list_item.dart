import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:styled_widget/styled_widget.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    Key? key,
    this.title,
    required this.type,
    this.startDateTime,
    this.endDateTime,
    this.color,
    this.eventID,
    this.taskID,
    this.projectOrCal,
  }) : super(key: key);

  final String? title;
  final TodayEntryType type;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final String? color;
  final String? eventID;
  final String? taskID;
  final String? projectOrCal;

  @override
  Widget build(BuildContext context) {
    final _isEvent = type == TodayEntryType.event;
    final _isTask = type == TodayEntryType.task;
    final _isPassed =
        endDateTime != null && endDateTime!.compareTo(DateTime.now()) <= 0;

    final _color = _isPassed
        ? Colors.grey.shade600
        : StyleUtils.getColorFromString(color ?? '#115FFB');
    final _backgroudColor = StyleUtils.lighten(_color, 0.32).withOpacity(0.4);
    // final _chipColor = StyleUtils.lighten(_color, 0.32);
    final _textColor = StyleUtils.darken(_color, 0.32);

    return Container(
      margin: const EdgeInsets.all(6),
      child: [
        Opacity(
          opacity: _isPassed ? 0.6 : 1.0,
          child: Container(
            width: context.width - 28,
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
                color: _backgroudColor,
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: [
              [
                if (_isEvent)
                  Icon(Icons.calendar_today, color: _textColor, size: 20)
                      .paddingOnly(right: 10, left: 2)
                      .gestures(onTap: () {
                    print('Select Calendar');
                  })
                else if (_isTask)
                  Checkbox(
                    tristate: true,
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: false,
                    shape: const CircleBorder(
                        side: BorderSide(width: 8, color: Colors.blue)),
                    onChanged: (bool? selected) => context
                        .read<TaskBloc>()
                        .add(EditTaskEntryEvent(params: TaskParams())),
                  ).paddingOnly(right: 8)
                else
                  Icon(Icons.done_all, color: _textColor, size: 22)
                      .paddingOnly(right: 10, left: 2)
                      .gestures(onTap: () {
                    print('Select Time Block');
                  }),
                Text(
                  title ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textScaleFactor: context.textScaleFactor,
                  style: context.textTheme.bodyText1!.copyWith(
                    color: _textColor,
                    fontSize: kSmallTextSize,
                  ),
                ).expanded(),
                // Icon(
                //   Icons.more_horiz,
                //   color: _textColor,
                // ).gestures(onTap: () {
                //   print('More Option');
                // }),
              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
              if (startDateTime != null) verticalSpaceTiny,
              if (startDateTime != null)
                SizedBox(
                  child: [
                    Icon(
                      Icons.alarm,
                      color: _textColor,
                      size: 16,
                    ),
                    horizontalSpaceTiny,
                    Text(
                      startDateTime != null
                          ? CustomDateUtils.returnTime(startDateTime!.toLocal())
                          : '',
                      textAlign: TextAlign.end,
                      style: context.textTheme.subtitle2!.copyWith(
                        color: _textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      endDateTime != null
                          ? ' - ${CustomDateUtils.returnTime(endDateTime!.toLocal())}'
                          : '',
                      textAlign: TextAlign.end,
                      style: context.textTheme.subtitle2!.copyWith(
                        color: _textColor,
                      ),
                    ),
                  ].toRow().paddingOnly(left: 30, right: 16),
                ),
              // verticalSpaceTiny,
              // const InsideTaskItem(),
              // if (!_isEvent) const InsideTaskItem(),
              // verticalSpaceTiny,
              // if (!_isEvent)
              //   [
              //     if (projectOrCal != null) horizontalSpaceLarge,
              //     Icon(
              //       Icons.arrow_drop_down,
              //       color: _textColor,
              //     ),
              //     if (projectOrCal != null)
              //       Chip(
              //         backgroundColor: _chipColor,
              //         visualDensity: const VisualDensity(
              //           vertical: VisualDensity.minimumDensity,
              //           horizontal: VisualDensity.minimumDensity,
              //         ),
              //         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              //         padding: const EdgeInsets.symmetric(
              //           horizontal: 8,
              //         ),
              //         labelPadding: EdgeInsets.zero,
              //         labelStyle: kXSmallStyleRegular.copyWith(
              //           color: _textColor,
              //         ),
              //         label: Text(projectOrCal!),
              //       )
              //   ].toRow(
              //     mainAxisAlignment: projectOrCal != null
              //         ? MainAxisAlignment.spaceBetween
              //         : MainAxisAlignment.center,
              //   )
            ].toColumn(mainAxisSize: MainAxisSize.min),
          ),
        ),
      ].toRow(crossAxisAlignment: CrossAxisAlignment.start),
    );
  }

  // Get Checkbox color, depends on state
  Color getColor(Set<MaterialState> states) {
    const interactiveStates = <MaterialState>{
      MaterialState.selected,
      MaterialState.hovered,
      MaterialState.focused,
      // MaterialState.disabled,
    };
    if (states.any(interactiveStates.contains)) {
      return kcPrimary500;
    }
    return Colors.grey;
  }
}
