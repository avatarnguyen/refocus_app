import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:refocus_app/core/presentation/helper/setting_option.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/duedate_selection_type.dart';
import 'package:refocus_app/injection.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
  // final _textStream = getIt<TextStream>();
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
  @override
  void initState() {
    super.initState();

    if (widget.onSelectingReminder) {
      _remindDate = _settingOption.remindDate ?? DateTime.now();
    } else {
      _dueDate = _settingOption.dueDate ?? DateTime.now();
      _currentSelectedDueDate = _getCurrentDueDateSelectionType(_dueDate);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.onSelectingReminder) {
      if (_settingOption.remindDate == null) {
        _settingOption.broadCastCurrentReminderEntry(_remindDate);
      }
    }
    if (widget.onSelectingDueDate) {
      if (_settingOption.dueDate == null) {
        _currentSelectedDueDate = DueDateSelectionType.today;
        final _today = DateTime.now();
        _settingOption.broadCastCurrentDueDateEntry(_today);
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
          _showDatePickerBottomSheet(context);
        }),
        verticalSpaceSmall,
        [
          Text(
            CustomDateUtils.returnTime(_remindDate),
            style: context.textTheme.headline6!.copyWith(
              color: kcPrimary100,
            ),
          ).ripple().gestures(onTap: () {
            Platform.isIOS
                ? _cupertinoDateTimePicker(context, widget.currentText)
                : _materialTimePicker(context, widget.currentText);
          }),
          Text(' - ',
              style: context.textTheme.headline6!.copyWith(
                color: kcPrimary100,
              )),
          Text(
            CustomDateUtils.returnTime(_remindDate),
            style: context.textTheme.headline6!.copyWith(
              color: kcPrimary100,
            ),
          ).ripple().gestures(onTap: () {
            Platform.isIOS
                ? _cupertinoDateTimePicker(context, widget.currentText)
                : _materialTimePicker(context, widget.currentText);
          }),
        ].toRow(mainAxisAlignment: MainAxisAlignment.center),
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
            selectedColor: context.colorScheme.secondary,
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
            selected: _currentSelectedDueDate == _item,
            onSelected: (bool selected) {
              setState(() {
                _currentSelectedDueDate = _item;
                _mapSelectionToStream(_item, widget.currentText);
              });
            },
          ).paddingDirectional(horizontal: 4);
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
      return CustomDateUtils.returnDateAndMonth(date);
    }
  }

  String _getItemString(dynamic item) {
    if (item is DueDateSelectionType) {
      final _dueDateString = <String>[
        'Today',
        'Tomorrow',
        'Next Week',
        'Custom'
      ];
      return _dueDateString[item.index];
    } else {
      return item as String;
    }
  }

  void _mapSelectionToStream(DueDateSelectionType type, String? text) {
    if (type == DueDateSelectionType.custom) {
      _showDatePickerBottomSheet(context);
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

      _dueDate = _date;
      _settingOption.broadCastCurrentDueDateEntry(_date);
    }
  }

  // ignore: avoid_void_async
  void _materialTimePicker(BuildContext context, String? text) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => child ?? const SizedBox(),
    );
    if (picked != null) {
      final _remindDateTime = _settingOption.remindDate ?? DateTime.now();
      final _pickedDateTime = DateTime(
        _remindDateTime.year,
        _remindDateTime.month,
        _remindDateTime.day,
        picked.hour,
        picked.minute,
      );
      _settingOption.broadCastCurrentReminderEntry(_pickedDateTime);
      _remindDate = _pickedDateTime;
    }
  }

  dynamic _showDatePickerBottomSheet(
    BuildContext parentContext,
  ) async {
    final _currentDateTime =
        widget.onSelectingReminder ? _remindDate : _dueDate;
    if (_settingOption.remindDate == null && widget.onSelectingReminder) {
      _settingOption.broadCastCurrentReminderEntry(_currentDateTime);
    }
    final dynamic result = await showSlidingBottomSheet<dynamic>(
      context,
      builder: (context) {
        return SlidingSheetDialog(
          elevation: 8,
          cornerRadius: 16,
          duration: 500.milliseconds,
          color: context.backgroundColor,
          snapSpec: const SnapSpec(
            initialSnap: 0.5,
            snappings: [0.1, 0.7],
          ),
          minHeight: parentContext.height / 2.5,
          // headerBuilder: (context, state) {
          // },
          builder: (context, state) {
            return SafeArea(
              top: false,
              child: SizedBox(
                height: 360,
                child: SfDateRangePicker(
                  initialSelectedDate: DateTime.now(),
                  toggleDaySelection: true,
                  showActionButtons: true,
                  selectionColor: parentContext.colorScheme.secondary,
                  todayHighlightColor: parentContext.colorScheme.secondary,
                  cancelText: 'CLEAR',
                  onCancel: () {
                    if (widget.onSelectingReminder) {
                      _settingOption.broadCastCurrentReminderEntry(null);
                      _remindDate = DateTime.now();
                    } else {
                      _settingOption.broadCastCurrentDueDateEntry(null);
                      _currentSelectedDueDate = null;
                      _dueDate = DateTime.now();
                    }
                    setState(() {});

                    context.router.pop();
                  },
                  onSelectionChanged: _onSelectionChanged,
                  onSubmit: (Object value) {
                    context.router.pop();
                  },
                ).padding(all: 8),
              ),
            );
          },
        );
      },
    );
    return result;
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    final dynamic picked = args.value;
    if (picked is DateTime) {
      if (widget.onSelectingReminder) {
        _remindDate = picked;
        _settingOption.broadCastCurrentReminderEntry(picked);
      } else {
        _settingOption.broadCastCurrentDueDateEntry(picked);
        _dueDate = picked;
      }
    }
  }

  void _cupertinoDateTimePicker(BuildContext context, String? text) {
    final _currentDateTime =
        widget.onSelectingReminder ? _remindDate : _dueDate;
    if (_settingOption.remindDate == null) {
      _settingOption.broadCastCurrentReminderEntry(_currentDateTime);
    }
    showModalBottomSheet<dynamic>(
      context: context,
      backgroundColor: context.backgroundColor,
      builder: (BuildContext builder) {
        return [
          Container(
            height: context.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (picked) {
                if (picked != _currentDateTime) {
                  if (widget.onSelectingReminder) {
                    _remindDate = picked;
                    _settingOption.broadCastCurrentReminderEntry(picked);
                  } else {
                    _settingOption.broadCastCurrentDueDateEntry(picked);
                    _dueDate = picked;
                  }
                }
              },
              initialDateTime: _currentDateTime,
              use24hFormat: MediaQuery.of(context).alwaysUse24HourFormat,
              minimumYear: DateTime.now().year,
              maximumYear: DateTime.now().year + 4,
            ),
          ).flexible(),
          [
            CupertinoButton(
              onPressed: () {
                if (widget.onSelectingReminder) {
                  _settingOption.broadCastCurrentReminderEntry(null);
                  _remindDate = DateTime.now();
                } else {
                  _settingOption.broadCastCurrentDueDateEntry(null);
                  _currentSelectedDueDate = null;
                  _dueDate = DateTime.now();
                }
                setState(() {});
                context.router.pop();
              },
              child: Text(
                'Clear',
                style: context.bodyText2.copyWith(
                  color: Colors.redAccent,
                ),
              ),
            ),
            CupertinoButton(
              onPressed: () {
                setState(() {});
                context.router.pop();
              },
              child: const Text('Done'),
            ),
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceEvenly),
        ].toColumn(mainAxisSize: MainAxisSize.min).safeArea();
      },
    );
  }
}
