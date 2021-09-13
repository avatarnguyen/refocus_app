import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:get/get.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/features/task/presentation/pages/task_page.dart';
import 'package:refocus_app/injection.dart';
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
              itemCount: _projects.length,
              itemBuilder: (context, index) {
                final _project = _projects[index];
                final _color =
                    StyleUtils.getColorFromString(_project.color ?? '#8879FC');
                final _backgroundColor = StyleUtils.darken(_color);
                const _textColor = Colors.white;

                return [
                  Text(
                    _project.title!,
                    style: context.textTheme.bodyText1!.copyWith(
                      color: _textColor,
                    ),
                  ),
                  Chip(
                    labelPadding: EdgeInsets.zero,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity:
                        const VisualDensity(horizontal: 0.0, vertical: -2),
                    label: Text('10', style: context.textTheme.subtitle1),
                  ),
                ]
                    .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                    .paddingAll(16)
                    .ripple()
                    .card(
                      color: _backgroundColor,
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    )
                    .gestures(
                        onTap: () => showTaskBottomSheet(context, _project));
              });
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
          color: context.theme.backgroundColor,
          snapSpec: const SnapSpec(
            snap: true,
            initialSnap: 0.86,
            snappings: [0.4, 0.86],
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
        color: context.theme.backgroundColor,
        height: 56,
        width: double.infinity,
        child: [
          const Icon(
            Icons.clear,
            color: kcPrimary500,
            size: 28,
          )
              .paddingAll(4)
              .decorated(
                  color: kcPrimary100,
                  borderRadius: BorderRadius.circular(12.0))
              .ripple()
              .paddingOnly(left: 16)
              .gestures(onTap: Get.back),
          const Icon(
            Icons.add,
            color: kcPrimary500,
            size: 28,
          )
              .paddingAll(4)
              .decorated(
                  color: kcPrimary100,
                  borderRadius: BorderRadius.circular(12.0))
              .ripple()
              .paddingOnly(right: 16)
              .gestures(onTap: Get.back),
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween));
  }
}
