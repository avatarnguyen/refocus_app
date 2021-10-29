import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/message_widget.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';
import 'package:refocus_app/features/task/presentation/bloc/cubit/subtask_cubit.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/features/today/domain/today_entry.dart';
import 'package:uuid/uuid.dart';

enum DateTimeSelected { start, end, due }

class EditTaskView extends StatefulWidget {
  const EditTaskView({
    Key? key,
    this.taskID,
    this.colorID,
    this.modalScrollController,
    this.task,
    this.subTask,
    this.entry,
  }) : super(key: key);

  final String? taskID;
  final String? colorID;
  final TodayEntry? entry;
  final TaskEntry? task;
  final List<SubTaskEntry>? subTask;
  final ScrollController? modalScrollController;

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  // final EditTaskStream _editStream = getIt<EditTaskStream>();
  // late StreamSubscription<EditTaskState> _editSub;

  String? _title;
  DateTime? _startDateTime;
  DateTime? _endDateTime;
  DateTime? _dueDateTime;
  String? _calendarID;

  Map<String, SubTaskEntry> editedSubTasks = {};
  String? newSubTask;

  TaskEntry? currentTask;

  // EditTaskState _currentEditState = EditTaskState.view;

  final Uuid _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    if (widget.entry != null) {
      _title = widget.entry!.title;
      _startDateTime ??= widget.entry!.startDateTime;
      _endDateTime ??= widget.entry!.endDateTime;
      _calendarID = widget.entry!.projectOrCalID;
    } else if (widget.task != null) {
      currentTask ??= widget.task;
      _startDateTime ??= widget.task!.startDateTime;
      _endDateTime ??= widget.task!.endDateTime;
      _dueDateTime ??= widget.task!.dueDate;
    } else {
      context
          .read<TaskBloc>()
          .add(GetSingleTaskEntryEvent(taskID: widget.taskID!));

      context.read<SubtaskCubit>().getSubTasksFromTask(widget.taskID!);
    }
  }

  final _textfieldPadding = const EdgeInsets.all(8);

  @override
  Widget build(BuildContext context) {
    final _color = StyleUtils.getColorFromString(widget.colorID ?? '#115FFB');
    final _backgroudColor = StyleUtils.lighten(_color, 0.32);
    final _textColor = StyleUtils.darken(_color, kcdarker2);

    final _timeTextStyle = context.h6.copyWith(
      color: _textColor,
      fontWeight: FontWeight.w600,
    );

    return PlatformScaffold(
      backgroundColor: context.backgroundColor,
      appBar: PlatformAppBar(
        trailingActions: [
          PlatformButton(
            padding: EdgeInsets.zero,
            onPressed: _saveEditedTask,
            child: const Text('Save'),
          ),
        ],
      ),
      body: widget.entry != null
          ? _buildListViewContent(context, _textColor, eventEntry: widget.entry)
          : widget.task != null
              ? _buildListViewContent(
                  context,
                  _textColor,
                  fetchedTask: widget.task,
                )
              : BlocBuilder<TaskBloc, TaskState>(
                  builder: (_, state) {
                    if (state is TasksLoaded) {
                      if (state.tasks.isNotEmpty) {
                        final _fetchedTask = state.tasks.first;

                        currentTask ??= _fetchedTask;
                        _startDateTime ??= _fetchedTask.startDateTime;
                        _endDateTime ??= _fetchedTask.endDateTime;
                        _dueDateTime ??= _fetchedTask.dueDate;

                        return _buildListViewContent(
                          context,
                          _textColor,
                          fetchedTask: _fetchedTask,
                        );
                      }
                    }
                    return progressIndicator;
                  },
                ),
    );
  }

  Widget _buildListViewContent(
    BuildContext context,
    Color _textColor, {
    TaskEntry? fetchedTask,
    TodayEntry? eventEntry,
  }) {
    final _editTimeTextStyle = context.bodyText1.copyWith(
      color: _textColor,
      fontWeight: FontWeight.w600,
    );
    final _dateTextStyle = context.subtitle1.copyWith(
      color: _textColor,
    );

    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        controller: widget.modalScrollController,
        padding: const EdgeInsets.all(16),
        children: [
          Text('Title',
              textAlign: TextAlign.center,
              style: context.subtitle1.copyWith(
                color: _textColor,
              )).padding(top: 6, bottom: 4),

          PlatformTextField(
            controller: TextEditingController(
                text: _title ?? fetchedTask?.title)
              ..selection = TextSelection.fromPosition(
                TextPosition(
                    offset: _title?.length ?? fetchedTask?.title?.length ?? 0),
              ),
            onChanged: (text) {
              _title = text;
            },
            onSubmitted: (p0) {},
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            material: (context, platform) => materialTextField(),
            cupertino: (context, platform) => cupertinoTextField(),
            style: context.h4
                .copyWith(fontWeight: FontWeight.w500, color: _textColor),
          ),

          verticalSpaceMedium,
          //* Edit Start & End DateTime
          if (_startDateTime != null)
            _buildEditDateTimeCell(
              _startDateTime!.toLocal(),
              _editTimeTextStyle,
              DateTimeSelected.start,
            ).gestures(
              onTap: () {
                Platform.isIOS
                    ? _cupertinoDateTimePicker(
                        context,
                        _startDateTime!.toLocal(),
                        DateTimeSelected.start,
                      )
                    : _materialDateTimePicker(context);
              },
            ),
          if (_endDateTime != null) ...[
            Text('Until', style: _dateTextStyle)
                .alignment(Alignment.center)
                .padding(vertical: 4),
            _buildEditDateTimeCell(
              _endDateTime!.toLocal(),
              _editTimeTextStyle,
              DateTimeSelected.end,
            ).gestures(
              onTap: () {
                Platform.isIOS
                    ? _cupertinoDateTimePicker(
                        context,
                        _endDateTime!.toLocal(),
                        DateTimeSelected.end,
                      )
                    : _materialDateTimePicker(context);
              },
            ),
          ],

          if (eventEntry != null) ...[
            verticalSpaceMedium,
            Text('Calendar', style: _dateTextStyle)
                .alignment(Alignment.center)
                .padding(vertical: 4),
            _buildCalendarSelection(_editTimeTextStyle)
          ],

          //* Edit Due Date
          if (fetchedTask?.dueDate != null)
            [
              _buildEditDateTimeCell(
                _dueDateTime!,
                _editTimeTextStyle,
                DateTimeSelected.due,
              ).gestures(
                onTap: () {
                  Platform.isIOS
                      ? _cupertinoDateTimePicker(
                          context,
                          _endDateTime!,
                          DateTimeSelected.due,
                        )
                      : _materialDateTimePicker(context);
                },
              ),
              Text('Due Date', style: _dateTextStyle).padding(top: 4),
            ].toColumn(mainAxisSize: MainAxisSize.min).padding(top: 24),
          verticalSpaceMedium,

          //* Get SubTasks
          if (fetchedTask != null)
            if (widget.subTask != null)
              widget.subTask!
                  .map((subtask) => _buildSubTaskEditTextField(
                        context,
                        subtask,
                        _textColor,
                      ))
                  .toList()
                  .toColumn(mainAxisSize: MainAxisSize.min)
            else
              BlocBuilder<SubtaskCubit, SubtaskState>(
                builder: (context, state) {
                  return state.when<Widget>(
                    initial: () => progressIndicator,
                    loaded: (_subtasks) {
                      if (_subtasks.isNotEmpty) {
                        return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: _subtasks
                                .map((subtask) => _buildSubTaskEditTextField(
                                      context,
                                      subtask,
                                      _textColor,
                                    ))
                                .toList());
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                    error: (errorMessage) =>
                        MessageDisplay(message: errorMessage),
                  );
                },
              ),

          verticalSpaceRegular,
          if (newSubTask != null) ...[
            _buildCreateSubTaskTextField(context, newSubTask!),
            verticalSpaceTiny,
          ],
          verticalSpaceSmall,
          if (fetchedTask != null && newSubTask == null)
            PlatformIconButton(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              materialIcon: Icon(Icons.add, color: _textColor),
              cupertinoIcon: Icon(CupertinoIcons.add, color: _textColor),
              onPressed: () => setState(() {
                newSubTask = '';
              }),
            ),
          verticalSpaceMedium,
          if (fetchedTask != null)
            PlatformButton(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
              child: Text('Delete Task',
                  style: context.bodyText2.copyWith(color: kcError500)),
              onPressed: () {
                //TODO: Delete Task
              },
            ),
        ],
      ),
    );
  }

  Widget _buildSubTaskEditTextField(
      BuildContext context, SubTaskEntry subTaskEntry, Color? textColor) {
    return PlatformTextField(
      controller: TextEditingController(text: subTaskEntry.title)
        ..selection = TextSelection.fromPosition(
          TextPosition(offset: subTaskEntry.title?.length ?? 0),
        ),
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
      material: (context, platform) => materialTextField(),
      cupertino: (context, platform) => cupertinoTextField(),
      style: context.caption.copyWith(color: textColor),
      onChanged: (text) {
        final _subTaskID = subTaskEntry.id;
        editedSubTasks[_subTaskID] = subTaskEntry.copyWith(title: text);
      },
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

  Widget _buildCalendarSelection(TextStyle textStyle) {
    final _color = StyleUtils.getColorFromString(widget.colorID ?? '#115FFB');
    final _backgroudColor = StyleUtils.lighten(_color, 0.32);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _backgroudColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: BlocBuilder<CalendarListBloc, CalendarListState>(
        builder: (context, state) {
          if (state is Loaded) {
            final _calList = state.calendarList;
            final _currentCal =
                _calList.singleWhere((_cal) => _cal.id == _calendarID);
            return Text(
              _currentCal.name,
              textAlign: TextAlign.center,
              style: textStyle,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildCreateSubTaskTextField(BuildContext context, String title) {
    return PlatformTextField(
      controller: TextEditingController(text: title)
        ..selection = TextSelection.fromPosition(
          TextPosition(offset: title.length),
        ),
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
      onChanged: (text) {
        if (newSubTask != null) {
          newSubTask = text;
        }
      },
      material: (context, platform) => materialTextField(
        customPadding: const EdgeInsets.all(16),
        shouldShowIcon: newSubTask != null,
      ),
      cupertino: (context, platform) => cupertinoTextField(
        customPadding: const EdgeInsets.all(16),
        shouldShowIcon: newSubTask != null,
      ),
    ).padding(vertical: 4);
  }

  CupertinoTextFieldData cupertinoTextField(
      {EdgeInsetsGeometry? customPadding, bool? shouldShowIcon}) {
    final _color = StyleUtils.getColorFromString(widget.colorID ?? '#115FFB');
    final _backgroudColor = StyleUtils.lighten(_color, 0.32);
    final _textColor = StyleUtils.darken(_color, 0.32);

    return CupertinoTextFieldData(
      padding: customPadding ?? _textfieldPadding,
      decoration: BoxDecoration(
        color: _backgroudColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      style: context.subtitle1.copyWith(color: _textColor),
      suffix: shouldShowIcon != null && shouldShowIcon
          ? Icon(
              Icons.send,
              color: _textColor,
            ).padding(right: 8).gestures(onTap: () {
              context.read<SubtaskCubit>().createNewSubtask(SubTaskEntry(
                    id: _uuid.v1(),
                    isCompleted: false,
                    taskID: widget.task?.id ?? widget.taskID!,
                    title: newSubTask,
                    priority: 0,
                  ));
              newSubTask = null;
              FocusScope.of(context).unfocus();
            })
          : null,
    );
  }

  MaterialTextFieldData materialTextField(
      {EdgeInsetsGeometry? customPadding, bool? shouldShowIcon}) {
    final _color = StyleUtils.getColorFromString(widget.colorID ?? '#115FFB');
    final _backgroudColor = StyleUtils.lighten(_color, 0.32);
    final _textColor = StyleUtils.darken(_color, 0.32);

    return MaterialTextFieldData(
        style: context.subtitle1.copyWith(color: _textColor),
        decoration: InputDecoration(
          contentPadding: customPadding ?? _textfieldPadding,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          fillColor: _backgroudColor,
          suffix: shouldShowIcon != null && shouldShowIcon
              ? Icon(
                  Icons.send,
                  color: _textColor,
                ).padding(right: 8).gestures(onTap: () {
                  context.read<SubtaskCubit>().createNewSubtask(SubTaskEntry(
                        id: _uuid.v1(),
                        isCompleted: false,
                        taskID: widget.task?.id ?? widget.taskID!,
                        title: newSubTask,
                        priority: 0,
                      ));
                  newSubTask = null;
                  FocusScope.of(context).unfocus();
                })
              : null,
        ));
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
        return SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.of(context).copyWith().size.height / 3.8,
                child: CupertinoDatePicker(
                  mode: type != DateTimeSelected.due
                      ? CupertinoDatePickerMode.dateAndTime
                      : CupertinoDatePickerMode.date,
                  onDateTimeChanged: (picked) {
                    if (picked != currentDateTime) {
                      if (type == DateTimeSelected.start) {
                        final _diff = _endDateTime!.difference(_startDateTime!);
                        _startDateTime = picked;
                        _endDateTime = picked + _diff;
                      } else if (type == DateTimeSelected.end) {
                        _endDateTime = picked;
                      } else {
                        _dueDateTime = picked;
                      }
                    }
                  },
                  initialDateTime: currentDateTime,
                  minimumYear: 2020,
                  maximumYear: 2025,
                ),
              ).padding(bottom: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: [
                  PlatformTextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      if (type == DateTimeSelected.start) {
                        final _diff = _endDateTime!.difference(_startDateTime!);
                        _startDateTime = currentDateTime;
                        _endDateTime = currentDateTime + _diff;
                      } else if (type == DateTimeSelected.end) {
                        _endDateTime = currentDateTime;
                      } else {
                        _dueDateTime = currentDateTime;
                      }
                      context.router.pop();
                    },
                  ),
                  PlatformButton(
                    color: context.colorScheme.primary,
                    child: 'Save'.toButtonText(),
                    onPressed: () {
                      setState(() {});
                      context.router.pop();
                    },
                  ),
                ].toRow(mainAxisAlignment: MainAxisAlignment.spaceEvenly),
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveEditedTask() {
    if (currentTask != null) {
      var shouldUpdateTask = false;

      if (_title != null && currentTask!.title != _title) {
        shouldUpdateTask = true;

        currentTask = currentTask!.copyWith(title: _title);
      }

      if (currentTask!.dueDate != _dueDateTime ||
          currentTask!.startDateTime != _startDateTime ||
          currentTask!.endDateTime != _endDateTime) {
        shouldUpdateTask = true;

        currentTask = currentTask!.copyWith(
          startDateTime: _startDateTime,
          endDateTime: _endDateTime,
          dueDate: _dueDateTime,
        );
      }

      if (editedSubTasks.isNotEmpty) {
        editedSubTasks.forEach((key, subtask) {
          context.read<SubtaskCubit>().createNewSubtask(subtask);
        });
        editedSubTasks.clear();
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
        // context.read<TaskBloc>().add(
        //     GetSingleTaskEntryEvent(taskID: widget.task?.id ?? widget.taskID!));
        context.router.pop(currentTask);
      } else {
        context.router.pop();
      }
    }
  }
}
