import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:refocus_app/config/routes/router.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/datetime_stream.dart';
import 'package:refocus_app/injection.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SlidingHeaderWidget extends StatefulWidget {
  const SlidingHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  _SlidingHeaderWidgetState createState() => _SlidingHeaderWidgetState();
}

class _SlidingHeaderWidgetState extends State<SlidingHeaderWidget> {
  final DateTimeStream _dateTimeStream = getIt<DateTimeStream>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 16,
        right: 24,
        left: 24,
      ),
      height: 72,
      child: [
        const Icon(
          Icons.calendar_today,
          color: kcSecondary100,
          size: 24,
        ).gestures(onTap: () {
          showDatePickerBottomSheet(context);
        }),
        [
          Text(
            'All',
            style: context.textTheme.bodyText2!.copyWith(
              color: kcSecondary100,
              decoration: TextDecoration.underline,
            ),
          ),
          horizontalSpaceMedium,
          Text(
            'Personal',
            style: context.textTheme.bodyText2!.copyWith(
              color: kcSecondary100,
            ),
          ),
          horizontalSpaceMedium,
        ].toRow(),
        const Icon(
          Icons.add,
          color: kcSecondary100,
          size: 33,
        ).gestures(onTap: () {
          context.router.push(const QuickAddRoute());
        }),
      ].toRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  dynamic showDatePickerBottomSheet(
    BuildContext parentContext,
  ) async {
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
          // headerBuilder: (context, state) {
          // },
          builder: (context, state) {
            return SafeArea(
              top: false,
              child: SizedBox(
                height: 360,
                child: SfDateRangePicker(
                  initialSelectedDate: DateTime.now(),
                  showActionButtons: true,
                  selectionColor: parentContext.colorScheme.secondary,
                  todayHighlightColor: parentContext.colorScheme.secondary,
                  onCancel: () {
                    _dateTimeStream.broadCastCurrentDate(DateTime.now());
                    context.router.pop();
                  },
                  onSelectionChanged: _onSelectionChanged,
                  onSubmit: (Object value) {
                    if (value is DateTime) {
                      // _dateTimeStream.broadCastCurrentDate(value);
                      context.router.pop();
                    }
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

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    final dynamic _picked = args.value;
    if (_picked is DateTime) {
      _dateTimeStream.broadCastCurrentDate(_picked);
    }
  }
}
