import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/presentation/widgets/edit_page_widgets/edit_datetime_cell.dart';
import 'package:refocus_app/core/presentation/widgets/edit_page_widgets/slidable_subtask_item.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/presentation/bloc/cubit/subtask_cubit.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:uuid/uuid.dart';

class DetailTaskView extends StatefulWidget {
  const DetailTaskView({Key? key, this.taskID, this.colorID, this.task})
      : super(key: key);

  final String? taskID;
  final String? colorID;
  final TaskEntry? task;

  @override
  State<DetailTaskView> createState() => _DetailTaskViewState();
}

class _DetailTaskViewState extends State<DetailTaskView> {
  late TextEditingController _newSubTaskController;
  final FocusNode _focusNode = FocusNode();
  String? newSubTask;
  final Uuid _uuid = const Uuid();

  bool _showCompleted = false;

  @override
  void initState() {
    super.initState();
    _newSubTaskController = TextEditingController();
    if (this.mounted) {
      if (widget.taskID != null) {
        context
            .read<TaskBloc>()
            .add(GetSingleTaskEntryEvent(taskID: widget.taskID!));

        context.read<SubtaskCubit>().getSubTasksFromTask(widget.taskID!);
      } else if (widget.task != null) {
        context.read<SubtaskCubit>().getSubTasksFromTask(widget.task!.id);
      }
    }
  }

  @override
  void dispose() {
    _focusNode.unfocus();
    _newSubTaskController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _color = StyleUtils.getColorFromString(widget.colorID ?? '#115FFB');
    final _textColor = StyleUtils.darken(_color);

    final _timeTextStyle = context.h6.copyWith(
      color: _textColor,
      fontWeight: FontWeight.w600,
    );
    final _dateTextStyle = context.subtitle1.copyWith(
      color: _textColor,
    );

    if (widget.task != null) {
      return _buildListView(
          widget.task!, context, _textColor, _timeTextStyle, _dateTextStyle);
    } else {
      return BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TasksLoaded) {
            if (state.tasks.isNotEmpty) {
              final _fetchedTask = state.tasks.first;

              return _buildListView(_fetchedTask, context, _textColor,
                  _timeTextStyle, _dateTextStyle);
            }
          }
          return progressIndicator;
        },
      );
    }
  }

  ListView _buildListView(TaskEntry _fetchedTask, BuildContext context,
      Color _textColor, TextStyle _timeTextStyle, TextStyle _dateTextStyle) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 24),
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

        verticalSpaceLarge,

        //* Get SubTasks
        BlocBuilder<SubtaskCubit, SubtaskState>(
          builder: (context, state) {
            return state.when<Widget>(
              initial: () => progressIndicator,
              loaded: (subtasks) {
                if (subtasks.isNotEmpty) {
                  final _notCompletedSubTasks = subtasks
                      .filter((_subtask) => !_subtask.isCompleted)
                      .toList();
                  final _completedSubTasks = subtasks
                      .filter((_subtask) => _subtask.isCompleted)
                      .toList();
                  return Column(
                    children: [
                      _notCompletedSubTasks
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
                          .toList()
                          .toColumn(mainAxisSize: MainAxisSize.min),
                      verticalSpaceSmall,
                      Material(
                        color: Colors.transparent,
                        child: ChoiceChip(
                          label: Text(
                            'Completed: ${_completedSubTasks.length}', //${_showCompleted ? ' ▼' : ''}
                            style: context.caption,
                          ),
                          selected: _showCompleted,
                          onSelected: _completedSubTasks.isNotEmpty
                              ? (value) {
                                  setState(() {
                                    _showCompleted = value;
                                  });
                                }
                              : null,
                        ),
                      ),
                      if (_showCompleted)
                        _completedSubTasks
                            .map((subtask) => SlidableSubTaskItem(
                                  key: Key(subtask.id),
                                  colorID: widget.colorID,
                                  subTask: SubTaskEntry(
                                    id: subtask.id,
                                    isCompleted: subtask.isCompleted,
                                    taskID: subtask.taskID,
                                    title: subtask.title,
                                  ),
                                ))
                            .toList()
                            .toColumn(mainAxisSize: MainAxisSize.min)
                    ],
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
        if (newSubTask != null) ...[
          PlatformTextField(
            focusNode: _focusNode,
            controller: _newSubTaskController,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            onChanged: (text) {
              if (newSubTask != null) {
                newSubTask = text;
              }
            },
            autofocus: true,
            onEditingComplete: () {},
            onSubmitted: (p0) {
              _focusNode.unfocus();
            },
            material: (_, platform) => materialTextField(
              customPadding: const EdgeInsets.all(16),
              shouldShowIcon: newSubTask != null,
            ),
            cupertino: (_, platform) => cupertinoTextField(
              customPadding: const EdgeInsets.all(16),
              shouldShowIcon: newSubTask != null,
            ),
          ).padding(vertical: 4, horizontal: 8),
          verticalSpaceTiny,
        ],
        verticalSpaceSmall,
        if (newSubTask == null)
          PlatformIconButton(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            materialIcon: Icon(Icons.add, color: _textColor),
            cupertinoIcon: Icon(CupertinoIcons.add, color: _textColor),
            onPressed: () => setState(() => newSubTask = ''),
          ).paddingDirectional(horizontal: 8),
        verticalSpaceMedium,
        PlatformButton(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
          onPressed: () {},
          child: Text('Mark Task as Completed',
              style: context.bodyText2.copyWith(color: kcSuccess500)),
        ).paddingDirectional(horizontal: 8)
      ],
    );
  }

  final _textfieldPadding = const EdgeInsets.all(8);

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
                    taskID: widget.taskID ?? widget.task!.id,
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
                        taskID: widget.taskID ?? widget.task!.id,
                        title: newSubTask,
                        priority: 0,
                      ));
                  newSubTask = null;
                  FocusScope.of(context).unfocus();
                })
              : null,
        ));
  }
}
