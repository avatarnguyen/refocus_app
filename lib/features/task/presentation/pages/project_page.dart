import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/core/util/ui/ui_helpers.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/project_params.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:uuid/uuid.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({
    Key? key,
  }) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  Uuid uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(GetProjectEntriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        log('Task Bloc Rebuild');
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
              });
        } else if (state is TaskLoading) {
          return progressIndicator;
          // }
          // else if (state is TaskInitial) {
          //   return ElevatedButton(
          //     onPressed: () => BlocProvider.of<TaskBloc>(context)
          //         .add(GetProjectEntriesEvent()),
          //     child: const Text('Load All Projects'),
          //   ).center();
        } else {
          return const MessageDisplay(
            message: 'Unexpected State',
          );
        }
      },
    );
  }
}
