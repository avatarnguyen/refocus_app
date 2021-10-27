import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget(
      {Key? key,
      this.initialDate,
      this.onSelectionChanged,
      this.pickerView,
      this.onCancelPressed,
      this.onSubmitPressed,
      this.cancelText,
      this.submitText})
      : super(key: key);

  final DateTime? initialDate;
  final Function(DateRangePickerSelectionChangedArgs)? onSelectionChanged;
  final DateRangePickerView? pickerView;
  final Function()? onCancelPressed;
  final Function()? onSubmitPressed;
  final String? cancelText;
  final String? submitText;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SfDateRangePicker(
              initialSelectedDate: initialDate ?? DateTime.now(),
              view: pickerView ?? DateRangePickerView.month,
              toggleDaySelection: true,
              rangeSelectionColor: Colors.white,
              selectionColor: context.colorScheme.secondary,
              todayHighlightColor: context.colorScheme.secondary,
              headerStyle: DateRangePickerHeaderStyle(
                textAlign: TextAlign.center,
                textStyle: context.bodyText1.copyWith(
                  color: kcPrimary200,
                ),
              ),
              monthViewSettings: DateRangePickerMonthViewSettings(
                firstDayOfWeek: 1,
                // dayFormat: 'E',
                viewHeaderHeight: 70,
                showTrailingAndLeadingDates: true,
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                    textStyle: context.caption.copyWith(
                  color: kcSecondary100,
                )),
                enableSwipeSelection: false,
              ),
              monthCellStyle: DateRangePickerMonthCellStyle(
                textStyle: context.subtitle1.copyWith(color: kcPrimary100),
                todayTextStyle: context.subtitle1
                    .copyWith(color: context.colorScheme.secondary),
                leadingDatesTextStyle:
                    context.caption.copyWith(color: Colors.white30),
                trailingDatesTextStyle:
                    context.caption.copyWith(color: Colors.white30),
              ),
              onSelectionChanged: onSelectionChanged,
            ).padding(all: 8),
            PlatformTextButton(
              onPressed: onCancelPressed,
              child: Text(
                cancelText ?? 'Reset',
                style: context.bodyText2.copyWith(color: kcError500),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: PlatformButton(
                color: context.colorScheme.primaryVariant,
                onPressed: onSubmitPressed,
                child: Text(
                  submitText ?? 'Close',
                  style: context.bodyText2.copyWith(color: kcPrimary100),
                ),
              ),
            ).padding(horizontal: 24),
            verticalSpaceTiny,
          ],
        ),
      ),
    );
  }
}
