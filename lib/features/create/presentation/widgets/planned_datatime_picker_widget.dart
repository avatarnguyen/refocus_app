import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/constants/time_contants.dart';
import 'package:refocus_app/core/core.dart';
import 'package:refocus_app/core/presentation/widgets/date_picker_widget.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/date_selection_type.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/create/presentation/bloc/create_bloc.dart';
import 'package:refocus_app/features/create/presentation/widgets/add_timeblock_widget.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PlannedDatetimePickerWidget extends StatefulWidget {
  const PlannedDatetimePickerWidget({
    Key? key,
    this.textColor,
  }) : super(key: key);

  final Color? textColor;

  @override
  _PlannedDatetimePickerWidgetState createState() => _PlannedDatetimePickerWidgetState();
}

class _PlannedDatetimePickerWidgetState extends State<PlannedDatetimePickerWidget> {
  final log = logger(PlannedDatetimePickerWidget);

  DateTime? _plannedStartDate;
  DateTime? _plannedEndDate;
  // Duration _currentDuration = 1.hours;

  bool _isAllDay = false;
  bool _isDateRange = false;
  bool _isSomeday = false;

  final FixedExtentScrollController _endTimeScrollCtrl = FixedExtentScrollController(initialItem: 30);
  final FixedExtentScrollController _startTimeScrollCtrl = FixedExtentScrollController(initialItem: 30);

  @override
  void initState() {
    super.initState();
    context.read<CreateBloc>()
      ..add(CreateEvent.startDateTimeChanged(DateTime.now()))
      ..add(CreateEvent.endDateTimeChanged(1.hours.fromNow));
  }

  DateTime _timeToDateTime(DateTime dateTime, TimeOfDay time) {
    return dateTime.copyWith(
      hour: time.hour,
      minute: time.minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _textColor = widget.textColor ?? kcPrimary100;
    final _kDayTextStyle = context.h3.copyWith(color: _textColor, fontWeight: FontWeight.w400);

    return BlocBuilder<CreateBloc, CreateState>(
      builder: (context, state) {
        _plannedStartDate = state.start;
        _plannedEndDate = state.end;
        return SizedBox(
          width: context.width,
          height: 280,
          child: [
            if (_isSomeday)
              Text('Someday', style: context.h3.copyWith(color: _textColor, fontWeight: FontWeight.w400))
            else
              [
                Text(
                  _formatDateToHumanLang(_plannedStartDate),
                  style: _kDayTextStyle,
                ).ripple().gestures(onTap: () {
                  _showDatePickerBottomSheet(context);
                }),
                Icon(Icons.arrow_right_alt_rounded, color: _textColor).padding(horizontal: 8),
                if (!_isAllDay && !_isDateRange && !_isSomeday)
                  Text(
                    _formatDateToHumanLang(_plannedEndDate),
                    style: _kDayTextStyle,
                  ).ripple().gestures(onTap: () {
                    _showDatePickerBottomSheet(context);
                  }),
              ].toRow(mainAxisAlignment: MainAxisAlignment.center),
            verticalSpaceRegular,
            if (!_isAllDay && !_isDateRange && !_isSomeday)
              Row(
                children: [
                  // Container(
                  //   color: Colors.white70,
                  // ),
                  SizedBox(
                    height: 110,
                    child: CupertinoPicker.builder(
                      scrollController: _startTimeScrollCtrl,
                      itemExtent: 52,
                      onSelectedItemChanged: (index) {
                        final _picked = timePickerElements[index];
                        log.d(_picked);
                        final _pickedDateTime = _timeToDateTime(
                          _plannedStartDate!,
                          _picked,
                        );
                        context.read<CreateBloc>().add(
                              CreateEvent.endDateTimeChanged(_pickedDateTime),
                            );
                      },
                      childCount: timePickerElements.length,
                      itemBuilder: (context, index) {
                        final _item = timePickerElements[index];
                        return Text(
                          _item.toString(),
                          style: context.bodyText1.copyWith(
                            color: Colors.white,
                          ),
                        ).center();
                      },
                    ),
                  ).expanded(),
                  const Icon(
                    Icons.arrow_right_alt_rounded,
                    color: Colors.white,
                  ).padding(horizontal: 4),
                  SizedBox(
                    height: 110,
                    child: CupertinoPicker.builder(
                      scrollController: _endTimeScrollCtrl,
                      itemExtent: 52,
                      onSelectedItemChanged: (index) {
                        final _picked = timePickerElements[index];
                        log.d(_picked);
                        final _pickedDateTime = _timeToDateTime(
                          _plannedEndDate!,
                          _picked,
                        );
                        context.read<CreateBloc>().add(
                              CreateEvent.endDateTimeChanged(_pickedDateTime),
                            );
                      },
                      childCount: timePickerElements.length,
                      itemBuilder: (context, index) {
                        final _item = timePickerElements[index];
                        return Text(
                          _item.toString(),
                          style: context.bodyText1.copyWith(
                            color: Colors.white,
                          ),
                        ).center();
                      },
                    ),
                  ).expanded(),
                ],
              ),
            // if (!_isAllDay && _isDateRange && !_isSomeday)
            //   Text(
            //     _formatDateToHumanLang(_plannedEndDate),
            //     style: _kDayTextStyle,
            //   ).ripple().gestures(onTap: () {
            //    //TODO: Change method
            //     _showDatePickerBottomSheet(context, isEndDate: true);
            //   }).padding(top: 8),
            if (_isAllDay || _isDateRange || _isSomeday) verticalSpaceRegular,
            [
              _buildSelectionMode(context, 'all date', DateSelectionType.allDate),
              if (state.todayEntryType == TodayEntryType.event)
                _buildSelectionMode(context, 'date range', DateSelectionType.dateRange)
              else
                _buildSelectionMode(context, 'someday', DateSelectionType.someday),
            ].toRow(mainAxisAlignment: MainAxisAlignment.spaceEvenly).padding(top: 8),
            if (state.todayEntryType != TodayEntryType.event) const AddTimeBlockWidget().padding(bottom: 4) else verticalSpaceMedium,
          ].toColumn(mainAxisAlignment: MainAxisAlignment.end),
        );
      },
    );
  }

  Widget _buildSelectionMode(BuildContext context, String title, DateSelectionType type) {
    return ChoiceChip(
      backgroundColor: context.colorScheme.background,
      selectedColor: context.colorScheme.secondary,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: context.colorScheme.background),
        borderRadius: BorderRadius.circular(8),
      ),
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

  String _formatDateToHumanLang(DateTime? date) {
    if (date != null) {
      if (date.isToday) {
        return 'Today';
      } else if (date.isTomorrow) {
        return 'Tomorrow';
      } else {
        return CustomDateUtils.returnDateAndMonth(date);
      }
    } else {
      return '';
    }
  }

  dynamic _showDatePickerBottomSheet(BuildContext parentContext, {bool isEndDate = false}) async {
    final _sheetController = SheetController();
    final _currentDateTime = isEndDate ? _plannedEndDate : _plannedStartDate;

    await showSlidingBottomSheet<dynamic>(
      context,
      useRootNavigator: true,
      builder: (context) {
        return SlidingSheetDialog(
          elevation: 8,
          cornerRadius: 16,
          controller: _sheetController,
          duration: 500.milliseconds,
          color: kcDarkBackground,
          snapSpec: const SnapSpec(
            initialSnap: 0.6,
            snappings: [0.1, 0.7],
          ),
          builder: (context, state) {
            return DatePickerWidget(
              initialDate: _currentDateTime,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                _onSelectionChanged(args, isEndDate);
              },
              onCancelPressed: () {
                context.read<CreateBloc>()
                  ..add(CreateEvent.startDateTimeChanged(DateTime.now()))
                  ..add(CreateEvent.endDateTimeChanged(1.hours.fromNow));
                context.pop();
              },
              onSubmitPressed: () async {
                await _sheetController.collapse();
                context.pop();
              },
            );
          },
        );
      },
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args, bool isEndDate) {
    final dynamic picked = args.value;
    if (picked is DateTime) {
      if (_isDateRange) {
        if (isEndDate) {
          context.read<CreateBloc>().add(CreateEvent.endDateTimeChanged(picked));
          // _plannedEndDate = picked;
        } else {
          context.read<CreateBloc>().add(CreateEvent.startDateTimeChanged(picked));
          // _plannedStartDate = picked;
        }
      } else if (_isAllDay) {
        context.read<CreateBloc>().add(const CreateEvent.endDateTimeChanged(null));
        context.read<CreateBloc>().add(CreateEvent.startDateTimeChanged(picked));
      } else {
        _plannedStartDate = picked.copyWith(
          hour: _plannedStartDate?.hour,
          minute: _plannedStartDate?.minute,
          second: _plannedStartDate?.second,
        );

        context.read<CreateBloc>().add(CreateEvent.startDateTimeChanged(_plannedStartDate));
        // context.read<CreateBloc>().add(CreateEvent.endDateTimeChanged(
        //     _plannedStartDate + _currentDuration));
      }

      // setState(() {});
    }
  }
}
