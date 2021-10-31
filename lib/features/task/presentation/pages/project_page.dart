import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:refocus_app/config/routes/router.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
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
          log('Task Bloc Rebuild');
          if (state is ProjectLoaded) {
            final _projects = state.project;
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 16),
              itemCount: _projects.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const ProjectItem();
                }
                if (index == _projects.length + 1) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: PlatformButton(
                      color: Colors.white,
                      onPressed: () {
                        context.navigateTo(CreateProjectRoute());
                      }, //_showCreateProjectBottomSheet,
                      child: Icon(
                        Icons.add,
                        size: 28,
                        color: context.colorScheme.primaryVariant,
                      ),
                    ),
                  );
                }
                index -= 1;
                final _project = _projects[index];
                return ProjectItem(project: _project);
              },
            ).safeArea(top: false);
          } else if (state is ProjectLoading) {
            return progressIndicator;
          } else {
            return const MessageDisplay(
              message: 'Unexpected State',
            );
          }
        },
      ),
    );
  }
}

class ProjectItem extends StatefulWidget {
  const ProjectItem({Key? key, this.project}) : super(key: key);

  final ProjectEntry? project;

  @override
  State<ProjectItem> createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  late ProjectEntry _currentProject;
  final SlidableController _slidableController = SlidableController();

  @override
  void initState() {
    super.initState();
    _currentProject = widget.project ??
        const ProjectEntry(title: 'Inbox', id: 'inbox_2021', color: '#8879FC');
  }

  @override
  Widget build(BuildContext context) {
    final _color =
        StyleUtils.getColorFromString(_currentProject.color ?? '#8879FC');
    final _backgroundColor = StyleUtils.darken(_color);
    final _textColor = StyleUtils.darken(_color, 0.4);

    return Slidable(
      key: Key(_currentProject.title ?? 'project_item'),
      controller: _slidableController,
      actionPane: const SlidableStrechActionPane(),
      secondaryActions: [
        IconSlideAction(
          icon: Icons.edit,
          color: Colors.transparent,
          foregroundColor: context.colorScheme.onPrimary,
          onTap: () {
            context.navigateTo(CreateProjectRoute(project: _currentProject));
          },
        ),
        IconSlideAction(
          icon: Icons.delete,
          color: Colors.transparent,
          foregroundColor: context.colorScheme.error,
          onTap: () async {
            final _result = await _showDeleteAlertDialog();
            if (_result) {
              //TODO: Delete Project

            }
          },
        )
      ],
      dismissal: SlidableDismissal(
        child: const SlidableDrawerDismissal(),
        onWillDismiss: (actionType) async {
          final _result = await _showDeleteAlertDialog();
          return _result;
        },
        onDismissed: (actionType) {
          //TODO: Delete Project
        },
      ),
      child: [
        Text(
          _currentProject.title!,
          style: context.bodyText1.copyWith(
            color: Colors.white,
          ),
        ),
        if (widget.project != null)
          Container(
            width: 32,
            padding: const EdgeInsets.symmetric(vertical: 2),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Text(
              _currentProject.taskCount?.toString() ?? '0',
              textAlign: TextAlign.center,
              style: context.bodyText2.copyWith(
                color: _textColor,
              ),
            ),
          ),
      ]
          .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
          .padding(all: 16)
          .ripple()
          .card(
            color: _backgroundColor,
            elevation: 2,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          )
          .gestures(
        onTap: () {
          context.read<TaskBloc>().add(
                GetTaskEntriesEvent(project: _currentProject),
              );
          context.router.push(TaskRoute(
            project: _currentProject,
          ));
        },
      ),
    );
  }

  Future<bool> _showDeleteAlertDialog() async {
    final _result = await showPlatformDialog<bool>(
      context: context,
      builder: (context) {
        return PlatformAlertDialog(
          title: 'Delete Project'.toH5(color: context.colorScheme.primary),
          content:
              'Do you want to delete this project permanently? All Tasks inside the project will be deleted as well!'
                  .toSubtitle1(color: context.colorScheme.primary),
          actions: [
            PlatformButton(
              color: Colors.transparent,
              onPressed: () => context.router.pop(false),
              child: 'Cancel'.toButtonText(color: context.colorScheme.primary),
            ),
            PlatformButton(
              color: Colors.transparent,
              onPressed: () => context.router.pop(true),
              child: 'Delete Project'
                  .toButtonText(color: context.colorScheme.error),
            ),
          ],
        );
      },
    );
    return _result ?? false;
  }
}

class TaskPageHeaderWidget extends StatelessWidget {
  const TaskPageHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.backgroundColor,
      height: 56,
      width: double.infinity,
      child: [
        const Icon(
          Icons.clear,
          color: kcPrimary500,
          size: 28,
        )
            .padding(all: 4)
            .decorated(
                color: kcPrimary100, borderRadius: BorderRadius.circular(12))
            .ripple()
            .padding(left: 16)
            .gestures(onTap: context.router.pop),
        const Icon(
          Icons.add,
          color: kcPrimary500,
          size: 28,
        )
            .padding(all: 4)
            .decorated(
                color: kcPrimary100, borderRadius: BorderRadius.circular(12))
            .ripple()
            .padding(right: 16)
            .gestures(onTap: context.router.pop),
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    );
  }
}
