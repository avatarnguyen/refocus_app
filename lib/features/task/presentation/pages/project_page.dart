import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/config/routes/router.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/features/task/presentation/widgets/project_item_widget.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (project) {
              final _projects = project ?? [];
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 16),
                itemCount: _projects.length + 1,
                itemBuilder: (context, index) {
                  // if (index == 0) {
                  //   return const ProjectItem();
                  // }
                  if (index == _projects.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: PlatformButton(
                        cupertino: (context, platform) => CupertinoButtonData(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(16)),
                        ),
                        material: (context, platform) => MaterialRaisedButtonData(
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // context.navigateTo(CreateProjectRoute());
                        }, //_showCreateProjectBottomSheet,
                        child: Icon(
                          Icons.add,
                          size: 28,
                          color: context.colorScheme.primaryVariant,
                        ),
                      ),
                    );
                  }
                  // index -= 1;
                  final _project = _projects[index];
                  return ProjectItem(
                    key: Key('${_project.id}_${_project.title}_${_project.color}'),
                    project: _project,
                  );
                },
              ).safeArea(top: false);
            },
            orElse: () => progressIndicator,
          );
        },
      ),
    );
  }
}
