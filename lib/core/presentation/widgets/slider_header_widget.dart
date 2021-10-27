import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:refocus_app/config/routes/router.dart';
import 'package:refocus_app/core/presentation/helper/page_stream.dart';
import 'package:refocus_app/core/presentation/helper/sliding_body_stream.dart';
import 'package:refocus_app/core/presentation/widgets/date_picker_widget.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/datetime_stream.dart';
import 'package:refocus_app/injection.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SlidingHeaderWidget extends StatefulWidget {
  const SlidingHeaderWidget({
    Key? key,
    required this.sheetState,
    required this.closeSheet,
    required this.expandSheet,
  }) : super(key: key);

  final SheetState sheetState;
  final VoidCallback closeSheet;
  final VoidCallback expandSheet;

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
      if (newIdx == 1) {
        _titleText = 'Projects';
      } else {
        _titleText = 'Calendars';
      }
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
            ).gestures(onTap: widget.closeSheet)
          else
            const Icon(
              Icons.calendar_today,
              color: kcSecondary100,
              size: 24,
            ).gestures(onTap: showDatePickerBottomSheet),
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
            widget.closeSheet();
            context.navigateTo(const QuickAddRoute());
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
          // if (_currentSegmentedIdx == 1) ...[
          //   horizontalSpaceRegular,
          //   const Icon(
          //     Icons.add,
          //     color: kcSecondary100,
          //     size: 28,
          //   ).gestures(onTap: () {
          //     widget.expandSheet();
          //     _showCreateProjectBottomSheet();
          //   }),
          // ]
        ].toRow(
          mainAxisAlignment: MainAxisAlignment.center,
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

  // // Create New Project Bottomsheet
  // dynamic _showCreateProjectBottomSheet() async {
  //   SlidingSheetDialog? _slidingSheet;
  //   Widget? _bodyWidget;
  //   await showSlidingBottomSheet<dynamic>(
  //     context,
  //     useRootNavigator: true,
  //     builder: (_) {
  //       return _slidingSheet ??= SlidingSheetDialog(
  //         elevation: 8,
  //         cornerRadius: 16,
  //         color: context.colorScheme.background,
  //         isBackdropInteractable: true,
  //         snapSpec: const SnapSpec(
  //           initialSnap: 0.6,
  //           snappings: [0.1, 0.7],
  //         ),
  //         minHeight: context.height / 2,
  //         builder: (_, state) {
  //           return _bodyWidget ??= Container(
  //                   width: context.width,
  //                   color: context.colorScheme.background,
  //                   child: [
  //                     'Project Title'.toH5(),
  //                     SizedBox(
  //                       height: 32,
  //                       width: context.width,
  //                       child: Material(
  //                         color: Colors.transparent,
  //                         child: PlatformTextField(
  //                           onChanged: (text) {},
  //                           textAlign: TextAlign.center,
  //                           autofocus: true,
  //                           style: context.h4.copyWith(color: kcPrimary100),
  //                           material: (context, platform) =>
  //                               MaterialTextFieldData(
  //                             decoration: InputDecoration(
  //                               hintText: 'Enter new Project',
  //                               hintStyle:
  //                                   context.h4.copyWith(color: Colors.white38),
  //                               contentPadding: const EdgeInsets.all(16),
  //                               border: const OutlineInputBorder(
  //                                 borderRadius:
  //                                     BorderRadius.all(Radius.circular(8)),
  //                               ),
  //                             ),
  //                           ),
  //                           cupertino: (context, platform) =>
  //                               CupertinoTextFieldData(
  //                             placeholder: 'Enter new Project',
  //                             placeholderStyle:
  //                                 context.h4.copyWith(color: Colors.white38),
  //                             padding: const EdgeInsets.all(16),
  //                             decoration: const BoxDecoration(
  //                               color: Colors.transparent,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ].toColumn().scrollable())
  //               .safeArea();
  //         },
  //       );
  //     },
  //   );
  // }

  // DateTime Picker Bottomsheet
  dynamic showDatePickerBottomSheet() async {
    await showSlidingBottomSheet<dynamic>(
      context,
      builder: (_) {
        return SlidingSheetDialog(
          elevation: 8,
          cornerRadius: 16,
          duration: 500.milliseconds,
          color: kcDarkBackground,
          backdropColor: Colors.black12,
          isBackdropInteractable: true,
          snapSpec: const SnapSpec(
            initialSnap: 0.6,
            snappings: [0.1, 0.7],
          ),
          builder: (context, state) {
            return DatePickerWidget(
              initialDate: _dateTimeStream.selectedDate,
              pickerView: _isMonthCal
                  ? DateRangePickerView.year
                  : DateRangePickerView.month,
              onSelectionChanged: _onSelectionChanged,
              onCancelPressed: () {
                _dateTimeStream.broadCastCurrentDate(DateTime.now());
                context.router.pop();
              },
              onSubmitPressed: () async => context.router.pop(),
            );
          },
        );
      },
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    final dynamic _picked = args.value;
    if (_picked is DateTime) {
      _dateTimeStream.broadCastCurrentDate(_picked);
    }
  }
}
