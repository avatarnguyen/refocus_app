import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
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

  late TodayEntryType _currentEntryType;

  @override
  void initState() {
    super.initState();
    _currentEntryType = _settingOption.type;
  }

  @override
  Widget build(BuildContext context) {
    return PlatformTextButton(
      child: Text(
        _getItemString(_currentEntryType),
        style: context.subtitle1.copyWith(
          color: _currentEntryType == TodayEntryType.task
              ? kcPrimary200
              : kcTertiary300,
        ),
      ),
      onPressed: () async {
        await showPlatformModalSheet<dynamic>(
          context: context,
          builder: (_) => PlatformWidget(
            material: (_, __) => _materialPopupContent(context),
            cupertino: (_, __) => _cupertinoSheetContent(context),
          ),
        );
      },
    );
  }

  String _getItemString(TodayEntryType item) {
    switch (item) {
      case TodayEntryType.timeblock:
        return 'Timeblock Added';
      case TodayEntryType.timeblockPrivate:
        return 'Private Timeblock Added';
      default:
        return 'Create a Timeblock';
    }
  }

  Widget _materialPopupContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: PlatformText('Timeblock With Title'),
            ),
            onTap: () {
              _onSelected(TodayEntryType.timeblock);
            },
          ),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: PlatformText('Timeblock Without title'),
            ),
            onTap: () {
              _onSelected(TodayEntryType.timeblockPrivate);
            },
          ),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: PlatformText('Remove Timeblock'),
            ),
            onTap: () {
              _onSelected(TodayEntryType.task);
            },
          ),
        ],
      ),
    );
  }

  void _onSelected(TodayEntryType type) {
    _settingOption.type = type;
    setState(
      () {
        _currentEntryType = type;
      },
    );
    Navigator.pop(context);
  }

  Widget _cupertinoSheetContent(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text('Choose a timeblock option'),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text('Timeblock With Title'),
          onPressed: () {
            _onSelected(TodayEntryType.timeblock);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Timeblock Without title'),
          onPressed: () {
            _onSelected(TodayEntryType.timeblockPrivate);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Remove Timeblock'),
          onPressed: () {
            _onSelected(TodayEntryType.task);
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
        child: const Text('Cancel'),
      ),
    );
  }
}
