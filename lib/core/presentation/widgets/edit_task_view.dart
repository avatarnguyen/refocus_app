import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:refocus_app/core/presentation/widgets/add_page_widgets/action_panel_widget.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:dartx/dartx.dart';

class EditTaskView extends StatefulWidget {
  const EditTaskView({Key? key, required this.taskID}) : super(key: key);

  final String taskID;

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(
          GetSingleTaskEntryEvent(taskID: widget.taskID),
        );
  }

  void handleSlideAnimationChanged(Animation<double?>? slideAnimation) {
    print('Slider animation: $slideAnimation');
  }

  void handleSlideIsOpenChanged(bool? isOpen) {
    print('Slider is open: $isOpen');
    // setState(() {
    //   _fabColor = isOpen ? Colors.green : Colors.blue;
    // });
  }

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

    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TasksLoaded) {
          if (state.tasks.isNotEmpty) {
            final _fetchedTask = state.tasks.first;
            return Material(
              color: context.backgroundColor,
              child: ListView(
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
                  [
                    if (_fetchedTask.startDateTime != null)
                      Text(
                        CustomDateUtils.returnTime(_fetchedTask.startDateTime!),
                        style: _timeTextStyle,
                      ),
                    if (_fetchedTask.endDateTime != null) ...[
                      Icon(
                        Icons.arrow_right_alt_rounded,
                        color: _textColor,
                      ).padding(horizontal: 4),
                      Text(
                        CustomDateUtils.returnTime(_fetchedTask.endDateTime!),
                        style: _timeTextStyle,
                      ),
                    ]
                  ]
                      .toRow(mainAxisAlignment: MainAxisAlignment.center)
                      .parent(_parentCell),
                  [
                    if (_fetchedTask.startDateTime != null)
                      Text(
                        CustomDateUtils.returnDateAndMonth(
                            _fetchedTask.startDateTime!),
                        style: _dateTextStyle,
                      ),
                    if (_fetchedTask.endDateTime != null &&
                        !_fetchedTask.endDateTime!
                            .isAtSameDayAs(_fetchedTask.startDateTime!)) ...[
                      Icon(
                        Icons.arrow_right_alt_rounded,
                        color: _textColor,
                      ).padding(horizontal: 4),
                      Text(
                        CustomDateUtils.returnDateAndMonth(
                            _fetchedTask.endDateTime!),
                        style: _dateTextStyle,
                      ),
                    ]
                  ]
                      .toRow(mainAxisAlignment: MainAxisAlignment.center)
                      .parent(_parentCell),
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
              ),
            );
          } else {
            return const MessageDisplay(message: '');
          }
        } else {
          return progressIndicator;
        }
      },
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
              color: animation.value > 0.5 ? kcPrimary500 : Colors.black54,
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
