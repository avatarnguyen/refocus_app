import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/core/util/ui/ui_helpers.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/injection.dart';
import 'package:styled_widget/styled_widget.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (context) => getIt<TaskBloc>(),
      child: const ProjectListWidget(),
    );
  }
}

class ProjectListWidget extends StatefulWidget {
  const ProjectListWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ProjectListWidgetState createState() => _ProjectListWidgetState();
}

class _ProjectListWidgetState extends State<ProjectListWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TaskBloc>(context).add(GetProjectEntriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is ProjectLoaded) {
          final _projects = state.project;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _projects.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                child: Text(
                  _projects[index].title!,
                ),
              );
            },
          );
        } else if (state is TaskLoading) {
          return progressIndicator;
        } else if (state is TaskInitial) {
          return ElevatedButton(
            onPressed: () => BlocProvider.of<TaskBloc>(context)
                .add(GetProjectEntriesEvent()),
            child: const Text('Sign In Google'),
          ).center();
        } else {
          return const MessageDisplay(
            message: 'Unexpected State',
          );
        }
      },
    );
  }
}
