import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/today_event_type.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/datetime_stream.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/presentation/bloc/cubit/subtask_cubit.dart';
import 'package:refocus_app/features/today/presentation/bloc/today_bloc.dart';
import 'package:refocus_app/injection.dart';

class SubTaskItem extends StatelessWidget {
  const SubTaskItem({
    Key? key,
    required this.subTask,
    this.textStyle,
    this.backgroundColor,
    this.type,
  }) : super(key: key);

  final SubTaskEntry subTask;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final TodayEventType? type;

  @override
  Widget build(BuildContext context) {
    final _dateTimeStream = getIt<DateTimeStream>();

    final _color = backgroundColor ?? kcPrimary500;

    return Slidable(
      key: key ?? const ValueKey(0),
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        dismissible: DismissiblePane(
          dismissThreshold: .5,
          onDismissed: () {
            context.read<SubtaskCubit>().updateSubtaskWithoutReload(
                subTask.copyWith(isCompleted: !subTask.isCompleted));

            if (type != null) {
              if (type == TodayEventType.specificDate) {
                final _selectedDate = _dateTimeStream.selectedDate;
                context.read<TodayBloc>().add(
                    UpdateTaskEntries(eventType: type!, date: _selectedDate));
              } else {
                context
                    .read<TodayBloc>()
                    .add(UpdateTaskEntries(eventType: type!));
              }
            } else {
              context.read<TodayBloc>().add(const GetTodayEntries());
            }
          },
        ),
        children: [
          SlidableAction(
            icon: Icons.check_circle_outline,
            foregroundColor: _color,
            backgroundColor: Colors.transparent,
            onPressed: (context) {},
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        width: double.infinity,
        decoration: BoxDecoration(
          color: _color,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Text(
          subTask.title ?? '',
          overflow: TextOverflow.ellipsis,
          style: textStyle ??
              context.textTheme.caption!.copyWith(
                color: Colors.grey.shade100,
              ),
        ),
      ),
    );
  }
}
