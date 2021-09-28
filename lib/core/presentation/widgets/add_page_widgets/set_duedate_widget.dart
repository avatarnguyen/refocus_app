import 'package:awesome_flutter_extensions/all.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:refocus_app/core/presentation/helper/setting_option.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/duedate_selection_type.dart';
import 'package:refocus_app/injection.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SetDueDateWidget extends StatefulWidget {
  const SetDueDateWidget({Key? key}) : super(key: key);

  @override
  State<SetDueDateWidget> createState() => _SetDueDateWidgetState();
}

class _SetDueDateWidgetState extends State<SetDueDateWidget> {
  final _settingOption = getIt<SettingOption>();

  final _dueDateSelectionItems = [
    DueDateSelectionType.today,
    DueDateSelectionType.tomorrow,
    DueDateSelectionType.nextWeek,
    DueDateSelectionType.custom
  ];
  DueDateSelectionType? _currentSelectedDueDate;

  late DateTime _dueDate;

  @override
  void initState() {
    super.initState();

    _dueDate = _settingOption.dueDate ?? DateTime.now();
    _currentSelectedDueDate = _getCurrentDueDateSelectionType(_dueDate);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_settingOption.dueDate == null) {
      _settingOption.broadCastCurrentDueDateEntry(_dueDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: context.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _dueDateSelectionItems.length,
        itemBuilder: (context, index) {
          final _item = _dueDateSelectionItems[index];
          return ChoiceChip(
            backgroundColor: context.colorScheme.primaryVariant,
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
              _mapSelectionToStream(_item);
              setState(() {
                _currentSelectedDueDate = _item;
              });
            },
          ).paddingDirectional(horizontal: 4);
        },
      ),
    );
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

  void _mapSelectionToStream(DueDateSelectionType type) {
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

  dynamic _showDatePickerBottomSheet(BuildContext parentContext,
      {bool isEndDate = false}) async {
    final _currentDateTime = _dueDate;

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
                    _settingOption.broadCastCurrentDueDateEntry(null);
                    setState(() {
                      _currentSelectedDueDate = null;
                      _dueDate = DateTime.now();
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
      _settingOption.broadCastCurrentDueDateEntry(picked);
      _dueDate = picked;

      setState(() {});
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
}
