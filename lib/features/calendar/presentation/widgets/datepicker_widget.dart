import 'dart:async';

import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:dartx/dartx.dart';
import 'package:refocus_app/injection.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/util/ui/style_helpers.dart';
import '../bloc/calendar/datetime_stream.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({Key? key}) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final DateTimeStream _dateTimeStream = getIt<DateTimeStream>();
  StreamSubscription<DateTime>? _dateTimeSubscription;

  @override
  void initState() {
    _dateTimeSubscription =
        _dateTimeStream.dateTimeStream.listen(_dateTimeReceived);
    super.initState();
  }

  void _dateTimeReceived(DateTime newDate) {
    print('new current Date: $newDate');
  }

  @override
  void dispose() {
    super.dispose();
    _dateTimeSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      3.days.ago,
      locale: 'de_DE',
      initialSelectedDate: DateTime.now(),
      selectedTextColor: Colors.white,
      selectionColor: kcPrimary400,
      dateTextStyle: kHeadline5StyleBold,
      monthTextStyle: kXSmallStyleRegular.copyWith(
        color: Colors.grey,
      ),
      dayTextStyle: kTinyStyleRegular,
      onDateChange: _dateTimeStream.broadCastCurrentDate,
    ).parent(({required child}) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            boxShadow: const [
              kShadowLightBase,
              kShadowLight60,
            ],
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: child,
        ));
  }
}
