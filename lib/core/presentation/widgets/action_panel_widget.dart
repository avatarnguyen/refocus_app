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
    this.projectEntry,
  }) : super(key: key);

  final ProjectEntry? projectEntry;

  @override
  _ActionPanelWidgetState createState() => _ActionPanelWidgetState();
}

class _ActionPanelWidgetState extends State<ActionPanelWidget> {
  Widget iconContainer({required Widget child}) => Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        width: 44,
        child: Styled.widget(child: child),
      );

  Uuid uuid = const Uuid();

  final _textStream = getIt<TextStream>();
  final _settingOption = getIt<SettingOption>();

  @override
  Widget build(BuildContext context) {
    final _iconTextStyle = context.textTheme.headline5!.copyWith(
      color: kcSecondary100,
    );
    return StreamBuilder(
        stream: _textStream.getTextStream,
        builder: (context, AsyncSnapshot<String> textStream) {
          return Container(
            height: 48,
            color: kcPrimary800,
            child: [
              const Icon(
                Icons.add,
                size: 32,
                color: kcSecondary100,
              ).gestures(onTap: () {}),
              // horizontalSpaceSmall,
              [
                Text('!', style: _iconTextStyle).parent(iconContainer).gestures(
                    onTap: () =>
                        _textStream.updateText('${textStream.data ?? ''}!')),
                Text('?', style: _iconTextStyle).parent(iconContainer).gestures(
                    onTap: () =>
                        _textStream.updateText('${textStream.data ?? ''}?')),
                Text('/', style: _iconTextStyle).parent(iconContainer).gestures(
                    onTap: () =>
                        _textStream.updateText('${textStream.data ?? ''}/')),
                Text('#', style: _iconTextStyle).parent(iconContainer).gestures(
                    onTap: () =>
                        _textStream.updateText('${textStream.data ?? ''}#')),
                Text('@', style: _iconTextStyle).parent(iconContainer).gestures(
                    onTap: () =>
                        _textStream.updateText('${textStream.data ?? ''}@')),
              ].toRow(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
              ),
              // horizontalSpaceSmall,
              Icon(
                Icons.send,
                size: 28,
                color: context.theme.primaryColor,
              ).gestures(onTap: () {
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
                                projectID: _settingOption.projectEntry?.id ??
                                    'inbox_2021',
                                title: textStream.data,
                                startDateTime: [DateTime.now()],
                              ),
                            ),
                          ],
                        ),
                      );
                }
                Get.back();
              }),
            ].toRow(mainAxisAlignment: MainAxisAlignment.spaceEvenly),
          );
        });
  }
}
