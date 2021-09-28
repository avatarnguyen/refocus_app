import 'package:flutter/material.dart';
import 'package:refocus_app/core/presentation/helper/setting_option.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/injection.dart';

class AddTimeBlockWidget extends StatefulWidget {
  const AddTimeBlockWidget({Key? key}) : super(key: key);

  @override
  State<AddTimeBlockWidget> createState() => _AddTimeBlockWidgetState();
}

class _AddTimeBlockWidgetState extends State<AddTimeBlockWidget> {
  final _settingOption = getIt<SettingOption>();

  final _timeBlockOptions = [
    TodayEntryType.timeblock,
    TodayEntryType.timeblockPrivate
  ];

  late TodayEntryType _currentEntryType;

  @override
  void initState() {
    super.initState();
    _currentEntryType = _settingOption.type;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: context.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _timeBlockOptions.length,
        itemBuilder: (context, index) {
          final _item = _timeBlockOptions[index];
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
            selected: _currentEntryType == _item,
            onSelected: (bool selected) {
              if (selected) {
                _settingOption.type = _item;
                setState(() {
                  _currentEntryType = _item;
                });
              } else {
                _settingOption.type = TodayEntryType.task;
                setState(() {
                  _currentEntryType = TodayEntryType.task;
                });
              }
            },
          ).paddingDirectional(horizontal: 4);
        },
      ),
    );
  }

  String _getItemString(TodayEntryType item) {
    return item == TodayEntryType.timeblock
        ? 'Create Timeblock'
        : 'Create Private Timeblock';
  }
}
