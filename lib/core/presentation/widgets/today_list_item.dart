import 'dart:developer';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/core/presentation/widgets/edit_task_view.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/features/task/presentation/pages/project_page.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:styled_widget/styled_widget.dart';

import 'sub_task_item.dart';

const timeLineWidth = 48.0;

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

    final _timelineTextStyle = context.subtitle2.copyWith(
      color: kcPrimary800,
    );

    return _isEvent
        ? [
            SizedBox(
              width: timeLineWidth,
              child: Text(
                startDateTime != null
                    ? CustomDateUtils.returnTime(startDateTime!.toLocal())
                    : 'all day',
                // 'ganztätig',
                overflow: TextOverflow.clip,
                textAlign: TextAlign.right,
                maxLines: 1,
                textScaleFactor: context.textScaleFactor,
                style: _timelineTextStyle,
              ),
            ),
            Icon(
              Icons.arrow_right,
              size: 24,
              color: _textColor,
            ),
            // horizontalSpaceTiny,
            Text(
              title ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textScaleFactor: context.textScaleFactor,
              style: context.caption.copyWith(
                color: _textColor,
              ),
            ).expanded(),
          ].toRow().opacity(_isPassed ? 0.6 : 1.0).padding(all: 6)
        : [
            [
              Text(
                startDateTime != null
                    ? CustomDateUtils.returnTime(startDateTime!.toLocal())
                    : 'due today',
                overflow: TextOverflow.clip,
                textAlign: TextAlign.right,
                maxLines: 1,
                textScaleFactor: context.textScaleFactor,
                style: startDateTime != null
                    ? context.textTheme.subtitle2!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kcPrimary800,
                      )
                    : _timelineTextStyle,
              ).padding(top: 4),
              if (endDateTime != null)
                Text(
                  CustomDateUtils.returnTime(
                      endDateTime!.toLocal()), // 'ganztätig',
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  textScaleFactor: context.textScaleFactor,
                  style: _timelineTextStyle,
                )
            ]
                .toColumn(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )
                .expanded(),
            Container(
              width: context.width - (6 + 28 + timeLineWidth),
              margin: const EdgeInsets.only(left: 6),
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: _backgroudColor,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: [
                [
                  Material(
                    color: Colors.transparent,
                    child: Checkbox(
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
                          .add(const EditTaskEntryEvent(params: TaskParams())),
                    ).padding(right: 8),
                  ),
                  Text(
                    title ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textScaleFactor: context.textScaleFactor,
                    style: context.bodyText1.copyWith(
                      color: _textColor,
                      fontSize: kSmallTextSize,
                    ),
                  ).expanded(),
                ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),

                //* Subtask
                // verticalSpaceTiny,
                // const InsideTaskItem(),
              ].toColumn(mainAxisSize: MainAxisSize.min),
            ).ripple().gestures(onTap: () {
              print('Task ID: $taskID');
              if (taskID != null) {
                showTaskBottomSheet(context, taskID!);
              }
            }),
          ]
            .toRow(crossAxisAlignment: CrossAxisAlignment.start)
            .padding(all: 6); //.marginAll(6);
  }

  dynamic showTaskBottomSheet(
    BuildContext parentContext,
    String taskID,
  ) async {
    SlidingSheetDialog? _taskSheetDialog;
    final dynamic result = await showSlidingBottomSheet<dynamic>(
      parentContext,
      builder: (context) {
        return _taskSheetDialog ??= SlidingSheetDialog(
          elevation: 8,
          cornerRadius: 16,
          duration: 500.milliseconds,
          color: context.backgroundColor,
          snapSpec: const SnapSpec(
            initialSnap: 0.5,
            snappings: [0.5, 0.89],
            positioning: SnapPositioning.relativeToSheetHeight,
          ),
          minHeight: context.height - 56,
          headerBuilder: (context, state) {
            return const TaskPageHeaderWidget();
          },
          builder: (context, state) {
            log(taskID);
            return BlocProvider<TaskBloc>.value(
              value: BlocProvider.of<TaskBloc>(parentContext),
              child: EditTaskView(taskID: taskID),
            );
          },
        );
      },
    );

    print(result); // This is the result.
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
