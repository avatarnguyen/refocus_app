import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:get/get.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({
    Key? key,
    required this.project,
  }) : super(key: key);

  final ProjectEntry project;

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(
          GetTaskEntriesEvent(project: widget.project),
        );
  }

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        print(state);
        if (state is TasksLoaded) {
          final _tasks = state.tasks;
          print(_tasks);
          if (_tasks.isEmpty) {
            return const BottomSheetMessageWidget(
                message: 'Nothing todo here :)');
          }
          return Material(
            color: context.theme.backgroundColor,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final _task = _tasks[index];
                // print(_task.title);
                return [
                  Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                        tristate: true,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: _task.isCompleted,
                        shape: const CircleBorder(),
                        onChanged: (_) {}),
                  ),
                  [
                    Text(
                      _task.title ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.caption!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (_task.dueDate != null)
                      Text(
                        DateFormat.MMMMEEEEd().format(_task.dueDate!),
                        style: context.textTheme.subtitle2!.copyWith(
                          color: kcSecondary500,
                        ),
                      ).padding(top: 4),
                  ]
                      .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
                      .padding(vertical: 8)
                      .flexible(),
                ]
                    .toRow()
                    .card(
                      elevation: 1.6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    )
                    .padding(horizontal: 16, vertical: 2);
              },
            ),
          );
          // .parent(({required child}) => SizedBox(
          //       height: context.height,
          //       width: context.width,
          //       child: child,
          //     ));
        } else if (state is TaskLoading || state is TaskInitial) {
          return SizedBox(
            height: context.height - 56,
            width: context.width,
            child: progressIndicator.center(),
          );
        } else if (state is TaskError) {
          return BottomSheetMessageWidget(message: state.message);
        } else {
          return const BottomSheetMessageWidget(message: 'Unexpected State');
        }
      },
    );
  }
}

class BottomSheetMessageWidget extends StatelessWidget {
  const BottomSheetMessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Material(
        child: InkWell(
          onTap: () => Navigator.pop(context, 'This is the result.'),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              message,
              style: context.textTheme.bodyText1,
            ),
          ),
        ).alignment(Alignment.topCenter),
      ),
    );
  }
}
