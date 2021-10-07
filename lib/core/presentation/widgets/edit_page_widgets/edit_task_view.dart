import 'dart:async';
import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/presentation/helper/edit_task_stream.dart';
import 'package:refocus_app/core/presentation/widgets/edit_page_widgets/edit_datetime_cell.dart';
import 'package:refocus_app/core/presentation/widgets/edit_page_widgets/slidable_subtask_item.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/edit_task_state.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/message_widget.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';
import 'package:refocus_app/features/task/presentation/bloc/cubit/subtask_cubit.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/injection.dart';
import 'package:uuid/uuid.dart';

enum DateTimeSelected { start, end, due }

class EditTaskView extends StatefulWidget {
  const EditTaskView({Key? key, required this.taskID, this.colorID})
      : super(key: key);

  final String taskID;
  final String? colorID;

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  final EditTaskStream _editStream = getIt<EditTaskStream>();
  late StreamSubscription<EditTaskState> _editSub;

  String? title;
  DateTime? startDateTime;
  DateTime? endDateTime;
  DateTime? dueDateTime;

  List<SubTaskEntry> currentSubtask = [];
  List<String> newSubtaskTitle = [];

  TaskEntry? currentTask;

  EditTaskState _currentEditState = EditTaskState.view;

  final Uuid _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    context
        .read<TaskBloc>()
        .add(GetSingleTaskEntryEvent(taskID: widget.taskID));

    context.read<SubtaskCubit>().getSubTasksFromTask(widget.taskID);

    _editSub = _editStream.editStateStream.listen(_editSettingReceived);
  }

  @override
  void dispose() {
    _editSub.cancel();
    _editStream.broadCastCurrentPage(EditTaskState.view);
    super.dispose();
  }

  void _editSettingReceived(EditTaskState state) {
    switch (state) {
      case EditTaskState.editing:
        if (currentTask != null) {
          var shouldUpdateTask = false;

          if (title != null && currentTask!.title != title) {
            shouldUpdateTask = true;

            currentTask = currentTask!.copyWith(title: title);
          }
          if (newSubtaskTitle.isNotEmpty) {
            //TODO: Add new Subtask here
            shouldUpdateTask = true;
          }

          if (currentTask!.dueDate != dueDateTime ||
              currentTask!.startDateTime != startDateTime ||
              currentTask!.endDateTime != endDateTime) {
            shouldUpdateTask = true;

            currentTask = currentTask!.copyWith(
              startDateTime: startDateTime,
              endDateTime: endDateTime,
              dueDate: dueDateTime,
            );
          }
          if (shouldUpdateTask) {
            context.read<TaskBloc>().add(
                  EditTaskEntryEvent(
                    params: TaskParams(
                      task: currentTask,
                      taskID: currentTask!.id,
                    ),
                  ),
                );
            print('Reload Task');
            context
                .read<TaskBloc>()
                .add(GetSingleTaskEntryEvent(taskID: widget.taskID));
          }
          _editStream.broadCastCurrentPage(EditTaskState.view);
        }
        break;
      case EditTaskState.edit:
        setState(() {
          _currentEditState = state;
        });
        break;
      default:
        setState(() {
          _currentEditState = EditTaskState.view;
        });
        break;
    }
  }

  final _textfieldPadding = const EdgeInsets.all(8);

  @override
  Widget build(BuildContext context) {
    final _color = StyleUtils.getColorFromString(widget.colorID ?? '#115FFB');
    final _backgroudColor = StyleUtils.lighten(_color, 0.32);
    final _textColor = StyleUtils.darken(_color, colorDarken1);

    final _timeTextStyle = context.h6.copyWith(
      color: _textColor,
      fontWeight: FontWeight.w600,
    );
    final _editTimeTextStyle = context.bodyText1.copyWith(
      color: _textColor,
      fontWeight: FontWeight.w600,
    );
    final _dateTextStyle = context.subtitle1.copyWith(
      color: _textColor,
    );

    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TasksLoaded) {
          if (state.tasks.isNotEmpty) {
            final _fetchedTask = state.tasks.first;

            currentTask ??= _fetchedTask;
            startDateTime ??= _fetchedTask.startDateTime;
            endDateTime ??= _fetchedTask.endDateTime;
            dueDateTime ??= _fetchedTask.dueDate;

            //TODO: Fetch Subtasks
            if (currentSubtask.isEmpty) {}

            if (_currentEditState == EditTaskState.view) {
              //* View Mode
              return _buildViewModeElements(_fetchedTask, context, _textColor,
                  _timeTextStyle, _dateTextStyle);
            }
            //* Edit Mode
            return _buildEditModeElements(_fetchedTask, context, _textColor,
                _editTimeTextStyle, _dateTextStyle);
          }
        }
        return progressIndicator;
      },
    );
  }

  Widget _buildEditModeElements(
      TaskEntry _fetchedTask,
      BuildContext context,
      Color _textColor,
      TextStyle _editTimeTextStyle,
      TextStyle _dateTextStyle) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        //TODO: seperate TextEditingControoler
        PlatformTextField(
          controller: TextEditingController(text: title ?? _fetchedTask.title)
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: _fetchedTask.title?.length ?? 0),
            ),
          onChanged: (text) {
            title = text;
          },
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          material: (context, platform) => materialTextField(),
          cupertino: (context, platform) => cupertinoTextField(),
          style: context.h4.copyWith(
            fontWeight: FontWeight.w500,
            color: _textColor,
          ),
        ),
        verticalSpaceMedium,
        //* Edit Start & End DateTime
        _buildEditDateTimeCell(startDateTime!.toLocal(), _editTimeTextStyle,
                DateTimeSelected.start)
            .gestures(
          onTap: () {
            Platform.isIOS
                ? _cupertinoDateTimePicker(
                    context,
                    startDateTime!.toLocal(),
                    DateTimeSelected.start,
                  )
                : _materialDateTimePicker(context);
          },
        ),
        Text('Until', style: _dateTextStyle)
            .alignment(Alignment.center)
            .padding(vertical: 4),
        _buildEditDateTimeCell(endDateTime!.toLocal(), _editTimeTextStyle,
                DateTimeSelected.end)
            .gestures(
          onTap: () {
            Platform.isIOS
                ? _cupertinoDateTimePicker(
                    context, endDateTime!.toLocal(), DateTimeSelected.end)
                : _materialDateTimePicker(context);
          },
        ),
        //* Edit Due Date
        if (_fetchedTask.dueDate != null)
          [
            _buildEditDateTimeCell(
              dueDateTime!,
              _editTimeTextStyle,
              DateTimeSelected.due,
            ).gestures(
              onTap: () {
                Platform.isIOS
                    ? _cupertinoDateTimePicker(
                        context, endDateTime!, DateTimeSelected.due)
                    : _materialDateTimePicker(context);
              },
            ),
            Text('Due Date', style: _dateTextStyle).padding(top: 4),
          ].toColumn(mainAxisSize: MainAxisSize.min).padding(top: 24),
        verticalSpaceMedium,
        _buildSubTaskEditTextField(context, 'sub task 1', 0, _textColor),
        _buildSubTaskEditTextField(context, 'sub task 2', 0, _textColor),

        //* Subtask Text Field
        currentSubtask
            .map((subtask) => _buildSubTaskEditTextField(
                context,
                subtask.title ?? '',
                currentSubtask.indexOf(subtask),
                _textColor))
            .toList()
            .toColumn(),
        verticalSpaceRegular,
        PlatformButton(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
          onPressed: () {},
          child: Text('Delete Task',
              style: context.bodyText2.copyWith(color: kcError500)),
        ),
      ],
    );
  }

  Widget _buildSubTaskEditTextField(
      BuildContext context, String title, int elementIdx, Color? textColor) {
    return PlatformTextField(
      controller: TextEditingController(text: title)
        ..selection = TextSelection.fromPosition(
          TextPosition(offset: title.length),
        ),
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
      material: (context, platform) => materialTextField(),
      cupertino: (context, platform) => cupertinoTextField(),
      style: context.caption.copyWith(color: textColor),
    ).padding(vertical: 4);
  }

  Widget _buildEditDateTimeCell(
      DateTime dateTime, TextStyle textStyle, DateTimeSelected type) {
    final _date = CustomDateUtils.returnDateWithDay(dateTime);
    final _time = type != DateTimeSelected.due
        ? ' at ${CustomDateUtils.returnTime(dateTime)}'
        : '';
    final _color = StyleUtils.getColorFromString(widget.colorID ?? '#115FFB');
    final _backgroudColor = StyleUtils.lighten(_color, 0.32);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _backgroudColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Text(
        '$_date$_time',
        textAlign: TextAlign.center,
        style: textStyle,
      ),
    );
  }

  Widget _buildViewModeElements(TaskEntry _fetchedTask, BuildContext context,
      Color _textColor, TextStyle _timeTextStyle, TextStyle _dateTextStyle) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          _fetchedTask.title ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.h4.copyWith(
            fontWeight: FontWeight.w600,
            color: _textColor,
          ),
        ).alignment(Alignment.center),
        verticalSpaceMedium,
        //Start and End DateTime
        EditDateTimeCell(
          fetchedTask: _fetchedTask,
          colorID: widget.colorID,
        ),
        if (_fetchedTask.dueDate != null)
          [
            Text(
              CustomDateUtils.returnDateAndMonth(
                  _fetchedTask.dueDate!.toLocal()),
              style: _timeTextStyle,
            ),
            Text('Due Date', style: _dateTextStyle),
          ].toColumn(mainAxisSize: MainAxisSize.min).padding(top: 16),
        verticalSpaceRegular,
        BlocBuilder<SubtaskCubit, SubtaskState>(
          builder: (context, state) {
            return state.when<Widget>(
              initial: () => progressIndicator,
              loaded: (subtasks) {
                if (subtasks.isNotEmpty) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: subtasks
                        .map(
                          (subtask) => SlidableSubTaskItem(
                            key: Key(subtask.id),
                            colorID: widget.colorID,
                            subTask: SubTaskEntry(
                              id: subtask.id,
                              isCompleted: subtask.isCompleted,
                              taskID: subtask.taskID,
                              title: subtask.title,
                            ),
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
              error: (errorMessage) => MessageDisplay(message: errorMessage),
            );
          },
        ),

        //* Adding new Subtask
        if (newSubtaskTitle.isNotEmpty) verticalSpaceTiny,
        if (newSubtaskTitle.isNotEmpty)
          newSubtaskTitle
              .map((text) => _buildSubTaskViewTextField(
                  context, text, newSubtaskTitle.indexOf(text)))
              .toList()
              .toColumn()
              .padding(horizontal: 8),
        verticalSpaceSmall,
        PlatformIconButton(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          materialIcon: Icon(Icons.add, color: _textColor),
          cupertinoIcon: Icon(CupertinoIcons.add, color: _textColor),
          onPressed: () {
            setState(() {
              newSubtaskTitle.add('');
            });
          },
        ).paddingDirectional(horizontal: 8),
        verticalSpaceSmall,
        PlatformButton(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
          onPressed: () {},
          child: Text('Mark Task as Completed',
              style: context.bodyText2.copyWith(color: kcSuccess500)),
        ).paddingDirectional(horizontal: 8)
      ],
    );
  }

  Widget _buildSubTaskViewTextField(
      BuildContext context, String title, int elementIdx) {
    final _textColor = kcPrimary500;

    return PlatformTextField(
      controller: TextEditingController(text: title)
        ..selection = TextSelection.fromPosition(
          TextPosition(offset: title.length),
        ),
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
      onChanged: (text) {
        newSubtaskTitle[elementIdx] = text;
      },
      material: (context, platform) =>
          materialTextField(customPadding: const EdgeInsets.all(16)),
      cupertino: (context, platform) =>
          cupertinoTextField(customPadding: const EdgeInsets.all(16)),
      style: context.subtitle1.copyWith(color: _textColor),
    ).padding(vertical: 4);
  }

  Widget _materialDateTimePicker(BuildContext context) {
    //TODO:
    return Container();
  }

  void _cupertinoDateTimePicker(
    BuildContext context,
    DateTime currentDateTime,
    DateTimeSelected type,
  ) {
    showModalBottomSheet<dynamic>(
      context: context,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: context.colorScheme.primaryVariant),
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      builder: (BuildContext builder) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: [
                  PlatformButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      if (type == DateTimeSelected.start) {
                        final _diff = endDateTime!.difference(startDateTime!);
                        startDateTime = currentDateTime;
                        endDateTime = currentDateTime + _diff;
                      } else if (type == DateTimeSelected.end) {
                        endDateTime = currentDateTime;
                      } else {
                        dueDateTime = currentDateTime;
                      }
                      context.router.pop();
                    },
                  ),
                  PlatformButton(
                    child: const Text('Save'),
                    onPressed: () {
                      setState(() {});
                      context.router.pop();
                    },
                  ),
                ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)),
            SizedBox(
              height: MediaQuery.of(context).copyWith().size.height / 3.8,
              child: CupertinoDatePicker(
                mode: type != DateTimeSelected.due
                    ? CupertinoDatePickerMode.dateAndTime
                    : CupertinoDatePickerMode.date,
                onDateTimeChanged: (picked) {
                  if (picked != currentDateTime) {
                    if (type == DateTimeSelected.start) {
                      final _diff = endDateTime!.difference(startDateTime!);
                      startDateTime = picked;
                      endDateTime = picked + _diff;
                    } else if (type == DateTimeSelected.end) {
                      endDateTime = picked;
                    } else {
                      dueDateTime = picked;
                    }
                  }
                },
                initialDateTime: currentDateTime,
                minimumYear: 2020,
                maximumYear: 2025,
              ),
            ).padding(bottom: 4),
          ],
        );
      },
    );
  }

  CupertinoTextFieldData cupertinoTextField(
      {EdgeInsetsGeometry? customPadding}) {
    final _color = StyleUtils.getColorFromString(widget.colorID ?? '#115FFB');
    final _backgroudColor = StyleUtils.lighten(_color, 0.32);

    return CupertinoTextFieldData(
      padding: customPadding ?? _textfieldPadding,
      decoration: BoxDecoration(
        color: _backgroudColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
    );
  }

  MaterialTextFieldData materialTextField({EdgeInsetsGeometry? customPadding}) {
    return MaterialTextFieldData(
      decoration: InputDecoration(
        contentPadding: customPadding ?? _textfieldPadding,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}
