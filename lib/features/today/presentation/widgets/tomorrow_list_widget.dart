import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/features/today/presentation/bloc/tomorrow/tomorrow_bloc.dart';
import 'package:refocus_app/features/today/presentation/widgets/list_item_widget.dart';

class TomorrowListWidget extends StatelessWidget {
  const TomorrowListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TomorrowBloc, TomorrowState>(
      builder: (context, state) {
        if (state is TomorrowLoaded) {
          final _tomorrowList = state.entries;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final _entry = _tomorrowList[index];

                return ListItemWidget(
                  key: Key(
                    '${_entry.id}_${_entry.startDateTime}_${_entry.dueDateTime}',
                  ),
                  entry: _entry,
                  selectedDate: 1.days.fromNow,
                  // postponeItem: () =>
                  //     _postponeItem(TodayEventType.tomorrow, _entry),
                  // markItemAsDone: () =>
                  //     _markTaskAsDone(_entry, TodayEventType.tomorrow),
                  // changeItemDate: () => _changeDateTime(_entry),
                );
              },
              childCount: _tomorrowList.length,
            ),
          );
        } else {
          return const SliverPadding(padding: EdgeInsets.zero);
        }
      },
    );
  }
}
