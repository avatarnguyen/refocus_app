import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/injection.dart';
import 'package:styled_widget/styled_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    final _entryMap = <TodayEntryType, IconData>{
      TodayEntryType.task: Icons.done_all,
      TodayEntryType.event: Icons.calendar_today,
      TodayEntryType.timeblock: Icons.access_time,
    };

    return SizedBox(
      height: 56,
      child: [
        Icon(
          _entryMap[entryType],
          size: 32,
          color: kcSecondary200,
        ).ripple().gestures(
          onTap: () async {
            final result = await showPlatformModalSheet(
              context: context,
              builder: (context) => PlatformWidget(
                material: (_, __) => _materialPopupContent(context),
                cupertino: (_, __) => _cupertinoSheetContent(context),
              ),
            );
            print(result);
            if (result != null) {
              _settingsOption.type = result;
              setState(() {
                entryType = result;
              });
            }
          },
        ),
        Icon(
          Icons.alarm,
          size: 32,
          color: kcSecondary200,
        ),
        Icon(
          Icons.notes,
          size: 32,
          color: kcSecondary200,
        ),
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceEvenly),
    );
  }

  Widget _materialPopupContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: PlatformText('Event'),
          ).gestures(onTap: () => Navigator.pop(context, TodayEntryType.event)),
          Container(
            padding: const EdgeInsets.all(8),
            child: PlatformText('Task'),
          ).gestures(onTap: () => Navigator.pop(context, TodayEntryType.task)),
          Container(
            padding: const EdgeInsets.all(8),
            child: PlatformText('Time Block'),
          ).gestures(
              onTap: () => Navigator.pop(context, TodayEntryType.timeblock)),
        ],
      ),
    );
  }

  Widget _cupertinoSheetContent(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context, TodayEntryType.event),
          child: const Text('Event'),
        ),
        CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context, TodayEntryType.task),
          child: const Text('Task'),
        ),
        CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context, TodayEntryType.timeblock),
          child: const Text('Time Block'),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
    );
  }
}
