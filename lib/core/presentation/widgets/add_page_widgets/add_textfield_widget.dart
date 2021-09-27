import 'dart:async';
import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/presentation/helper/custom_text_controller.dart';
import 'package:refocus_app/core/presentation/helper/setting_option.dart';
import 'package:refocus_app/core/presentation/helper/subtask_stream.dart';
import 'package:refocus_app/core/presentation/helper/text_stream.dart';
import 'package:refocus_app/core/presentation/widgets/sub_task_item.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/helpers/regexp_matcher.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/injection.dart';
import 'package:styled_widget/styled_widget.dart';

class AddTextFieldWidget extends StatefulWidget {
  const AddTextFieldWidget({Key? key}) : super(key: key);
  @override
  _AddTextFieldWidgetState createState() => _AddTextFieldWidgetState();
}

class _AddTextFieldWidgetState extends State<AddTextFieldWidget> {
  final _textStream = getIt<TextStream>();
  final _settingOption = getIt<SettingOption>();
  final _subTaskStream = getIt<SubTaskStream>();
  final log = logger(AddTextFieldWidget);

  late StreamSubscription _textSubscription;

  late RichTextController _textController;

  ProjectEntry? _currentProject;

  final _matcherDueDate = StringMatcher.matcherDueDate;
  final _matcherRemindDate = StringMatcher.matcherRemindDate;
  final _matcherRemindTime = StringMatcher.matcherRemindTime;
  final _matcherPrio = StringMatcher.matcherPrio;

  @override
  void initState() {
    _textController = RichTextController(
      patternMap: {
        // Matching for Due Date
        _matcherDueDate: const TextStyle(color: kcPrimary500),
        // Matcher for Reminder
        _matcherRemindDate: const TextStyle(color: kcSecondary500),
        _matcherRemindTime: const TextStyle(color: kcSecondary500),
        // /
        RegExp(r'\B/[a-zA-Z0-9]+\b'): const TextStyle(color: Colors.green),
        // '!' Matcher for Prio
        _matcherPrio: const TextStyle(color: Colors.red),
      },
      onMatch: (List<String> matches) {
        print(matches);
        //TODO: Do sth with matches
      },
    );

    _textSubscription = _textStream.getTextStream.listen((text) {
      final _currentTxt = _textController.text;
      if (_currentTxt != text) {
        _textController.text = text;
        _textController.selection = TextSelection.fromPosition(
            TextPosition(offset: _textController.text.length));
      }
    });

    super.initState();

    _currentProject = _settingOption.projectEntry;
  }

  @override
  void dispose() {
    _textSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(builder: (context, state) {
      if (state is ProjectLoaded) {
        final _projects = state.project;
        // log.d(_projects);
        final _currentColor =
            StyleUtils.getColorFromString(_currentProject?.color ?? '#8879FC');
        return SizedBox(
            width: context.width,
            child: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: _currentColor,
                  boxShadow: [
                    BoxShadow(
                      color: _currentColor.withOpacity(0.1),
                      blurRadius: 1,
                    ),
                    BoxShadow(
                      color: _currentColor.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isDense: true,
                    focusColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    value: _currentProject?.title,
                    dropdownColor: kcPrimary500,
                    elevation: Platform.isIOS ? 0 : 8,
                    alignment: AlignmentDirectional.center,
                    style: context.subtitle1.copyWith(
                      color: Colors.white,
                    ),
                    items: _projects.map<DropdownMenuItem<String>>(
                      (ProjectEntry project) {
                        return DropdownMenuItem<String>(
                          value: project.title,
                          child: Text(
                            project.title!,
                            textAlign: TextAlign.center,
                            style: context.subtitle1.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ).toList(),
                    hint: Text(
                      'Inbox',
                      textAlign: TextAlign.center,
                      style: context.subtitle1.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    onChanged: (String? newValue) {
                      final selectedProject = _projects.singleWhere(
                        (element) => element.title == newValue,
                      );
                      _settingOption.projectEntry = selectedProject;
                      _settingOption
                          .broadCastCurrentProjectEntry(selectedProject);
                      setState(() {
                        _currentProject = selectedProject;
                      });
                    },
                  ),
                ),
              ),
              verticalSpaceSmall,
              //* Main Task Text Field
              _buildTextInput(context),
              //* Adding SubTask
              StreamBuilder<List<String>>(
                stream: _subTaskStream.subTaskStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasError && snapshot.hasData) {
                    final _subTaskList = snapshot.data ?? [];
                    if (_subTaskList.isNotEmpty) {
                      final _subTextStyle = context.subtitle1.copyWith(
                        color: kcPrimary100,
                      );
                      const _textfieldPadding = EdgeInsets.all(8);

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < _subTaskList.length; i++)
                            PlatformTextField(
                              key: Key('sub_task_$i'),
                              // controller:
                              //     TextEditingController(text: _subTaskList[i]),
                              textAlign: TextAlign.center,
                              style: _subTextStyle,
                              scrollPadding: const EdgeInsets.all(2),
                              material: (context, platform) =>
                                  MaterialTextFieldData(
                                decoration: InputDecoration(
                                  contentPadding: _textfieldPadding,
                                  hintStyle: _subTextStyle.copyWith(
                                      color: Colors.white60),
                                  hintText: 'Enter new sub task ...',
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              cupertino: (context, platform) =>
                                  CupertinoTextFieldData(
                                placeholder: 'Enter new sub task ...',
                                placeholderStyle: _subTextStyle.copyWith(
                                    color: Colors.white60),
                                padding: _textfieldPadding,
                                decoration: const BoxDecoration(
                                    color: Colors.transparent),
                              ),
                              onChanged: (value) {
                                print('$i : $value');
                                _subTaskList[i] = value;

                                _subTaskStream.broadCastToSaveSubTaskListEntry(
                                    _subTaskList);
                              },
                            )
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              StreamBuilder<DateTime?>(
                stream: _settingOption.dueDateStream,
                builder: (context, snapshot) {
                  final _dueDate = snapshot.data;
                  return Text(
                    _dueDate != null
                        ? ' Due on ${CustomDateUtils.returnDateAndMonth(_dueDate)} '
                        : '',
                    style: context.textTheme.subtitle2!.copyWith(
                      color: kcPrimary700,
                      backgroundColor: kcPrimary200,
                    ),
                  ).padding(bottom: 16, top: 4).alignment(Alignment.center);
                },
              ),
            ].toColumn(mainAxisSize: MainAxisSize.min));
      } else {
        return progressIndicator;
      }
    });
  }

  Widget _buildTextInput(BuildContext context) {
    return PlatformTextField(
      controller: _textController,
      onChanged: _textStream.updateText,
      textAlign: TextAlign.center,
      autofocus: true,
      minLines: 1,
      maxLines: 4,
      style: context.h4.copyWith(
        color: kcPrimary100,
      ),
      material: (context, platform) => MaterialTextFieldData(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      cupertino: (context, platform) => CupertinoTextFieldData(
        placeholder: 'Enter...',
        placeholderStyle: context.h4.copyWith(color: Colors.white60),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          // borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    ).flexible();
  }
}
