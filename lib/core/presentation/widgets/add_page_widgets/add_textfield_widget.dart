import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/presentation/helper/custom_text_controller.dart';
import 'package:refocus_app/core/presentation/helper/setting_option.dart';
import 'package:refocus_app/core/presentation/helper/subtask_stream.dart';
import 'package:refocus_app/core/presentation/helper/text_stream.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/helpers/regexp_matcher.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/loading_widget.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
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
  CalendarEntry? _currentCalendar;

  bool _isEvent = false;

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

    BlocProvider.of<CalendarListBloc>(context, listen: false)
        .add(GetCalendarListEvent());
  }

  @override
  void dispose() {
    _textSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TodayEntryType>(
        stream: _settingOption.typeStream,
        builder: (context, snapshot) {
          final _entryType = snapshot.data;
          if (_entryType != null) {
            _isEvent = _entryType == TodayEntryType.event;
            if (_entryType == TodayEntryType.event) {
              return BlocBuilder<CalendarListBloc, CalendarListState>(
                  builder: (context, state) {
                if (state is Loaded) {
                  final calendars = state.calendarList;
                  final _currentColor = StyleUtils.getColorFromString(
                      _currentCalendar?.color ?? '#8879FC');
                  return _buildEventElements(_currentColor, context, calendars);
                } else {
                  return const LoadingWidget();
                }
              });
            } else {
              return BlocBuilder<ProjectBloc, ProjectState>(
                  builder: (context, state) {
                if (state is ProjectLoaded) {
                  final _projects = state.project;
                  final _currentColor = StyleUtils.getColorFromString(
                      _currentProject?.color ?? '#8879FC');
                  return _buildTaskElements(context, _currentColor, _projects);
                } else {
                  return progressIndicator;
                }
              });
            }
          }
          return const SizedBox.shrink();
        });
  }

  Widget _buildEventElements(Color _currentColor, BuildContext context,
      List<CalendarEntry> calendars) {
    return SizedBox(
      width: context.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
                value: _currentCalendar?.name,
                dropdownColor: _currentColor,
                elevation: Platform.isIOS ? 0 : 8,
                alignment: AlignmentDirectional.center,
                style: context.subtitle1.copyWith(
                  color: Colors.white,
                ),
                items: calendars.map<DropdownMenuItem<String>>(
                  (CalendarEntry _cal) {
                    return DropdownMenuItem<String>(
                      value: _cal.name,
                      child: Text(
                        _cal.name,
                        textAlign: TextAlign.center,
                        style: context.subtitle1.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ).toList(),
                hint: Text(
                  'Select a calendars ...',
                  textAlign: TextAlign.center,
                  style: context.subtitle1.copyWith(
                    color: Colors.white,
                  ),
                ),
                onChanged: (String? newValue) {
                  final selectedCal = calendars.singleWhere(
                    (element) => element.name == newValue,
                  );
                  _settingOption.broadCastCurrentCalendarEntry(selectedCal);
                  setState(() {
                    _currentCalendar = selectedCal;
                  });
                },
              ),
            ),
          ),
          verticalSpaceSmall,
          //* Main Task Text Field
          _buildTextInput(context),
        ],
      ),
    );
  }

  SizedBox _buildTaskElements(
      BuildContext context, Color _currentColor, List<ProjectEntry> _projects) {
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
                dropdownColor: _currentColor,
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
                  _settingOption.broadCastCurrentProjectEntry(selectedProject);
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
                          textAlign: TextAlign.center,
                          style: _subTextStyle,
                          scrollPadding: const EdgeInsets.all(2),
                          material: (context, platform) =>
                              MaterialTextFieldData(
                            decoration: InputDecoration(
                              contentPadding: _textfieldPadding,
                              hintStyle:
                                  _subTextStyle.copyWith(color: Colors.white60),
                              hintText: 'Enter new sub task ...',
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          cupertino: (context, platform) =>
                              CupertinoTextFieldData(
                            placeholder: 'Enter new sub task ...',
                            placeholderStyle:
                                _subTextStyle.copyWith(color: Colors.white60),
                            padding: _textfieldPadding,
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                          ),
                          onChanged: (value) {
                            print('$i : $value');
                            _subTaskList[i] = value;

                            _subTaskStream
                                .broadCastToSaveSubTaskListEntry(_subTaskList);
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
  }

  Widget _buildTextInput(BuildContext context) {
    return PlatformTextField(
      controller: _textController,
      onChanged: _textStream.updateText,
      textAlign: TextAlign.center,
      autofocus: true,
      minLines: 1,
      maxLines: 4,
      style: context.h4.copyWith(color: kcPrimary100),
      material: (context, platform) => MaterialTextFieldData(
        decoration: InputDecoration(
          hintText: _isEvent ? 'What is your plan?' : 'What is your task?',
          hintStyle: context.h4.copyWith(color: Colors.white38),
          contentPadding: const EdgeInsets.all(16),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      cupertino: (context, platform) => CupertinoTextFieldData(
        placeholder: _isEvent ? 'What is your plan?' : 'What is your task?',
        placeholderStyle: context.h4.copyWith(color: Colors.white38),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
      ),
    ).flexible();
  }
}
