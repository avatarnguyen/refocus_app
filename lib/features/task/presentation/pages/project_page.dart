import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:get/get.dart';
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
                return Text(
                  _projects[index].title!,
                  style: context.textTheme.bodyText1,
                ).paddingAll(8).card(
                      color: kcPrimary100,
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
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
