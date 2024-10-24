import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:refocus_app/config/routes/router.dart';
import 'package:refocus_app/core/core.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/project_params.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';

class ProjectItem extends StatefulWidget {
  const ProjectItem({Key? key, this.project}) : super(key: key);

  final ProjectEntry? project;

  @override
  State<ProjectItem> createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  late ProjectEntry _currentProject;

  @override
  void initState() {
    super.initState();
    _currentProject = widget.project!;
    // const ProjectEntry(title: 'Inbox', id: 'inbox_2021', color: '#8879FC');
  }

  void _deleteProject() {
    context.read<ProjectBloc>().add(
          DeleteProjectEntriesEvent(
            ProjectParams(_currentProject),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final _color =
        StyleUtils.getColorFromString(_currentProject.color ?? '#8879FC');
    final _backgroundColor = StyleUtils.darken(_color);
    final _textColor = StyleUtils.darken(_color, 0.4);

    return Slidable(
      key: widget.key ?? Key(_currentProject.title ?? 'project_item'),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        dismissible: DismissiblePane(
          confirmDismiss: () async {
            final _result = await _showDeleteAlertDialog();
            return _result;
          },
          onDismissed: _deleteProject,
        ),
        children: [
          SlidableAction(
            icon: Icons.edit,
            backgroundColor: Colors.transparent,
            foregroundColor: context.colorScheme.onPrimary,
            onPressed: (_) {
              context.navigateTo(CreateProjectRoute(project: _currentProject));
            },
          ),
          SlidableAction(
            icon: Icons.delete,
            backgroundColor: Colors.transparent,
            foregroundColor: context.colorScheme.error,
            onPressed: (_) async {
              final _result = await _showDeleteAlertDialog();
              if (_result) {
                _deleteProject();
              }
            },
          )
        ],
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
