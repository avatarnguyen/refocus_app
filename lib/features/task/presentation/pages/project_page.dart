import 'dart:developer';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/features/task/presentation/pages/task_page.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
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
    context.read<ProjectBloc>().add(GetProjectEntriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        log('Task Bloc Rebuild');
        if (state is ProjectLoaded) {
          final _projects = state.project;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 16),
            itemCount: _projects.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const ProjectItem();
              }
              index -= 1;
              final _project = _projects[index];
              return ProjectItem(project: _project);
            },
          );
        } else if (state is ProjectLoading) {
          return progressIndicator;
        } else {
          return const MessageDisplay(
            message: 'Unexpected State',
          );
        }
      },
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

  @override
  void initState() {
    super.initState();
    _currentProject = widget.project ??
        const ProjectEntry(
            title: 'Tasks Inbox', id: 'inbox_2021', color: '#8879FC');
  }

  @override
  Widget build(BuildContext context) {
    final _color =
        StyleUtils.getColorFromString(_currentProject.color ?? '#8879FC');
    final _backgroundColor = StyleUtils.darken(_color);
    const _textColor = Colors.white;

    return [
      Text(
        _currentProject.title!,
        style: context.bodyText1.copyWith(
          color: _textColor,
        ),
      ),
      Chip(
        labelPadding: EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(vertical: -2),
        label: Text('10', style: context.subtitle1),
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
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        )
        .gestures(
      onTap: () {
        showTaskBottomSheet(context, _currentProject);
      },
    );
  }

  //TODO: Change to 'customBuilder' when sliding sheet release new version
  void showTaskBottomSheet(
    BuildContext parentContext,
    ProjectEntry project,
  ) async {
    SlidingSheetDialog? _taskSheetDialog;
    Widget? _taskPageContent;
    final dynamic result = await showSlidingBottomSheet<dynamic>(
      context,
      builder: (context) {
        return _taskSheetDialog ??= SlidingSheetDialog(
          elevation: 8,
          cornerRadius: 16,
          duration: 500.milliseconds,
          color: context.backgroundColor,
          snapSpec: const SnapSpec(
            initialSnap: 0.89,
            snappings: [0.4, 0.89],
            positioning: SnapPositioning.relativeToSheetHeight,
          ),
          minHeight: context.height - 56,
          headerBuilder: (context, state) {
            return const TaskPageHeaderWidget();
          },
          builder: (context, state) {
            return BlocProvider<TaskBloc>.value(
              value: BlocProvider.of<TaskBloc>(parentContext),
              child: _taskPageContent ??= TaskPage(
                project: project,
              ),
            );
          },
        );
      },
    );

    print(result); // This is the result.
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
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween));
  }
}
