import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    // context.read<TaskBloc>().add(
    //       GetTaskEntriesEvent(project: widget.project),
    //     );
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
              padding:
                  _tasks.length < 5 ? const EdgeInsets.only(bottom: 400) : null,
              itemBuilder: (context, index) {
                final _task = _tasks[index];
                // print(_task.title);
                return ListTile(
                  title: Text(_task.title ?? 'Empty'),
                );
              },
            ),
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
