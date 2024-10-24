import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/calendarlist_item_widget.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';

class CalendarListPage extends StatelessWidget {
  const CalendarListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarListBloc, CalendarListState>(
      builder: (context, state) {
        if (state is CalendarListInitial) {
          return const LoadingWidget();
        }
        if (state is CalendarListLoaded) {
          final calendars = state.calendarList;
          return SafeArea(
            top: false,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 16),
              itemCount: calendars.length,
              itemBuilder: (context, index) =>
                  CalendarListItem(calendar: calendars[index]),
            ),
          );
        } else if (state is CalendarListLoading) {
          return const LoadingWidget();
        } else if (state is CalendarListError) {
          return MessageDisplay(message: state.message);
        } else {
          return const MessageDisplay(message: 'Unexpected State');
        }
      },
    );
  }
}
