import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/presentation/helper/custom_text_controller.dart';
import 'package:refocus_app/core/presentation/helper/setting_option.dart';
import 'package:refocus_app/core/presentation/helper/text_stream.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/helpers/regexp_matcher.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
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
  final _settingsOption = getIt<SettingOption>();
  final log = logger(AddTextFieldWidget);

  final _settingOption = getIt<SettingOption>();

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

    // _textSubscription = _textStream.getTextStream.listen((text) {
    //   final _currentTxt = _textController.text;
    //   if (_currentTxt != text) {
    //     _textController.text = text;
    //     _textController.selection = TextSelection.fromPosition(
    //         TextPosition(offset: _textController.text.length));
    //   }
    // });

    super.initState();

    _currentProject = _settingOption.projectEntry;
  }

  @override
  void dispose() {
    // _textSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(builder: (context, state) {
      if (state is ProjectLoaded) {
        final _projects = state.project;
        // log.d(_projects);
        return SizedBox(
            width: context.width,
            child: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: StyleUtils.getColorFromString(
                      _currentProject?.color ?? '#8879FC'),
                  boxShadow: const [kShadowPrimaryBase, kShadowPrimary100],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isDense: true,
                    focusColor: Colors.white,
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
              _buildTextInput(context),
              [
                StreamBuilder<DateTime?>(
                    stream: _settingsOption.dueDateStream,
                    builder: (context, snapshot) {
                      final _dueDate = snapshot.data;
                      return Text(
                        _dueDate != null
                            ? ' ${CustomDateUtils.returnDateAndMonth(_dueDate)} '
                            : '',
                        style: context.textTheme.subtitle2!.copyWith(
                          color: kcPrimary700,
                          backgroundColor: kcPrimary200,
                        ),
                      ).padding(left: 8, right: 8);
                    }),
                StreamBuilder<DateTime?>(
                    stream: _settingsOption.reminderStream,
                    builder: (context, snapshot) {
                      final _reminder = snapshot.data;
                      if (_reminder != null) {
                        final _date =
                            CustomDateUtils.returnDateWithDay(_reminder);
                        final _time = CustomDateUtils.returnTime(_reminder);
                        return Text(
                          ' $_date $_time ',
                          style: context.textTheme.subtitle2!.copyWith(
                            color: kcSecondary700,
                            backgroundColor: kcSecondary200,
                          ),
                        ).padding(right: 8);
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
              ]
                  .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                  .padding(bottom: 8, top: 4)
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
        placeholder: 'Enter ...',
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
