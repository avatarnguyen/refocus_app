import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/core.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';

class ChangeDateTimeWidget extends StatefulWidget {
  const ChangeDateTimeWidget({Key? key, this.startDateTime, this.endDateTime}) : super(key: key);
  final DateTime? startDateTime;
  final DateTime? endDateTime;

  @override
  State<ChangeDateTimeWidget> createState() => _ChangeDateTimeWidgetState();
}

class _ChangeDateTimeWidgetState extends State<ChangeDateTimeWidget> {
  var _currentIdx = 0;

  late DateTime _pStartDateTime;
  late DateTime _pEndDateTime;

  @override
  void initState() {
    super.initState();
    _pStartDateTime = widget.startDateTime?.toLocal() ?? DateTime.now();
    _pEndDateTime = widget.endDateTime?.toLocal() ?? DateTime.now() + 1.hours;
  }

  @override
  Widget build(BuildContext context) {
    //TODO(): implement Material UI Date Time Picker

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          verticalSpaceRegular,
          CupertinoSlidingSegmentedControl<int>(
            padding: const EdgeInsets.all(4),
            groupValue: _currentIdx,
            thumbColor: context.colorScheme.primary,
            children: {
              0: _buildSegment('Start', 0, _currentIdx),
              1: _buildSegment('End', 1, _currentIdx),
            },
            onValueChanged: (value) {
              if (value != null) {
                setState(() {
                  _currentIdx = value;
                });
              }
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).copyWith().size.height / 3.8,
            child: CupertinoDatePicker(
              key: Key('index_$_currentIdx'),
              onDateTimeChanged: (picked) {
                final _currentDateTime = _currentIdx == 0 ? _pStartDateTime : _pEndDateTime;

                if (picked != _currentDateTime) {
                  if (_currentIdx == 0) {
                    setState(() {
                      final _diff = _pEndDateTime.difference(_pStartDateTime);
                      _pStartDateTime = picked;
                      _pEndDateTime = picked + _diff;
                    });
                  } else {
                    setState(() {
                      _pEndDateTime = picked;
                    });
                  }
                }
              },
              initialDateTime: _currentIdx == 0 ? _pStartDateTime : _pEndDateTime,
              minimumYear: 2020,
              maximumYear: 2025,
            ),
          ).padding(bottom: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: [
              PlatformTextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  context.pop();
                },
              ),
              PlatformButton(
                color: context.colorScheme.primary,
                child: 'Save'.toButtonText(),
                onPressed: () {
                  context.pop();
                },
              ),
            ].toRow(mainAxisAlignment: MainAxisAlignment.spaceEvenly),
          ),
        ],
      ),
    );
  }

  Widget _buildSegment(String text, int index, int currentSegIdx) => Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: Text(
          text,
          style: context.bodyText1.copyWith(
            color: index == currentSegIdx ? kcPrimary100 : kcPrimary900,
          ),
        ),
      );
}
