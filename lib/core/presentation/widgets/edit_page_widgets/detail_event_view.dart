import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart';
import 'package:refocus_app/features/today/domain/today_entry.dart';
import 'package:styled_widget/styled_widget.dart';

class DetailEventView extends StatelessWidget {
  const DetailEventView({Key? key, this.event}) : super(key: key);

  final TodayEntry? event;

  @override
  Widget build(BuildContext context) {
    if (event != null) {
      return _buildListView(context);
    } else {
      return Container();
    }
  }

  ListView _buildListView(BuildContext context) {
    final _color = StyleUtils.getColorFromString(event?.color ?? '#115FFB');
    final _textColor = StyleUtils.darken(_color);

    final _timeTextStyle = context.h6.copyWith(
      color: _textColor,
      fontWeight: FontWeight.w600,
    );
    final _dateTextStyle = context.subtitle1.copyWith(
      color: _textColor,
    );
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 24),
      children: [
        Text(
          event!.title ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.h4.copyWith(
            fontWeight: FontWeight.w600,
            color: _textColor,
          ),
        ).alignment(Alignment.center),
        verticalSpaceMedium,
        //Start and End DateTime
        SizedBox(
          child: [
            [
              if (event?.startDateTime != null)
                Text(
                  CustomDateUtils.returnTime(event!.startDateTime!.toLocal()),
                  style: _timeTextStyle,
                ),
              if (event?.endDateTime != null) ...[
                Icon(
                  Icons.arrow_right_alt_rounded,
                  color: _textColor,
                ).padding(horizontal: 4),
                Text(
                  CustomDateUtils.returnTime(event!.endDateTime!.toLocal()),
                  style: _timeTextStyle,
                ),
              ]
            ].toRow(mainAxisAlignment: MainAxisAlignment.center),
            [
              if (event?.startDateTime != null)
                Text(
                  CustomDateUtils.returnDateAndMonth(
                      event!.startDateTime!.toLocal()),
                  style: _dateTextStyle,
                ),
              if (event?.endDateTime != null &&
                  !event!.endDateTime!
                      .isAtSameDayAs(event!.startDateTime!)) ...[
                Icon(
                  Icons.arrow_right_alt_rounded,
                  color: _textColor,
                ).padding(horizontal: 4),
                Text(
                  CustomDateUtils.returnDateAndMonth(
                      event!.endDateTime!.toLocal()),
                  style: _dateTextStyle,
                ),
              ]
            ].toRow(mainAxisAlignment: MainAxisAlignment.center),
            verticalSpaceMedium,
            Text(
              'Calendar',
              style: _dateTextStyle,
            ),
            verticalSpaceSmall,
            BlocBuilder<CalendarListBloc, CalendarListState>(
              builder: (context, state) {
                if (state is Loaded) {
                  final _calList = state.calendarList;
                  final _currentCal = _calList
                      .singleWhere((_cal) => _cal.id == event!.projectOrCalID);
                  return Text(
                    _currentCal.name,
                    style: _timeTextStyle,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            )
          ].toColumn(mainAxisSize: MainAxisSize.min),
        )
      ],
    );
  }
}
