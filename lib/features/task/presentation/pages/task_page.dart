import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/features/today/presentation/widgets/list_item_widget.dart';
import 'package:styled_widget/styled_widget.dart';

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
  late List<TaskEntry> _tasks;

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
    return PlatformScaffold(
      iosContentBottomPadding: Platform.isIOS,
      appBar: PlatformAppBar(
        title: Text(widget.project.title ?? ''),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TasksLoaded) {
            _tasks = state.tasks;
            print(_tasks);
            if (_tasks.isEmpty) {
              return const BottomSheetMessageWidget(
                  message: 'Nothing todo here :)');
            }
            return ListView.builder(
              controller: ModalScrollController.of(context),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final _task = _tasks[index];

                return ListItemWidget(
                  key: Key('task_page_${_task.id}'),
                  task: _task,
                  project: widget.project,
                  markItemAsDone: () => _markTaskAsDone(_task),
                  deleteItem: () => _deleteTask(_task),
                );
              },
            );
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
      ),
    );
  }

  void _deleteTask(TaskEntry entry) {
    context.read<TaskBloc>().add(
          DeleteTaskEntryEvent(
            params: TaskParams(task: entry),
          ),
        );
    _tasks.remove(entry);
  }

  void _markTaskAsDone(TaskEntry entry) {
    context.read<TaskBloc>().add(EditTaskEntryEvent(
          params: TaskParams(
              task: entry.copyWith(
            isCompleted: true,
          )),
        ));
    _tasks.remove(entry);
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
