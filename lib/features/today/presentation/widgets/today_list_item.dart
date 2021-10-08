import 'dart:developer';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:refocus_app/core/presentation/widgets/edit_page_widgets/edit_task_header.dart';
import 'package:refocus_app/core/presentation/widgets/edit_page_widgets/edit_task_view.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';
import 'package:refocus_app/features/task/presentation/bloc/cubit/subtask_cubit.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/features/today/domain/today_entry.dart';
import 'package:refocus_app/features/today/presentation/bloc/today_bloc.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:styled_widget/styled_widget.dart';

const timeLineWidth = 48.0;

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({Key? key, required this.entry, this.selectedDate})
      : super(key: key);

  final TodayEntry entry;
  final DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    final _isEvent = entry.type == TodayEntryType.event;
    final _isPassed = entry.endDateTime != null &&
        entry.endDateTime!.compareTo(DateTime.now()) <= 0;

    final _color = _isPassed && _isEvent
        ? Colors.grey.shade600
        : StyleUtils.getColorFromString(entry.color ?? '#115FFB');
    final _backgroudColor = StyleUtils.lighten(_color, 0.28);
    final _textColor = StyleUtils.darken(_color, colorDarken1);

    // print('$title Color: ${HSLColor.fromColor(_color).lightness}');

    final _timelineTextStyle = context.subtitle2.copyWith(
      color: kcPrimary800,
    );

    final _taskTimeTextStyle = context.subtitle2.copyWith(color: _textColor);

    var _startTitle = '';
    String? _endTitle;

    if (selectedDate != null) {
      if (entry.dueDateTime != null &&
          selectedDate!.day == entry.dueDateTime!.day) {
        _startTitle = 'due today';
      } else if (entry.startDateTime != null) {
        final _startDateTimeStr =
            CustomDateUtils.returnTime(entry.startDateTime!.toLocal());
        _startTitle = _startDateTimeStr;
        if (entry.endDateTime != null) {
          final _endTime = entry.endDateTime!.toLocal();
          _endTitle = CustomDateUtils.returnTime(_endTime);
        }
      }
    }
    if (_isEvent) {
      return [
        SizedBox(
          width: timeLineWidth,
          child: Text(
            entry.startDateTime != null
                ? CustomDateUtils.returnTime(entry.startDateTime!.toLocal())
                : 'all day',
            // 'ganztätig',
            overflow: TextOverflow.clip,
            textAlign: TextAlign.right,
            maxLines: 1,
            textScaleFactor: context.textScaleFactor,
            style: _timelineTextStyle,
          ),
        ),
        // horizontalSpaceTiny,
        Icon(Icons.arrow_right, size: 24, color: _textColor),
        Text(
          entry.title ?? '',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textScaleFactor: context.textScaleFactor,
          style: context.caption.copyWith(
            color: _textColor,
          ),
        ).expanded(),
      ].toRow().opacity(_isPassed ? 0.6 : 1.0).padding(all: 6);
    } else {
      return [
        Slidable(
          key: Key(entry.id),
          actionPane: const SlidableStrechActionPane(),
          actions: [
            IconSlideAction(
              icon: Icons.check_circle_outline,
              foregroundColor: _textColor,
              color: Colors.transparent,
            )
          ],
          secondaryActions: [
            IconSlideAction(
              icon: Icons.arrow_forward_outlined,
              foregroundColor: _textColor,
              color: Colors.transparent,
            ),
            // IconSlideAction(
            //   icon: Icons.calendar_today_rounded,
            //   foregroundColor: context.colorScheme.primary,
            //   color: Colors.transparent,
            // )
          ],
          dismissal: SlidableDismissal(
            onDismissed: (actionTyp) {
              if (actionTyp == SlideActionType.primary) {
                // Mark Task as Done
                final _isCompleted = !(entry.isCompleted ?? false);
                context.read<TaskBloc>().add(EditTaskEntryEvent(
                    params: TaskParams(
                        task: returnTaskFromTodayEntry(entry,
                            isCompleted: _isCompleted))));
              } else {
                // Postpone Task to next day
                final _currentDate =
                    entry.startDateTime ?? entry.dueDateTime ?? DateTime.now();
                context.read<TaskBloc>().add(EditTaskEntryEvent(
                    params: TaskParams(
                        task: returnTaskFromTodayEntry(entry,
                            newDate: _currentDate + 1.days))));
              }
              //TODO: This also fetch calendar events, need to optimize
              context.read<TodayBloc>().add(const GetTodayEntries());
            },
            dismissThresholds: const <SlideActionType, double>{
              SlideActionType.primary: .4,
              SlideActionType.secondary: .6,
            },
            child: const SlidableDrawerDismissal(),
          ),
          child: Container(
            width: context.width - (8 + 28), //8 is hori padding
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _backgroudColor,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: [
              [
                Text(
                  entry.title ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textScaleFactor: context.textScaleFactor,
                  style: context.bodyText1.copyWith(
                    color: _textColor,
                    fontSize: kSmallTextSize,
                  ),
                ).expanded(),
              ].toRow(),
              [
                Text(
                  _startTitle,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  textScaleFactor: context.textScaleFactor,
                  style: entry.startDateTime != null
                      ? context.textTheme.subtitle2!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _textColor,
                        )
                      : _taskTimeTextStyle,
                ),
                if (entry.endDateTime != null && _endTitle != null) ...[
                  Icon(Icons.arrow_right, size: 24, color: _textColor),
                  // .padding(horizontal: 2),
                  Text(
                    _endTitle,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    textScaleFactor: context.textScaleFactor,
                    style: _taskTimeTextStyle,
                  )
                ]
              ].toRow()

              //* Subtask
              // verticalSpaceTiny,
              // const InsideTaskItem(),
            ].toColumn(mainAxisSize: MainAxisSize.min),
          )
              .ripple(
            customBorder: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          )
              .gestures(onTap: () {
            showTaskBottomSheet(context, entry.id, entry.color);
          }).padding(horizontal: 4),
        ),
      ].toRow(crossAxisAlignment: CrossAxisAlignment.start).padding(all: 6);
    }
  }

  TaskEntry returnTaskFromTodayEntry(TodayEntry todayEntry,
      {bool? isCompleted, DateTime? newDate}) {
    final _startDateTime = newDate != null && todayEntry.startDateTime != null
        ? todayEntry.startDateTime!.copyWith(
            day: newDate.day,
            month: newDate.month,
            year: newDate.year,
          )
        : todayEntry.startDateTime;

    final _endDateTime = newDate != null && todayEntry.endDateTime != null
        ? todayEntry.endDateTime!.copyWith(
            day: newDate.day,
            month: newDate.month,
            year: newDate.year,
          )
        : todayEntry.endDateTime;

    final _dueDate = newDate != null && todayEntry.dueDateTime != null
        ? todayEntry.dueDateTime!.copyWith(
            day: newDate.day,
            month: newDate.month,
            year: newDate.year,
          )
        : todayEntry.dueDateTime;

    return TaskEntry(
      id: todayEntry.id,
      isCompleted: isCompleted ?? todayEntry.isCompleted ?? false,
      completedDate:
          (isCompleted != null && isCompleted) ? DateTime.now() : null,
      projectID: todayEntry.projectOrCalID!,
      calendarID: todayEntry.calendarEventID,
      colorID: todayEntry.color,
      title: todayEntry.title,
      dueDate: _dueDate,
      startDateTime: _startDateTime,
      endDateTime: _endDateTime,
      description: todayEntry.description,
      priority: todayEntry.priority,
      isHabit: todayEntry.type == TodayEntryType.habit,
    );
  }

  dynamic showTaskBottomSheet(
    BuildContext parentContext,
    String taskID,
    String? colorID,
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
            return EditTaskHeader(colorID: colorID);
          },
          builder: (context, state) {
            log(taskID);
            return MultiBlocProvider(
              providers: [
                BlocProvider<TaskBloc>.value(
                  value: BlocProvider.of<TaskBloc>(parentContext),
                ),
                BlocProvider<SubtaskCubit>.value(
                  value: BlocProvider.of<SubtaskCubit>(parentContext),
                ),
              ],
              child: EditTaskView(taskID: taskID, colorID: colorID),
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
