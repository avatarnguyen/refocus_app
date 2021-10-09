import 'dart:async';
import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/config/routes/router.dart';
import 'package:refocus_app/core/presentation/helper/page_stream.dart';
import 'package:refocus_app/core/presentation/helper/sliding_body_stream.dart';
import 'package:refocus_app/core/presentation/pages/quickadd_page.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/datetime_stream.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart';
import 'package:refocus_app/features/task/presentation/bloc/cubit/subtask_cubit.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/injection.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SlidingHeaderWidget extends StatefulWidget {
  const SlidingHeaderWidget({
    Key? key,
    required this.sheetState,
  }) : super(key: key);

  final SheetState sheetState;

  @override
  _SlidingHeaderWidgetState createState() => _SlidingHeaderWidgetState();
}

class _SlidingHeaderWidgetState extends State<SlidingHeaderWidget> {
  final DateTimeStream _dateTimeStream = getIt<DateTimeStream>();
  final PageStream _pageStream = getIt<PageStream>();
  final SlidingBodyStream _slidingStream = getIt<SlidingBodyStream>();

  late StreamSubscription<int> _pageSub;
  late StreamSubscription<int> _segmentedControlSub;

  String _titleText = 'Projects';
  bool _isMonthCal = false;
  int _currentSegmentedIdx = 1;

  @override
  void initState() {
    _pageSub = _pageStream.pageStream.listen(_pageIndexReceived);
    _segmentedControlSub =
        _slidingStream.pageStream.listen(_slidingIndexReceived);
    super.initState();
  }

  @override
  void dispose() {
    _pageSub.cancel();
    _segmentedControlSub.cancel();
    super.dispose();
  }

  void _slidingIndexReceived(int newIdx) {
    setState(() {
      _currentSegmentedIdx = newIdx;
    });
  }

  void _pageIndexReceived(int newIdx) {
    switch (newIdx) {
      case 0:
        _slidingStream.broadCastCurrentPage(0);

        setState(() {
          _titleText = 'Calendars';
          _isMonthCal = false;
          _currentSegmentedIdx = 0;
        });
        break;
      case 1:
        _slidingStream.broadCastCurrentPage(1);

        setState(() {
          _titleText = 'Projects';
          _isMonthCal = false;
          _currentSegmentedIdx = 1;
        });
        break;
      default:
        _slidingStream.broadCastCurrentPage(0);

        setState(() {
          _titleText = 'Calendars';
          _isMonthCal = true;
          _currentSegmentedIdx = 0;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 4,
        right: 24,
        left: 24,
      ),
      height: 136,
      child: [
        [
          if (widget.sheetState.isExpanded)
            const Icon(
              Icons.close_rounded,
              color: kcSecondary100,
              size: 24,
            ).gestures(onTap: () {})
          else
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
          ].toRow(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start),
          const Icon(
            Icons.add,
            color: kcSecondary100,
            size: 33,
          ).gestures(onTap: () {
            Navigator.push<dynamic>(
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
                          BlocProvider<SubtaskCubit>.value(
                            value: BlocProvider.of<SubtaskCubit>(context),
                          ),
                          BlocProvider<CalendarListBloc>(
                            create: (context) => getIt<CalendarListBloc>(),
                          ),
                          BlocProvider<CalendarBloc>(
                            create: (context) => getIt<CalendarBloc>(),
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
                          BlocProvider<SubtaskCubit>.value(
                            value: BlocProvider.of<SubtaskCubit>(context),
                          ),
                          BlocProvider<CalendarListBloc>(
                            create: (context) => getIt<CalendarListBloc>(),
                          ),
                          BlocProvider<CalendarBloc>(
                            create: (context) => getIt<CalendarBloc>(),
                          ),
                        ],
                        child: const QuickAddPage(),
                      ),
                    ),
            );
          }),
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
        [
          CupertinoSlidingSegmentedControl<int>(
            padding: const EdgeInsets.all(4),
            groupValue: _currentSegmentedIdx,
            thumbColor: kcPrimary100,
            children: {
              0: _buildSegment('Calendars', 0),
              1: _buildSegment('Projects', 1),
            },
            onValueChanged: (value) {
              if (value != null) {
                _slidingStream.broadCastCurrentPage(value);
                setState(() {
                  _currentSegmentedIdx = value;
                });
              }
            },
          ),
          if (_currentSegmentedIdx == 1) ...[
            horizontalSpaceRegular,
            const Icon(
              Icons.add,
              color: kcSecondary100,
              size: 28,
            ).gestures(onTap: () {
              print('Create New Project');
            }),
          ]
        ].toRow(
          mainAxisAlignment: _currentSegmentedIdx == 1
              ? MainAxisAlignment.end
              : MainAxisAlignment.center,
        )
      ].toColumn(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    );
  }

  Widget _buildSegment(String text, int index) => Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          text,
          style: context.bodyText1.copyWith(
            color: index == _currentSegmentedIdx ? kcPrimary900 : kcPrimary100,
          ),
        ),
      );

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
          backdropColor: Colors.black12,
          isBackdropInteractable: true,
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
