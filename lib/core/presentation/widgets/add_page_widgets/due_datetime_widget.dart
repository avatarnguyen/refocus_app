import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:refocus_app/core/presentation/helper/setting_option.dart';
import 'package:refocus_app/core/presentation/helper/text_stream.dart';
import 'package:refocus_app/core/util/helpers/regexp_matcher.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/duedate_selection_type.dart';
import 'package:refocus_app/injection.dart';
import 'package:styled_widget/styled_widget.dart';

class DueDateTimeWidget extends StatefulWidget {
  const DueDateTimeWidget({
    Key? key,
    required this.currentText,
    required this.onSelectingReminder,
    required this.onSelectingDueDate,
  }) : super(key: key);

  final String currentText;
  final bool onSelectingReminder;
  final bool onSelectingDueDate;

  @override
  _DueDateTimeWidgetState createState() => _DueDateTimeWidgetState();
}

class _DueDateTimeWidgetState extends State<DueDateTimeWidget> {
  final _textStream = getIt<TextStream>();
  final _settingOption = getIt<SettingOption>();

  final _dueDateSelectionItems = [
    DueDateSelectionType.today,
    DueDateSelectionType.tomorrow,
    DueDateSelectionType.nextWeek,
    DueDateSelectionType.custom
  ];
  DueDateSelectionType? _currentSelectedDueDate;

  late DateTime _dueDate;
  late DateTime _remindDate;
  late TimeOfDay _remindTime;

  final _matcherDueDate = StringMatcher.matcherDueDate;
  final _matcherRemindDate = StringMatcher.matcherRemindDate;
  final _matcherRemindTime = StringMatcher.matcherRemindTime;

  @override
  void initState() {
    super.initState();

    // print('Due Date Widget INIT ${widget.onSelectingDueDate}');

    if (widget.onSelectingReminder) {
      _remindDate = _settingOption.remindDate ?? DateTime.now();
      _remindTime = _settingOption.remindTime ?? TimeOfDay.now();
    } else {
      _dueDate = _settingOption.dueDate ?? DateTime.now();
      _currentSelectedDueDate = _getCurrentDueDateSelectionType(_dueDate);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.onSelectingReminder) {
      if (!(widget.currentText.contains(_matcherRemindDate) ||
          widget.currentText.contains(_matcherRemindTime))) {
        final _dateStr = DateFormat.yMEd().format(_remindDate);
        final _timeStr = _remindTime.format(context);
        final _updatedText =
            _replaceTimeString(widget.currentText, _dateStr, _timeStr);
        _textStream.updateText(_updatedText);
      }
    }
    if (widget.onSelectingDueDate) {
      if (!widget.currentText.contains(_matcherDueDate)) {
        _currentSelectedDueDate = DueDateSelectionType.today;
        final _today = DateTime.now();
        final _todayStr = DateFormat.yMEd().format(_today);
        final _updatedText = _replaceDateString(widget.currentText, _todayStr);
        _textStream.updateText(_updatedText);
        _settingOption.dueDate = _today;
      }
    }
  }

  DueDateSelectionType _getCurrentDueDateSelectionType(DateTime date) {
    if (date.isToday) {
      return DueDateSelectionType.today;
    } else if (date.isTomorrow) {
      return DueDateSelectionType.tomorrow;
    } else if (date.isAtSameDayAs(1.weeks.fromNow)) {
      return DueDateSelectionType.nextWeek;
    } else {
      return DueDateSelectionType.custom;
    }
  }

  @override
  void dispose() {
    // _settingOption.dueDate = DateTime.now();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onSelectingDueDate) {
      return _buildSetDueDate(context);
    } else {
      return _buildSetReminder(context);
    }
  }

  Widget _buildSetReminder(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: [
        Text(
          _formatDateToHumanLang(_remindDate),
          style: context.textTheme.headline3!
              .copyWith(color: kcPrimary100, fontWeight: FontWeight.w400),
        ).ripple().gestures(onTap: () {
          Platform.isIOS
              ? _cupertinoDateTimePicker(context, widget.currentText)
              : _materialDateTimePicker(context, widget.currentText);
        }),
        verticalSpaceSmall,
        Text(
          _remindTime.format(context),
          style: context.textTheme.headline6!.copyWith(
            color: kcPrimary100,
          ),
        ).ripple().gestures(onTap: () {
          Platform.isIOS
              ? _cupertinoDateTimePicker(context, widget.currentText)
              : _materialTimePicker(context, widget.currentText);
        }),
        verticalSpaceRegular,
      ].toColumn(
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }

  Widget _buildSetDueDate(BuildContext context) {
    return SizedBox(
      height: 44,
      width: context.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _dueDateSelectionItems.length,
        itemBuilder: (context, index) {
          final _item = _dueDateSelectionItems[index];
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
            selected: (_currentSelectedDueDate == _item),
            onSelected: (bool selected) {
              setState(() {
                _currentSelectedDueDate = _item;
                _mapSelectionToTextStream(_item, widget.currentText);
              });
            },
          ).paddingSymmetric(horizontal: 4.0);
        },
      ),
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
    if (item is DueDateSelectionType) {
      var _dueDateString = <String>['Today', 'Tomorrow', 'Next Week', 'Custom'];
      return _dueDateString[item.index];
    } else {
      return item as String;
    }
  }

  String _replaceDateString(String originText, String replaceText) {
    if (originText.contains(_matcherDueDate)) {
      return originText.replaceFirst(_matcherDueDate, 'on $replaceText');
    } else {
      return '$originText on $replaceText';
    }
  }

  String _replaceTimeString(
      String originText, String replaceDate, String replaceTime) {
    var _tmpStr = originText;

    if (_tmpStr.contains(_matcherRemindDate) ||
        _tmpStr.contains(_matcherRemindTime)) {
      _tmpStr = _tmpStr.replaceFirst(_matcherRemindDate, '?$replaceDate');
      _tmpStr = _tmpStr.replaceFirst(_matcherRemindTime, 'at $replaceTime');
    } else {
      _tmpStr = '$_tmpStr ?$replaceDate at $replaceTime';
    }
    return _tmpStr;
  }

  void _mapSelectionToTextStream(DueDateSelectionType type, String? text) {
    if (type == DueDateSelectionType.custom) {
      Platform.isIOS
          ? _cupertinoDateTimePicker(context, text)
          : _materialDateTimePicker(context, text);
    } else {
      late DateTime _date;
      switch (type) {
        case DueDateSelectionType.today:
          _date = DateTime.now();
          break;
        case DueDateSelectionType.tomorrow:
          _date = 1.days.fromNow;
          break;
        case DueDateSelectionType.nextWeek:
          _date = 1.weeks.fromNow;
          break;
        default:
          break;
      }

      final _dateStr = DateFormat.yMEd().format(_date);
      final _updatedText = _replaceDateString(text ?? '', _dateStr);
      _textStream.updateText(_updatedText);
      _dueDate = _date;
      _settingOption.dueDate = _date;
    }
  }

  void _materialDateTimePicker(BuildContext context, String? text) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (context, child) => child ?? const SizedBox(),
    );
    if (picked != null && picked != _dueDate) {
      final _dateStr = DateFormat.yMEd().format(picked);
      if (widget.onSelectingReminder) {
        final _timeStr = _remindTime.format(context);
        final _updatedText = _replaceTimeString(text ?? '', _dateStr, _timeStr);
        _textStream.updateText(_updatedText);
        _remindDate = picked;
        _settingOption.remindDate = picked;
      } else {
        final _updatedText = _replaceDateString(text ?? '', _dateStr);
        _textStream.updateText(_updatedText);
        _dueDate = picked;
        _settingOption.dueDate = picked;
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
      _settingOption.remindTime = picked;
    }
  }

  void _cupertinoDateTimePicker(BuildContext context, String? text) {
    final _currentDateTime =
        widget.onSelectingReminder ? _remindDate : _dueDate;
    showModalBottomSheet<dynamic>(
      context: context,
      backgroundColor: context.theme.backgroundColor,
      builder: (BuildContext builder) {
        return [
          Container(
            height: context.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: widget.onSelectingReminder
                  ? CupertinoDatePickerMode.dateAndTime
                  : CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != _currentDateTime) {
                  final _dateStr = DateFormat.yMEd().format(picked);
                  if (widget.onSelectingReminder) {
                    _remindDate = picked;
                    _settingOption.remindDate = picked;
                    _remindTime = TimeOfDay.fromDateTime(picked);
                    _settingOption.remindTime = _remindTime;

                    final _timeStr = _remindTime.format(context);
                    final _updatedText =
                        _replaceTimeString(text ?? '', _dateStr, _timeStr);
                    _textStream.updateText(_updatedText);
                  } else {
                    final _updatedText =
                        _replaceDateString(text ?? '', _dateStr);
                    _textStream.updateText(_updatedText);
                    _dueDate = picked;
                    _settingOption.dueDate = picked;
                  }
                }
              },
              initialDateTime:
                  widget.onSelectingDueDate ? _dueDate : _remindDate,
              use24hFormat: context.mediaQuery.alwaysUse24HourFormat,
              minimumYear: DateTime.now().year,
              maximumYear: DateTime.now().year + 4,
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
}
