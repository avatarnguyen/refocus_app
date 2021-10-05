import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:refocus_app/core/presentation/helper/setting_option.dart';
import 'package:refocus_app/core/presentation/widgets/add_page_widgets/add_timeblock_widget.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/date_selection_type.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/injection.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SetPlannedDateTimeWidget extends StatefulWidget {
  const SetPlannedDateTimeWidget({
    Key? key,
    this.textColor,
  }) : super(key: key);

  final Color? textColor;

  @override
  _SetPlannedDateTimeWidgetState createState() =>
      _SetPlannedDateTimeWidgetState();
}

class _SetPlannedDateTimeWidgetState extends State<SetPlannedDateTimeWidget> {
  // final _textStream = getIt<TextStream>();
  final _settingOption = getIt<SettingOption>();

  late DateTime _plannedStartDate;
  late DateTime _plannedEndDate;
  Duration _currentDuration = 1.hours;

  bool _isAllDay = false;
  bool _isDateRange = false;
  bool _isSomeday = false;
  bool _isDifferenDate = false;
  // late DateSelectionType _currentDateType;

  @override
  void initState() {
    super.initState();
    // _currentDateType = DateSelectionType.dateTime;
    _plannedStartDate = _settingOption.plannedStartDate ?? DateTime.now();
    _plannedEndDate = _settingOption.plannedEndDate ?? 1.hours.fromNow;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_settingOption.plannedStartDate == null) {
      _settingOption.broadCastCurrentStartTimeEntry(_plannedStartDate);
      _settingOption.broadCastCurrentEndTimeEntry(_plannedEndDate);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildSetReminder(context);
  }

  Widget _buildSetReminder(BuildContext context) {
    final _textColor = widget.textColor ?? kcPrimary100;

    return SizedBox(
      width: context.width,
      height: 280,
      child: [
        if (_isSomeday)
          Text(
            'Someday',
            style: context.h3
                .copyWith(color: _textColor, fontWeight: FontWeight.w400),
          )
        else
          [
            Text(
              _formatDateToHumanLang(_plannedStartDate),
              style: context.h3
                  .copyWith(color: _textColor, fontWeight: FontWeight.w400),
            ).ripple().gestures(onTap: () {
              _showDatePickerBottomSheet(context);
            }),
            if (_isDifferenDate) ...[
              Icon(Icons.arrow_right_alt_rounded, color: _textColor)
                  .padding(horizontal: 8),
              Text(
                _formatDateToHumanLang(_plannedStartDate + 1.days),
                style: context.h4.copyWith(color: _textColor),
              ),
            ]
          ].toRow(mainAxisAlignment: MainAxisAlignment.center),
        verticalSpaceRegular,
        if (!_isAllDay && !_isDateRange && !_isSomeday)
          [
            TimePickerSpinner(
              key: Key(_plannedStartDate.toIso8601String()),
              is24HourMode: MediaQuery.of(context).alwaysUse24HourFormat,
              alignment: Alignment.center,
              time: _plannedStartDate,
              normalTextStyle: context.subtitle1.copyWith(
                color: widget.textColor?.withOpacity(0.4) ?? Colors.white30,
              ),
              highlightedTextStyle: context.subtitle1.copyWith(
                color: _textColor,
              ),
              itemHeight: 36,
              itemWidth: 36,
              spacing: 0,
              onTimeChange: (time) {
                _settingOption.broadCastCurrentStartTimeEntry(time);
                setState(() {
                  _plannedStartDate = time;
                  _plannedEndDate = time + _currentDuration;
                });
              },
            ),
            Icon(
              Icons.arrow_right_alt_rounded,
              color: _textColor,
            ).padding(horizontal: 4),
            SizedBox(
              child: TimePickerSpinner(
                key: Key(_plannedEndDate.toIso8601String()),
                is24HourMode: MediaQuery.of(context).alwaysUse24HourFormat,
                alignment: Alignment.center,
                time: _plannedEndDate,
                normalTextStyle: context.subtitle1.copyWith(
                  color: widget.textColor?.withOpacity(0.4) ?? Colors.white30,
                ),
                highlightedTextStyle: context.subtitle1.copyWith(
                  color: _textColor,
                ),
                itemHeight: 36,
                itemWidth: 36,
                spacing: 0,
                onTimeChange: (time) {
                  // print('$_plannedStartDate --> $time');
                  // print(time.isBefore(_plannedStartDate));
                  final _timeDif = time.difference(_plannedStartDate);
                  debugPrint('Time Diff: $_timeDif');
                  //! Bug might occurs here
                  if (_timeDif < 0.minutes || _timeDif > 12.hours) {
                    time += 1.days;
                    _isDifferenDate = true;
                  } else {
                    _isDifferenDate = false;
                  }
                  _settingOption.broadCastCurrentEndTimeEntry(time);
                  setState(() {
                    _currentDuration = time.difference(_plannedStartDate);
                  });
                },
              ),
            ),
          ].toRow(mainAxisAlignment: MainAxisAlignment.center),
        if (!_isAllDay && _isDateRange && !_isSomeday)
          Text(
            _formatDateToHumanLang(_plannedEndDate),
            style: context.h3
                .copyWith(color: _textColor, fontWeight: FontWeight.w400),
          ).ripple().gestures(onTap: () {
            _showDatePickerBottomSheet(context, isEndDate: true);
          }).padding(top: 8),
        if (_isAllDay || _isDateRange || _isSomeday) verticalSpaceRegular,
        [
          _buildSelectionMode(context, 'all date', DateSelectionType.allDate),
          StreamBuilder<TodayEntryType>(
            stream: _settingOption.typeStream,
            builder: (context, snapshot) =>
                snapshot.data == TodayEntryType.event
                    ? _buildSelectionMode(
                        context, 'date range', DateSelectionType.dateRange)
                    : _buildSelectionMode(
                        context, 'someday', DateSelectionType.someday),
          ),
        ]
            .toRow(mainAxisAlignment: MainAxisAlignment.spaceEvenly)
            .padding(top: 8),
        StreamBuilder<TodayEntryType>(
          stream: _settingOption.typeStream,
          builder: (context, snapshot) => snapshot.data != TodayEntryType.event
              ? const AddTimeBlockWidget().padding(bottom: 4)
              : const SizedBox.shrink(),
        ),
      ].toColumn(mainAxisAlignment: MainAxisAlignment.end),
    );
  }

  Widget _buildSelectionMode(
      BuildContext context, String title, DateSelectionType type) {
    return ChoiceChip(
      backgroundColor: context.colorScheme.primaryVariant,
      selectedColor: context.colorScheme.secondary,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: context.colorScheme.primaryVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      label: Text(
        title,
        style: context.subtitle1.copyWith(
          color: widget.textColor ?? kcPrimary100,
        ),
      ),
      selected: type == DateSelectionType.allDate
          ? _isAllDay
          : type == DateSelectionType.dateRange
              ? _isDateRange
              : _isSomeday,
      onSelected: (bool selected) {
        setState(() {
          if (type == DateSelectionType.allDate) {
            _isAllDay = !_isAllDay;
            _isDateRange = false;
            _isSomeday = false;
          } else if (type == DateSelectionType.dateRange) {
            _isDateRange = !_isDateRange;
            _isAllDay = false;
            _isSomeday = false;
          } else if (type == DateSelectionType.someday) {
            _isSomeday = !_isSomeday;
            _isAllDay = false;
            _isDateRange = false;
          } else {
            _isAllDay = false;
            _isDateRange = false;
            _isSomeday = false;
          }
        });
      },
    ).flexible();
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

  dynamic _showDatePickerBottomSheet(BuildContext parentContext,
      {bool isEndDate = false}) async {
    final _currentDateTime = _plannedStartDate;

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
                    _settingOption.broadCastCurrentStartTimeEntry(null);
                    _settingOption.broadCastCurrentEndTimeEntry(null);
                    setState(() {
                      _plannedStartDate = DateTime.now();
                      _plannedEndDate = 1.hours.fromNow;
                    });

                    context.router.pop();
                  },
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs args) {
                    _onSelectionChanged(args, isEndDate);
                  },
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

  void _onSelectionChanged(
      DateRangePickerSelectionChangedArgs args, bool isEndDate) {
    final dynamic picked = args.value;
    if (picked is DateTime) {
      if (_isDateRange) {
        if (isEndDate) {
          _settingOption.broadCastCurrentEndTimeEntry(picked);
          _plannedEndDate = picked;
        } else {
          _settingOption.broadCastCurrentStartTimeEntry(picked);
          _plannedStartDate = picked;
        }
      } else if (_isAllDay) {
        _settingOption.broadCastCurrentStartTimeEntry(picked);
        _settingOption.broadCastCurrentEndTimeEntry(null);
      } else {
        _plannedStartDate = picked.copyWith(
          hour: _plannedStartDate.hour,
          minute: _plannedStartDate.minute,
          second: _plannedStartDate.second,
        );
        _settingOption.broadCastCurrentStartTimeEntry(_plannedStartDate);
        _settingOption
            .broadCastCurrentEndTimeEntry(_plannedStartDate + _currentDuration);
      }

      setState(() {});
    }
  }
}
