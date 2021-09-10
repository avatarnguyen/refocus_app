import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/injection.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:get/get.dart';

import 'setting_option.dart';

class OptionRowWidget extends StatefulWidget {
  const OptionRowWidget({
    Key? key,
  }) : super(key: key);

  @override
  _OptionRowWidgetState createState() => _OptionRowWidgetState();
}

class _OptionRowWidgetState extends State<OptionRowWidget> {
  final _settingsOption = getIt<SettingOption>();
  TodayEntryType entryType = TodayEntryType.task;
  ProjectEntry? _currentProject;
  DateTime selectedDate = DateTime.now();
  DateTime? _plannedDate;
  int _groupValue = 0;

  @override
  Widget build(BuildContext context) {
    final _entryMapIcon = <TodayEntryType, IconData>{
      TodayEntryType.task: Icons.done_all,
      TodayEntryType.event: Icons.calendar_today,
      TodayEntryType.timeblock: Icons.access_time,
    };
    final _entryMapString = <TodayEntryType, String>{
      TodayEntryType.task: 'Task',
      TodayEntryType.event: 'Event',
      TodayEntryType.timeblock: 'Time Block',
    };

    return SizedBox(
        height: 64,
        width: context.width,
        child: [
          _buildOptionItem(context, Icons.task_alt, 'Task', TodayEntryType.task)
              .ripple()
              .gestures(
                onTap: () => _onIconPressed(TodayEntryType.task),
              ),
          _buildOptionItem(
                  context, Icons.alarm, 'Time Block', TodayEntryType.timeblock)
              .ripple()
              .gestures(
                onTap: () => _onIconPressed(TodayEntryType.timeblock),
              ),
          _buildOptionItem(
                  context, Icons.calendar_today, 'Event', TodayEntryType.event)
              .ripple()
              .gestures(
                onTap: () => _onIconPressed(TodayEntryType.event),
              ),
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceAround));
  }

  void _onIconPressed(TodayEntryType type) {
    _settingsOption.type = type;
    setState(() {
      entryType = type;
    });
  }

  Widget _buildOptionItem(
    BuildContext context,
    IconData? icon,
    String? text,
    TodayEntryType type,
  ) {
    return [
      Icon(
        icon,
        size: 24,
        color: entryType == type ? kcSecondary100 : Colors.white24,
      ).paddingOnly(bottom: 8),
      Text(
        text ?? '',
        maxLines: 2,
        overflow: TextOverflow.fade,
        style: context.textTheme.subtitle2!.copyWith(
          color: entryType == type ? kcSecondary100 : Colors.white24,
        ),
      ).padding(horizontal: 2).flexible(),
    ].toColumn(mainAxisAlignment: MainAxisAlignment.start);
  }

  // void _materialDateTimePicker(BuildContext context) async {
  //   final picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2025),
  //     builder: (context, child) => child ?? Container(),
  //   );
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }

  void _changeDateTimePicker(int? index) {
    if (index != null) {
      setState(() {
        _groupValue = index;
      });
    }
  }

  // void _cupertinoDateTimePicker(BuildContext context) {
  //   showModalBottomSheet(
  //       context: context,
  //       backgroundColor: context.theme.backgroundColor,
  //       builder: (BuildContext builder) {
  //         return [
  //           Container(
  //             height: context.height / 3,
  //             color: Colors.white,
  //             child: CupertinoDatePicker(
  //               mode: CupertinoDatePickerMode.dateAndTime,
  //               onDateTimeChanged: (picked) {
  //                 if (picked != selectedDate) {
  //                   setState(() {
  //                     selectedDate = picked;
  //                   });
  //                 }
  //               },
  //               initialDateTime: selectedDate,
  //               use24hFormat: true,
  //               minimumYear: 2000,
  //               maximumYear: 2025,
  //             ),
  //           ),
  //           // CupertinoSlidingSegmentedControl(
  //           //   padding: const EdgeInsets.all(8),
  //           //   thumbColor: context.theme.primaryColor,
  //           //   backgroundColor: context.theme.backgroundColor,
  //           //   groupValue: _groupValue,
  //           //   children: {
  //           //     0: _buildSegment('Date'),
  //           //     1: _buildSegment('Time'),
  //           //   },
  //           //   onValueChanged: _changeDateTimePicker,
  //           // ).paddingOnly(top: 8),
  //           PlatformButton(
  //             onPressed: () {
  //               _settingsOption.dateTime = selectedDate;
  //               setState(() {
  //                 _plannedDate = selectedDate;
  //               });
  //               Get.back();
  //             },
  //             child: const Text('Speichern'),
  //           ),
  //         ].toColumn(mainAxisSize: MainAxisSize.min).safeArea();
  //       });
  // }
}
