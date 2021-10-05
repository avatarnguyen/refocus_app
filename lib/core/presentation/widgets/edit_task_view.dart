import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:refocus_app/core/presentation/helper/edit_task_stream.dart';
import 'package:refocus_app/core/presentation/helper/setting_option.dart';
import 'package:refocus_app/core/presentation/widgets/edit_datetime_cell.dart';
import 'package:refocus_app/core/presentation/widgets/slidable_subtask_item.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/injection.dart';

enum DateTimeSelected { start, end, due }

class EditTaskView extends StatefulWidget {
  const EditTaskView({Key? key, required this.taskID}) : super(key: key);

  final String taskID;

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  final EditTaskStream _editStream = getIt<EditTaskStream>();

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(
          GetSingleTaskEntryEvent(taskID: widget.taskID),
        );
  }

  @override
  void dispose() {
    _editStream.broadCastCurrentPage(false);
    super.dispose();
  }

  DateTime? startDateTime;
  DateTime? endDateTime;
  DateTime? dueDateTime;

  List<String> newSubTask = [];

  final _textfieldPadding = const EdgeInsets.all(8);

  @override
  Widget build(BuildContext context) {
    final _textColor = kcPrimary500;

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

            // ignore: prefer_conditional_assignment
            if (startDateTime == null) {
              startDateTime = _fetchedTask.startDateTime;
            }
            // ignore: prefer_conditional_assignment
            if (endDateTime == null) {
              endDateTime = _fetchedTask.endDateTime;
            }
            // ignore: prefer_conditional_assignment
            if (dueDateTime == null) {
              dueDateTime = _fetchedTask.dueDate;
            }

            return StreamBuilder<bool>(
                stream: _editStream.editStateStream,
                builder: (context, snapshot) {
                  if (snapshot.data != null && snapshot.data!) {
                    //* Edit Mode
                    return _buildEditModeElements(_fetchedTask, context,
                        _textColor, _editTimeTextStyle, _dateTextStyle);
                  }
                  //* View Mode
                  return _buildViewModeElements(_fetchedTask, context,
                      _textColor, _timeTextStyle, _dateTextStyle);
                });
          } else {
            return const MessageDisplay(message: '');
          }
        } else {
          return progressIndicator;
        }
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
        PlatformTextField(
          controller: TextEditingController(text: _fetchedTask.title)
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: _fetchedTask.title?.length ?? 0),
            ),
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
        _buildEditDateTimeCell(
                startDateTime!, _editTimeTextStyle, DateTimeSelected.start)
            .gestures(
          onTap: () {
            Platform.isIOS
                ? _cupertinoDateTimePicker(
                    context,
                    startDateTime!,
                    DateTimeSelected.start,
                  )
                : _materialDateTimePicker(context);
          },
        ).padding(bottom: 8),
        _buildEditDateTimeCell(
                endDateTime!, _editTimeTextStyle, DateTimeSelected.end)
            .gestures(
          onTap: () {
            Platform.isIOS
                ? _cupertinoDateTimePicker(
                    context,
                    endDateTime!,
                    DateTimeSelected.end,
                  )
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
                        context,
                        endDateTime!,
                        DateTimeSelected.due,
                      )
                    : _materialDateTimePicker(context);
              },
            ),
            Text('Due Date', style: _dateTextStyle).padding(top: 4),
          ].toColumn(mainAxisSize: MainAxisSize.min).padding(top: 24),
        verticalSpaceMedium,
        _buildSubTaskEditTextField(context, 'sub task 1', 0),
        _buildSubTaskEditTextField(context, 'sub task 2', 0),
        newSubTask
            .map((text) => _buildSubTaskEditTextField(
                context, text, newSubTask.indexOf(text)))
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
      BuildContext context, String title, int elementIdx) {
    final _textColor = kcPrimary500;

    return PlatformTextField(
      controller: TextEditingController(text: title)
        ..selection = TextSelection.fromPosition(
          TextPosition(offset: title.length),
        ),
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
      material: (context, platform) => materialTextField(),
      cupertino: (context, platform) => cupertinoTextField(),
      style: context.caption.copyWith(color: _textColor),
    ).padding(vertical: 4);
  }

  Widget _buildEditDateTimeCell(
      DateTime dateTime, TextStyle textStyle, DateTimeSelected type) {
    final _date = CustomDateUtils.returnDateWithDay(dateTime);
    final _time = type != DateTimeSelected.due
        ? ' at ${CustomDateUtils.returnTime(dateTime)}'
        : '';

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: kcPrimary100,
        borderRadius: BorderRadius.all(Radius.circular(8)),
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
        EditDateTimeCell(fetchedTask: _fetchedTask),
        if (_fetchedTask.dueDate != null)
          [
            Text(
              CustomDateUtils.returnDateAndMonth(_fetchedTask.dueDate!),
              style: _timeTextStyle,
            ),
            Text('Due Date', style: _dateTextStyle),
          ].toColumn(mainAxisSize: MainAxisSize.min).padding(top: 16),
        verticalSpaceRegular,
        SlidableSubTaskItem(
          key: const Key('slide_subtask_1'),
          subTask: SubTaskEntry(
            id: '12345',
            isCompleted: false,
            todoID: _fetchedTask.id,
            title: 'Sub Task 1',
          ),
        ),
        SlidableSubTaskItem(
          key: const Key('slide_subtask_2'),
          subTask: SubTaskEntry(
            id: '2134',
            isCompleted: true,
            todoID: _fetchedTask.id,
            title: 'Sub Task 1',
          ),
        ),
        //Adding new Subtask
        if (newSubTask.isNotEmpty) verticalSpaceTiny,
        if (newSubTask.isNotEmpty)
          newSubTask
              .map((text) => _buildSubTaskViewTextField(
                  context, text, newSubTask.indexOf(text)))
              .toList()
              .toColumn()
              .padding(horizontal: 8),
        verticalSpaceSmall,
        PlatformIconButton(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          materialIcon: Icon(
            Icons.add,
            color: _textColor,
          ),
          cupertinoIcon: Icon(
            CupertinoIcons.add,
            color: _textColor,
          ),
          onPressed: () {
            setState(() {
              newSubTask.add('');
            });
          },
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
        newSubTask[elementIdx] = text;
      },
      material: (context, platform) =>
          materialTextField(customPadding: const EdgeInsets.all(16)),
      cupertino: (context, platform) =>
          cupertinoTextField(customPadding: const EdgeInsets.all(16)),
      style: context.subtitle1.copyWith(
        color: _textColor,
      ),
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
    return CupertinoTextFieldData(
      padding: customPadding ?? _textfieldPadding,
      decoration: const BoxDecoration(
        color: kcPrimary100,
        borderRadius: BorderRadius.all(Radius.circular(8)),
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
