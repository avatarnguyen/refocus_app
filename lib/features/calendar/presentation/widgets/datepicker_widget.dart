import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:dartx/dartx.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:styled_widget/styled_widget.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({Key? key}) : super(key: key);

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
      //   onDateChange: (date) {
      //   setState(() {
      //     _selectedValue = date;
      //   });
      // },
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
