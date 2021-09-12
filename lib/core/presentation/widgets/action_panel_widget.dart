import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:refocus_app/enum/duedate_selection_type.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/project_params.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:dartx/dartx.dart';

import 'package:uuid/uuid.dart';
import 'package:get/get.dart';

import '../../../injection.dart';
import '../text_stream.dart';
import 'setting_option.dart';

class ActionPanelWidget extends StatefulWidget {
  const ActionPanelWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ActionPanelWidgetState createState() => _ActionPanelWidgetState();
}

class _ActionPanelWidgetState extends State<ActionPanelWidget> {
  Uuid uuid = const Uuid();

  final _textStream = getIt<TextStream>();
  final _settingOption = getIt<SettingOption>();
  bool _onSelectingProject = false;
  bool _onSelectingDueDate = false;
  bool _onSelectingReminder = false;
  bool _onSelectingPrio = false;

  final _dueDateSelectionItems = [
    DueDateSelectionType.today,
    DueDateSelectionType.tomorrow,
    DueDateSelectionType.nextWeek,
    DueDateSelectionType.custom
  ];
  DueDateSelectionType? _currentSelectedDueDate;

  var _selectedDate = DateTime.now();
  var _remindDate = DateTime.now();
  var _remindTime = TimeOfDay.now();

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
        final _currentText = textStream.data;
        return [
          BlocBuilder<ProjectBloc, ProjectState>(
            builder: (context, state) {
              if (state is ProjectLoaded) {
                final _projects = state.project;
                if (_onSelectingProject) {
                  return _buildSelectionListRow(
                      context, _projects, _currentText);
                } else if (_onSelectingDueDate) {
                  return _buildSelectionListRow(
                    context,
                    _dueDateSelectionItems,
                    _currentText,
                  );
                } else if (_onSelectingReminder) {
                  return SizedBox(
                    width: context.width,
                    child: [
                      Text(
                        _formatDateToHumanLang(_remindDate),
                        style: context.textTheme.headline3!.copyWith(
                            color: kcPrimary100, fontWeight: FontWeight.w400),
                      ).ripple().gestures(onTap: () {
                        Platform.isIOS
                            ? _cupertinoDateTimePicker(context, _currentText)
                            : _materialDateTimePicker(context, _currentText);
                      }),
                      verticalSpaceSmall,
                      Text(
                        _remindTime.format(context),
                        style: context.textTheme.headline6!.copyWith(
                          color: kcPrimary100,
                        ),
                      ).ripple().gestures(onTap: () {
                        Platform.isIOS
                            ? _cupertinoDateTimePicker(context, _currentText)
                            : _materialTimePicker(context, _currentText);
                      }),
                      verticalSpaceRegular,
                    ].toColumn(
                      mainAxisSize: MainAxisSize.min,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              } else {
                return const SizedBox();
              }
            },
          ),
          verticalSpaceRegular,
          _buildActionInputRow(textStream.data, context)
        ].toColumn(
          mainAxisSize: MainAxisSize.min,
        );
      },
    );
  }

  String _formatDateToHumanLang(DateTime date) {
    if (date.isToday) {
      return 'Today';
    } else if (date.isTomorrow) {
      return 'Tomorrow';
    } else {
      return DateFormat.yMEd().format(date);
    }
  }

  String _getItemString(dynamic item) {
    if (item is ProjectEntry) {
      return item.title?.trim() ?? '';
    } else if (item is DueDateSelectionType) {
      var _dueDateString = <String>['Today', 'Tomorrow', 'Next Week', 'Custom'];
      return _dueDateString[item.index];
    } else {
      return item as String;
    }
  }

  String _replaceDateString(String originText, String replaceText) {
    final _matcher = RegExp(
        r'([on]{2}( |)+([MTWFS]{1})+(\w{2})+(, |,)+(0?[1-9]|1[0-2])[\/](0?[1-9]|[12]\d|3[01])[\/](19|20)\d{2})+\b');
    if (originText.contains(_matcher)) {
      return originText.replaceFirst(_matcher, 'on $replaceText');
    } else {
      return '$originText on $replaceText';
    }
  }

  String _replaceTimeString(
      String originText, String replaceDate, String replaceTime) {
    final _matcherDate = RegExp(
        r'([?]|[remind]{3,6}|[alarm]{3,6})( ?)(([on]*)( ?)([MTWFS]+)(\w{2})(,?)( ?)(0?[1-9]|1[0-2])[\/](0?[1-9]|[12]\d|3[01])[\/](19|20)\d{2})');
    final _matcherTime = RegExp(
        r'((at ?)((([0-1]?\d)|(2[0-3]))(:|\.|)?[0-5][0-9]|((0?[1-9])|(1[0-2]))(:|\.|)([0-5][0-9]))(( ||,)([aA]|[pP])[mM]|([aA]|[pP])[mM])?)');
    var _tmpStr = originText;

    if (_tmpStr.contains(_matcherDate) || _tmpStr.contains(_matcherTime)) {
      _tmpStr = _tmpStr.replaceFirst(_matcherDate, 'remind on $replaceDate');
      _tmpStr = _tmpStr.replaceFirst(_matcherTime, 'at $replaceTime');
    } else {
      _tmpStr = '$_tmpStr remind $replaceDate at $replaceTime';
    }
    return _tmpStr;
  }

  void _mapSelectionToTextStream(DueDateSelectionType type, String? text) {
    if (type == DueDateSelectionType.today) {
      final _today = DateTime.now();
      final _todayStr = DateFormat.yMEd().format(_today);
      final _updatedText = _replaceDateString(text ?? '', _todayStr);
      _textStream.updateText(_updatedText);
      _selectedDate = _today;
    } else if (type == DueDateSelectionType.tomorrow) {
      final _date = DateTime.now() + 1.days;
      final _dateStr = DateFormat.yMEd().format(_date);
      final _updatedText = _replaceDateString(text ?? '', _dateStr);
      _textStream.updateText(_updatedText);
      _selectedDate = _date;
    } else if (type == DueDateSelectionType.nextWeek) {
      final _date = 1.weeks.fromNow;
      final _dateStr = DateFormat.yMEd().format(_date);
      final _updatedText = _replaceDateString(text ?? '', _dateStr);
      _textStream.updateText(_updatedText);
      _selectedDate = _date;
    } else {
      Platform.isIOS
          ? _cupertinoDateTimePicker(context, text)
          : _materialDateTimePicker(context, text);
    }
  }

  void _materialDateTimePicker(BuildContext context, String? text) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (context, child) => child ?? const SizedBox(),
    );
    if (picked != null && picked != _selectedDate) {
      final _dateStr = DateFormat.yMEd().format(picked);
      if (_onSelectingReminder) {
        final _timeStr = _remindTime.format(context);
        final _updatedText = _replaceTimeString(text ?? '', _dateStr, _timeStr);
        _textStream.updateText(_updatedText);
        _remindDate = picked;
      } else {
        final _updatedText = _replaceDateString(text ?? '', _dateStr);
        _textStream.updateText(_updatedText);
        _selectedDate = picked;
      }
    }
  }

  void _materialTimePicker(BuildContext context, String? text) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => child ?? const SizedBox(),
    );
    if (picked != null) {
      final _dateStr = DateFormat.yMEd().format(_remindDate);
      final _timeStr = picked.format(context); //TimeOfDayFormat.HH_colon_mm
      final _updatedText = _replaceTimeString(text ?? '', _dateStr, _timeStr);
      _textStream.updateText(_updatedText);
      _remindTime = picked;
    }
  }

  void _cupertinoDateTimePicker(BuildContext context, String? text) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.theme.backgroundColor,
      builder: (BuildContext builder) {
        return [
          Container(
            height: context.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: _onSelectingReminder
                  ? CupertinoDatePickerMode.dateAndTime
                  : CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != _selectedDate) {
                  final _dateStr = DateFormat.yMEd().format(picked);
                  if (_onSelectingReminder) {
                    _remindDate = picked;
                    _remindTime = TimeOfDay.fromDateTime(picked);
                    final _timeStr = _remindTime.format(context);
                    final _updatedText =
                        _replaceTimeString(text ?? '', _dateStr, _timeStr);
                    _textStream.updateText(_updatedText);
                  } else {
                    final _updatedText =
                        _replaceDateString(text ?? '', _dateStr);
                    _textStream.updateText(_updatedText);
                    _selectedDate = picked;
                  }
                }
              },
              initialDateTime: _selectedDate,
              use24hFormat: context.mediaQuery.alwaysUse24HourFormat,
              minimumYear: DateTime.now().year,
              maximumYear: DateTime.now().year + 3,
            ),
          ).flexible(),
          PlatformButton(
            onPressed: Get.back,
            child: const Text('Done'),
          ),
        ].toColumn(mainAxisSize: MainAxisSize.min).safeArea();
      },
    );
  }

  Widget _buildSelectionListRow(
      BuildContext context, List items, String? currentText) {
    return SizedBox(
      height: 44,
      width: context.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final _item = items[index];
          return ChoiceChip(
            backgroundColor: kcPrimary800,
            selectedColor: context.theme.accentColor,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: kcPrimary100),
              borderRadius: BorderRadius.circular(8),
            ),
            label: Text(
              _getItemString(_item),
              style: context.textTheme.subtitle1!.copyWith(
                color: kcPrimary100,
              ),
            ),
            selected: (_settingOption.projectEntry == _item ||
                _currentSelectedDueDate == _item),
            onSelected: (bool selected) {
              setState(() {
                if (_item is ProjectEntry) {
                  _settingOption.projectEntry = _item;
                  _settingOption.broadCastCurrentProjectEntry(_item);
                }
                if (_item is DueDateSelectionType) {
                  _currentSelectedDueDate = _item;
                  _mapSelectionToTextStream(_item, currentText);
                }
              });
            },
          ).paddingSymmetric(horizontal: 4.0);
        },
      ),
    );
  }

  //* Action Row at the Bottom
  Container _buildActionInputRow(String? textData, BuildContext context) {
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
              _onSelectingDueDate = false;
              _onSelectingReminder = false;
              _onSelectingProject = !_onSelectingProject;
            });
          }),
          //* Adding due dates and reminder
          _buildActionItem(Icons.calendar_today,
                  color: _onSelectingDueDate
                      ? context.theme.accentColor
                      : kcSecondary200)
              .gestures(onTap: () {
            if (!_onSelectingDueDate && _currentSelectedDueDate == null) {
              _currentSelectedDueDate = DueDateSelectionType.today;
              final _today = DateTime.now();
              final _todayStr = DateFormat.yMEd().format(_today);
              final _updatedText =
                  _replaceDateString(textData ?? '', _todayStr);
              _textStream.updateText(_updatedText);
            }
            setState(() {
              _onSelectingProject = false;
              _onSelectingReminder = false;
              _onSelectingDueDate = !_onSelectingDueDate;
            });
          }),
          _buildActionItem(
            Icons.alarm_add,
            color: _onSelectingReminder
                ? context.theme.accentColor
                : kcSecondary200,
          ).gestures(onTap: () {
            if (!_onSelectingReminder) {
              final _dateStr = DateFormat.yMEd().format(_remindDate);
              final _timeStr = _remindTime.format(context);
              final _updatedText =
                  _replaceTimeString(textData ?? '', _dateStr, _timeStr);
              _textStream.updateText(_updatedText);
            }
            setState(() {
              _onSelectingProject = false;
              _onSelectingDueDate = false;
              _onSelectingReminder = !_onSelectingReminder;
            });
          }),
          // Adding Priority
          _buildActionItem(Icons.flag).gestures(
              onTap: () => _textStream.updateText('${textData ?? ''}!')),
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
                    ProjectEntry(id: uuid.v1(), title: textData))),
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
                            title: textData,
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
