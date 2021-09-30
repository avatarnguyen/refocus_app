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
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/injection.dart';

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

  final _textfieldPadding = const EdgeInsets.all(8);

  @override
  Widget build(BuildContext context) {
    final _textColor = kcPrimary500;

    final _timeTextStyle = context.h6.copyWith(
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
            return StreamBuilder<bool>(
                stream: _editStream.editStateStream,
                builder: (context, snapshot) {
                  if (snapshot.data != null && snapshot.data!) {
                    return ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        children: [
                          PlatformTextField(
                            controller: TextEditingController(
                                text: _fetchedTask.title)
                              ..selection = TextSelection.fromPosition(
                                TextPosition(
                                    offset: _fetchedTask.title?.length ?? 0),
                              ),
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            material: (context, platform) =>
                                materialTextField(),
                            cupertino: (context, platform) =>
                                cupertinoTextField(),
                            style: context.h4.copyWith(
                              fontWeight: FontWeight.w500,
                              color: _textColor,
                            ),
                          ),
                          verticalSpaceMedium,
                          EditDateTimeCell(fetchedTask: _fetchedTask),
                          if (_fetchedTask.dueDate != null)
                            [
                              Text(
                                CustomDateUtils.returnDateAndMonth(
                                    _fetchedTask.dueDate!),
                                style: _timeTextStyle,
                              ),
                              Text(
                                'Due Date',
                                style: _dateTextStyle,
                              ),
                            ].toColumn(),
                          verticalSpaceMedium,
                          PlatformTextField(
                            controller: TextEditingController(
                                text: 'sub task 1')
                              ..selection = TextSelection.fromPosition(
                                TextPosition(offset: 'sub task 1'.length ?? 0),
                              ),
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            material: (context, platform) =>
                                materialTextField(),
                            cupertino: (context, platform) =>
                                cupertinoTextField(),
                            style: context.caption.copyWith(
                              // fontWeight: FontWeight.w500,
                              color: _textColor,
                            ),
                          ).padding(vertical: 4),
                          PlatformTextField(
                            controller: TextEditingController(
                                text: 'sub task 2')
                              ..selection = TextSelection.fromPosition(
                                TextPosition(offset: 'sub task 1'.length ?? 0),
                              ),
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            material: (context, platform) =>
                                materialTextField(),
                            cupertino: (context, platform) =>
                                cupertinoTextField(),
                            style: context.caption.copyWith(
                              // fontWeight: FontWeight.w500,
                              color: _textColor,
                            ),
                          ).padding(vertical: 4),
                          verticalSpaceRegular,
                          PlatformButton(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 32),
                            onPressed: () {},
                            child: Text('Delete Task',
                                style: context.bodyText2
                                    .copyWith(color: kcError500)),
                          ),
                        ]);
                  }
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
                      EditDateTimeCell(fetchedTask: _fetchedTask),
                      if (_fetchedTask.dueDate != null)
                        [
                          Text(
                            CustomDateUtils.returnDateAndMonth(
                                _fetchedTask.dueDate!),
                            style: _timeTextStyle,
                          ),
                          Text(
                            'Due Date',
                            style: _dateTextStyle,
                          ),
                        ].toColumn(),
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
                    ],
                  );
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

  CupertinoTextFieldData cupertinoTextField() {
    return CupertinoTextFieldData(
      padding: _textfieldPadding,
      decoration: const BoxDecoration(
        color: kcPrimary100,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
  }

  MaterialTextFieldData materialTextField() {
    return MaterialTextFieldData(
      decoration: InputDecoration(
        contentPadding: _textfieldPadding,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}

class SlidableSubTaskItem extends StatelessWidget {
  const SlidableSubTaskItem({
    Key? key,
    required this.subTask,
  }) : super(key: key);

  final SubTaskEntry subTask;

  @override
  Widget build(BuildContext context) {
    return Slidable.builder(
        key: key ?? const Key('subtask_value'),
        actionPane: const SlidableStrechActionPane(),
        actionExtentRatio: .6,
        actionDelegate: SlideActionBuilderDelegate(
          builder: (context, index, animation, step) {
            // print('Current Animation: ${animation}');
            if (animation!.isCompleted) {
              final controller = Slidable.of(context);
              controller!.close();
            }
            return Icon(
              Icons.check,
              size: 40 * animation.value,
              color: animation.value > 0.5 ? kcPrimary500 : Colors.grey,
            ).alignment(Alignment.centerRight).padding(right: 16);
          },
          actionCount: 1,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          padding: const EdgeInsets.all(16),
          width: context.width - 16,
          decoration: BoxDecoration(
              color: context.colorScheme.primary,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: const [
                kShadowLightBase,
                kShadowLight40,
              ]),
          child: Text(
            subTask.title ?? '',
            textAlign: TextAlign.center,
            style: context.caption.copyWith(
              color: Colors.white,
              decoration:
                  subTask.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
        ));
  }
}

class EditDateTimeCell extends StatefulWidget {
  const EditDateTimeCell({Key? key, required this.fetchedTask})
      : super(key: key);

  final TaskEntry fetchedTask;

  @override
  State<EditDateTimeCell> createState() => _EditDateTimeCellState();
}

class _EditDateTimeCellState extends State<EditDateTimeCell> {
  Widget _parentCell({required Widget child}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          width: context.width,
          child: Styled.widget(child: child),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final _textColor = kcPrimary500;

    final _timeTextStyle = context.h6.copyWith(
      color: _textColor,
      fontWeight: FontWeight.w600,
    );
    final _dateTextStyle = context.subtitle1.copyWith(
      color: _textColor,
    );
    return SizedBox(
        child: [
      [
        if (widget.fetchedTask.startDateTime != null)
          Text(
            CustomDateUtils.returnTime(widget.fetchedTask.startDateTime!),
            style: _timeTextStyle,
          ),
        if (widget.fetchedTask.endDateTime != null) ...[
          Icon(
            Icons.arrow_right_alt_rounded,
            color: _textColor,
          ).padding(horizontal: 4),
          Text(
            CustomDateUtils.returnTime(widget.fetchedTask.endDateTime!),
            style: _timeTextStyle,
          ),
        ]
      ].toRow(mainAxisAlignment: MainAxisAlignment.center).parent(_parentCell),
      [
        if (widget.fetchedTask.startDateTime != null)
          Text(
            CustomDateUtils.returnDateAndMonth(
                widget.fetchedTask.startDateTime!),
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
            CustomDateUtils.returnDateAndMonth(widget.fetchedTask.endDateTime!),
            style: _dateTextStyle,
          ),
        ]
      ].toRow(mainAxisAlignment: MainAxisAlignment.center).parent(_parentCell),
    ].toColumn());
  }
}
