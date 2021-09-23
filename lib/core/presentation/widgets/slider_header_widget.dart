import 'dart:async';
import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/config/routes/router.dart';
import 'package:refocus_app/core/presentation/helper/page_stream.dart';
import 'package:refocus_app/core/presentation/pages/quickadd_page.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/datetime_stream.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
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
  final PageStream _pageStream = getIt<PageStream>();
  late StreamSubscription<int> _pageSub;
  String _titleText = 'Projects';
  bool _isMonthCal = false;

  @override
  void initState() {
    _pageSub = _pageStream.pageStream.listen(_pageIndexReceived);
    super.initState();
  }

  @override
  void dispose() {
    _pageSub.cancel();
    super.dispose();
  }

  void _pageIndexReceived(int newIdx) {
    switch (newIdx) {
      case 0:
        setState(() {
          _titleText = 'Calendars';
          _isMonthCal = false;
        });
        break;
      case 1:
        setState(() {
          _titleText = 'Projects';
          _isMonthCal = false;
        });
        break;
      default:
        setState(() {
          _titleText = 'Calendars';
          _isMonthCal = true;
        });
        break;
    }
  }

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
            _titleText,
            style: context.textTheme.bodyText2!.copyWith(
              color: kcSecondary100,
              decoration: TextDecoration.underline,
            ),
          ),
          // horizontalSpaceMedium,
          // Text(
          //   'Personal',
          //   style: context.textTheme.bodyText2!.copyWith(
          //     color: kcSecondary100,
          //   ),
          // ),
          // horizontalSpaceMedium,
        ].toRow(mainAxisAlignment: MainAxisAlignment.center),
        const Icon(
          Icons.add,
          color: kcSecondary100,
          size: 33,
        ).gestures(onTap: () {
          Navigator.push(
            context,
            Platform.isIOS
                ? CupertinoPageRoute<dynamic>(
                    fullscreenDialog: true,
                    builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider<ProjectBloc>.value(
                          value: BlocProvider.of<ProjectBloc>(context),
                        ),
                        BlocProvider<TaskBloc>.value(
                          value: BlocProvider.of<TaskBloc>(context),
                        ),
                      ],
                      child: const QuickAddPage(),
                    ),
                  )
                : MaterialPageRoute<dynamic>(
                    fullscreenDialog: true,
                    builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider<ProjectBloc>.value(
                          value: BlocProvider.of<ProjectBloc>(context),
                        ),
                        BlocProvider<TaskBloc>.value(
                          value: BlocProvider.of<TaskBloc>(context),
                        ),
                      ],
                      child: const QuickAddPage(),
                    ),
                  ),
          );
          // context.navigateTo(const QuickAddRoute());
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
                  view: _isMonthCal
                      ? DateRangePickerView.year
                      : DateRangePickerView.month,
                  toggleDaySelection: true,
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
