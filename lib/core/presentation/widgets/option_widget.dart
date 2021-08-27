import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/injection.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:get/get.dart';

import 'setting_option.dart';

class OptionRowWidget extends StatefulWidget {
  const OptionRowWidget({
    Key? key,
  }) : super(key: key);

  @override
  _OptionRowWidgetState createState() => _OptionRowWidgetState();
}

class _OptionRowWidgetState extends State<OptionRowWidget> {
  final _settingsOption = getIt<SettingOption>();
  TodayEntryType entryType = TodayEntryType.task;
  ProjectEntry? _currentProject;

  @override
  Widget build(BuildContext context) {
    final _entryMapIcon = <TodayEntryType, IconData>{
      TodayEntryType.task: Icons.done_all,
      TodayEntryType.event: Icons.calendar_today,
      TodayEntryType.timeblock: Icons.access_time,
    };
    final _entryMapString = <TodayEntryType, String>{
      TodayEntryType.task: 'Task',
      TodayEntryType.event: 'Event',
      TodayEntryType.timeblock: 'Time Block',
    };

    return SizedBox(
      height: 64,
      child: [
        _buildOptionItem(
                context, _entryMapIcon[entryType], _entryMapString[entryType])
            .ripple()
            .gestures(
          onTap: () async {
            final result = await showPlatformModalSheet(
              context: context,
              builder: (context) => PlatformWidget(
                material: (_, __) => _materialPopupContent(context),
                cupertino: (_, __) => _cupertinoSheetContent(context),
              ),
            );
            print(result);
            if (result != null) {
              _settingsOption.type = result;
              setState(() {
                entryType = result;
              });
            }
          },
        ),
        _buildOptionItem(
                context, Icons.folder, _currentProject?.title ?? 'Inbox')
            .ripple()
            .gestures(
          onTap: () async {
            final result = await showPlatformModalSheet(
              context: context,
              builder: (_) => BlocProvider<ProjectBloc>.value(
                value: BlocProvider.of<ProjectBloc>(context),
                child: PlatformWidget(
                  material: (_, __) => _materialPopupProjectContent(context),
                  cupertino: (_, __) => _cupertinoSheetProjectContent(context),
                ),
              ),
            );
            print(result);
            if (result != null) {
              _settingsOption.projectEntry = result;
              setState(() {
                _currentProject = result;
              });
            }
          },
        ).flexible(),
        _buildOptionItem(context, Icons.alarm, 'Planning')
            .ripple()
            .gestures(onTap: () {}),
        _buildOptionItem(context, Icons.notes, 'Notes')
            .ripple()
            .gestures(onTap: () {}),
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceAround),
    );
  }

  Widget _buildOptionItem(BuildContext context, IconData? icon, String? text) {
    return [
      Icon(
        icon,
        size: 28,
        color: kcSecondary200,
      ).paddingOnly(bottom: 4),
      Text(
        text ?? '',
        maxLines: 2,
        overflow: TextOverflow.fade,
        style: context.textTheme.subtitle1!.copyWith(
          color: kcSecondary200,
        ),
      ),
    ].toColumn(mainAxisAlignment: MainAxisAlignment.start);
  }

  Widget _materialPopupProjectContent(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(builder: (context, state) {
      if (state is ProjectLoaded) {
        final _projects = state.project;
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: _projects
                .map(
                  (project) => Container(
                    padding: const EdgeInsets.all(8),
                    child: PlatformText(project.title ?? ''),
                  ).gestures(onTap: () => Navigator.pop(context, project)),
                )
                .toList(),
          ),
        );
      } else {
        return Container(
          padding: const EdgeInsets.all(16),
          child: const Text('No Project Available').center(),
        );
      }
    });
  }

  Widget _cupertinoSheetProjectContent(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        if (state is ProjectLoaded) {
          final _projects = state.project;
          return CupertinoActionSheet(
            actions: _projects
                .map(
                  (project) => CupertinoActionSheetAction(
                    onPressed: () => Navigator.pop(context, project),
                    child: Text(project.title ?? ''),
                  ),
                )
                .toList(),
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          );
        } else {
          return CupertinoActionSheet(
            message: const Text('No Project Available'),
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          );
        }
      },
    );
  }

  Widget _materialPopupContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: PlatformText('Event'),
          ).gestures(onTap: () => Navigator.pop(context, TodayEntryType.event)),
          Container(
            padding: const EdgeInsets.all(8),
            child: PlatformText('Task'),
          ).gestures(onTap: () => Navigator.pop(context, TodayEntryType.task)),
          Container(
            padding: const EdgeInsets.all(8),
            child: PlatformText('Time Block'),
          ).gestures(
              onTap: () => Navigator.pop(context, TodayEntryType.timeblock)),
        ],
      ),
    );
  }

  Widget _cupertinoSheetContent(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context, TodayEntryType.event),
          child: const Text('Event'),
        ),
        CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context, TodayEntryType.task),
          child: const Text('Task'),
        ),
        CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context, TodayEntryType.timeblock),
          child: const Text('Time Block'),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
    );
  }
}
