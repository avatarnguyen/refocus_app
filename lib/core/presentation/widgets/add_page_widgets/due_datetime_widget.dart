import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
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
  late DateTime _plannedStartDate;
  late DateTime _plannedEndDate;
  Duration _currentDuration = 1.hours;

  @override
  void initState() {
    super.initState();

    if (widget.onSelectingReminder) {
      _plannedStartDate = _settingOption.plannedStartDate ?? DateTime.now();
      _plannedEndDate = _settingOption.plannedStartDate ?? 1.hours.fromNow;
    } else {
      _dueDate = _settingOption.dueDate ?? DateTime.now();
      _currentSelectedDueDate = _getCurrentDueDateSelectionType(_dueDate);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.onSelectingReminder) {
      if (_settingOption.plannedStartDate == null) {
        _settingOption.broadCastCurrentStartTimeEntry(_plannedStartDate);
        _settingOption.broadCastCurrentEndTimeEntry(_plannedEndDate);
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
      return _buildSetDueDate(context).padding(bottom: 4);
    } else {
      return _buildSetReminder(context);
    }
  }

  Widget _buildSetReminder(BuildContext context) {
    return SizedBox(
        width: context.width,
        child: [
          Text(
            _formatDateToHumanLang(_plannedStartDate),
            style: context.h3
                .copyWith(color: kcPrimary100, fontWeight: FontWeight.w400),
          ).ripple().gestures(onTap: () {
            _showDatePickerBottomSheet(context);
          }),
          verticalSpaceRegular,
          [
            TimePickerSpinner(
              key: Key(_plannedStartDate.toIso8601String()),
              is24HourMode: MediaQuery.of(context).alwaysUse24HourFormat,
              alignment: Alignment.center,
              time: _plannedStartDate,
              normalTextStyle: context.subtitle1.copyWith(
                color: Colors.white30,
              ),
              highlightedTextStyle: context.subtitle1.copyWith(
                color: Colors.white,
              ),
              itemHeight: 32,
              itemWidth: 36,
              spacing: 0,
              // ignore: unnecessary_lambdas
              onTimeChange: (time) {
                _settingOption.broadCastCurrentStartTimeEntry(time);
                setState(() {
                  _plannedStartDate = time;
                  _plannedEndDate = time + _currentDuration;
                });
              },
            ),
            const Icon(
              Icons.arrow_right_alt_rounded,
              color: kcPrimary100,
            ).padding(horizontal: 4),
            TimePickerSpinner(
              key: Key(_plannedEndDate.toIso8601String()),
              is24HourMode: MediaQuery.of(context).alwaysUse24HourFormat,
              alignment: Alignment.center,
              time: _plannedEndDate,
              normalTextStyle: context.subtitle1.copyWith(
                color: Colors.white30,
              ),
              highlightedTextStyle: context.subtitle1.copyWith(
                color: Colors.white,
              ),
              itemHeight: 32,
              itemWidth: 36,
              spacing: 0,
              onTimeChange: (time) {
                if (time.difference(_plannedStartDate) < 0.minutes) {
                  time += 1.days;
                }
                _settingOption.broadCastCurrentEndTimeEntry(time);
                setState(() {
                  _currentDuration = time.difference(_plannedStartDate);
                });
              },
            ),
          ].toRow(mainAxisAlignment: MainAxisAlignment.center),
          [
            _buildSelectionMode(context, 'date range'),
            _buildSelectionMode(context, 'all date'),
            // _buildSelectionMode(context, 'recurrence'),
          ]
              .toRow(mainAxisAlignment: MainAxisAlignment.spaceEvenly)
              .padding(vertical: 8),
          // verticalSpaceMedium,
        ].toColumn());
  }

  Widget _buildSelectionMode(BuildContext context, String title) {
    return ChoiceChip(
      backgroundColor: kcDarkBackground,
      selectedColor: context.colorScheme.secondary,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: kcDarkBackground),
        borderRadius: BorderRadius.circular(8),
      ),
      label: Text(
        title,
        style: context.subtitle1.copyWith(
          color: kcPrimary100,
        ),
      ),
      selected: false,
      onSelected: (bool selected) {
        setState(() {});
      },
    ).flexible();
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

  dynamic _showDatePickerBottomSheet(
    BuildContext parentContext,
  ) async {
    final _currentDateTime =
        widget.onSelectingReminder ? _plannedStartDate : _dueDate;
    // if (_settingOption.remindDate == null && widget.onSelectingReminder) {
    //   _settingOption.broadCastCurrentReminderEntry([_currentDateTime]);
    // }
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
                  initialSelectedDate: _currentDateTime,
                  toggleDaySelection: true,
                  showActionButtons: true,
                  selectionColor: parentContext.colorScheme.secondary,
                  todayHighlightColor: parentContext.colorScheme.secondary,
                  cancelText: 'CLEAR',
                  onCancel: () {
                    if (widget.onSelectingReminder) {
                      _settingOption.broadCastCurrentStartTimeEntry(null);
                      _settingOption.broadCastCurrentEndTimeEntry(null);
                      setState(() {
                        _plannedStartDate = DateTime.now();
                        _plannedEndDate = 1.hours.fromNow;
                      });
                    } else {
                      _settingOption.broadCastCurrentDueDateEntry(null);
                      setState(() {
                        _currentSelectedDueDate = null;
                        _dueDate = DateTime.now();
                      });
                    }

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
        _plannedStartDate = picked.copyWith(
          hour: _plannedStartDate.hour,
          minute: _plannedStartDate.minute,
          second: _plannedStartDate.second,
        );
        _settingOption.broadCastCurrentStartTimeEntry(_plannedStartDate);
        _settingOption
            .broadCastCurrentEndTimeEntry(_plannedStartDate + _currentDuration);
        setState(() {});
      } else {
        _settingOption.broadCastCurrentDueDateEntry(picked);
        _dueDate = picked;
      }
    }
  }
}
