import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:refocus_app/core/presentation/helper/setting_option.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/injection.dart';
import 'package:styled_widget/styled_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 48,
        width: context.width,
        child: [
          _buildOptionItem(context, Icons.task_alt, 'Task', TodayEntryType.task)
              .ripple()
              .gestures(
                onTap: () => _onIconPressed(TodayEntryType.task),
              ),
          // _buildOptionItem(
          //         context, Icons.alarm, 'Time Block', TodayEntryType.timeblock)
          //     .ripple()
          //     .gestures(
          //       onTap: () => _onIconPressed(TodayEntryType.timeblock),
          //     ),
          _buildOptionItem(
                  context, Icons.calendar_today, 'Event', TodayEntryType.event)
              .ripple()
              .gestures(
                onTap: () => _onIconPressed(TodayEntryType.event),
              ),
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceEvenly));
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
      ).padding(bottom: 8),
      Text(
        text ?? '',
        maxLines: 2,
        overflow: TextOverflow.fade,
        style: context.textTheme.subtitle2!.copyWith(
          color: entryType == type ? kcSecondary100 : Colors.white24,
        ),
      ).padding(horizontal: 2).flexible(),
    ].toColumn();
  }
}
