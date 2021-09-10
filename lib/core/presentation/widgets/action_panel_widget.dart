import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/project_params.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';

import 'package:uuid/uuid.dart';
import 'package:get/get.dart';

import '../../../injection.dart';
import '../text_stream.dart';
import 'setting_option.dart';

class ActionPanelWidget extends StatefulWidget {
  const ActionPanelWidget({
    Key? key,
    // this.projectEntry,
  }) : super(key: key);

  // final ProjectEntry? projectEntry;

  @override
  _ActionPanelWidgetState createState() => _ActionPanelWidgetState();
}

class _ActionPanelWidgetState extends State<ActionPanelWidget> {
  Uuid uuid = const Uuid();

  final _textStream = getIt<TextStream>();
  final _settingOption = getIt<SettingOption>();
  bool _onSelectingProject = false;

  Widget _buildActionItem(IconData? icon, {Color? color}) {
    return Icon(
      icon,
      size: 24,
      color: color ?? kcSecondary200,
    ).padding(horizontal: 8);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _textStream.getTextStream,
      builder: (context, AsyncSnapshot<String> textStream) {
        return [
          BlocBuilder<ProjectBloc, ProjectState>(
            builder: (context, state) {
              if (state is ProjectLoaded) {
                final _projects = state.project;
                return _onSelectingProject
                    ? SizedBox(
                        height: 44,
                        width: context.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _projects.length,
                          itemBuilder: (context, index) {
                            final _project = _projects[index];
                            return ChoiceChip(
                              backgroundColor: kcPrimary800,
                              selectedColor: context.theme.accentColor,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: kcPrimary100),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              label: Text(
                                _project.title?.trim() ?? '',
                                style: context.textTheme.subtitle1!.copyWith(
                                  color: kcPrimary100,
                                ),
                              ),
                              selected: _settingOption.projectEntry == _project,
                              onSelected: (bool selected) {
                                print(_project);
                                print(_settingOption.projectEntry);
                                _settingOption.projectEntry = _project;
                                _settingOption
                                    .broadCastCurrentProjectEntry(_project);
                                setState(() {});
                              },
                            ).paddingSymmetric(horizontal: 4.0);
                          },
                        ),
                      )
                    : const SizedBox();
              } else {
                return const SizedBox();
              }
            },
          ),
          verticalSpaceRegular,
          _buildActionInputRow(textStream, context)
        ].toColumn(
          mainAxisSize: MainAxisSize.min,
        );
      },
    );
  }

  Container _buildActionInputRow(
      AsyncSnapshot<String> textStream, BuildContext context) {
    return Container(
      height: 44,
      color: kcPrimary900,
      child: [
        const Icon(
          Icons.close,
          size: 28,
          color: kcSecondary100,
        ).gestures(onTap: () {
          _settingOption.projectEntry = null;
          _settingOption.broadCastCurrentProjectEntry(null);
          Get.back();
        }),
        [
          // Adding project (default: Inbox)
          _buildActionItem(Icons.folder,
                  color: _onSelectingProject
                      ? context.theme.accentColor
                      : kcSecondary200)
              .gestures(onTap: () {
            setState(() {
              _onSelectingProject = !_onSelectingProject;
            });
          }),
          //* Adding due dates and reminder
          _buildActionItem(Icons.calendar_today).gestures(
              onTap: () =>
                  _textStream.updateText('${textStream.data ?? ''}am ')),
          _buildActionItem(Icons.alarm_add).gestures(
              onTap: () => _textStream.updateText('${textStream.data ?? ''}?')),
          // Adding Priority
          _buildActionItem(Icons.flag).gestures(
              onTap: () => _textStream.updateText('${textStream.data ?? ''}!')),
          // Adding Description or Notes
          _buildActionItem(Icons.notes).gestures(
            onTap: () => {},
          ),
          //* Adding Contact
          // Text('@', style: context.textTheme.bodyText1!.copyWith(
          //   color: kcSecondary100,
          // );)
          //     .padding(horizontal: 8)
          //     .gestures(
          //         onTap: () => _textStream
          //             .updateText('${textStream.data ?? ''}@')),
        ].toRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
        ),
        // horizontalSpaceTiny,
        Icon(
          Icons.send,
          size: 26,
          color: context.theme.primaryColor,
        ).gestures(
          onTap: () {
            if (_settingOption.type == TodayEntryType.project) {
              BlocProvider.of<ProjectBloc>(context).add(
                CreateProjectEntriesEvent(ProjectParams(
                    ProjectEntry(id: uuid.v1(), title: textStream.data))),
              );
            }
            if (_settingOption.type == TodayEntryType.task) {
              print('Add New Task');
              context.read<TaskBloc>().add(
                    CreateTaskEntriesEvent(
                      params: [
                        TaskParams(
                          task: TaskEntry(
                            id: uuid.v1(),
                            isCompleted: false,
                            dueDate: DateTime.now(),
                            projectID:
                                _settingOption.projectEntry?.id ?? 'inbox_2021',
                            title: textStream.data,
                            startDateTime: [DateTime.now()],
                          ),
                        ),
                      ],
                    ),
                  );
            }
            Get.back();
          },
        ),
        // horizontalSpaceTiny,
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceEvenly),
    );
  }
}
