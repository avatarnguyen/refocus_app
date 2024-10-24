import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/features/today/presentation/bloc/upcoming/upcoming_cubit.dart';
import 'package:refocus_app/features/today/presentation/widgets/list_item_widget.dart';

class UpcomingListWidget extends StatelessWidget {
  const UpcomingListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingCubit, UpcomingState>(
      builder: (context, state) {
        if (state is UpcomingLoaded) {
          final _upcomingList = state.entries;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final _entry = _upcomingList[index];
                return ListItemWidget(
                  key: Key(
                    '${_entry.id}_${_entry.endDateTime}_${_entry.dueDateTime}',
                  ),
                  entry: _entry,
                  selectedDate: 2.days.fromNow,
                  // markItemAsDone: () =>
                  //     _markTaskAsDone(_entry, TodayEventType.upcoming),
                  // postponeItem: () =>
                  //     _postponeItem(TodayEventType.upcoming, _entry),
                  // changeItemDate: () => _changeDateTime(_entry),
                );
              },
              childCount: _upcomingList.length,
            ),
          );
        } else {
          return const SliverPadding(padding: EdgeInsets.zero);
        }
      },
    );
  }
}
