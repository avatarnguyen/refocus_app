import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/today_event_type.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/presentation/bloc/cubit/subtask_cubit.dart';
import 'package:refocus_app/features/today/presentation/bloc/today_bloc.dart';

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
    final _color = backgroundColor ?? kcPrimary500;

    return Slidable(
      key: key ?? UniqueKey(),
      actionPane: const SlidableStrechActionPane(),
      actions: [
        IconSlideAction(
          icon: Icons.check_circle_outline,
          foregroundColor: _color,
          color: Colors.transparent,
        ),
      ],
      dismissal: SlidableDismissal(
        onDismissed: (actionTyp) {
          context.read<SubtaskCubit>().updateSubtaskWithoutReload(
              subTask.copyWith(isCompleted: !subTask.isCompleted));

          if (type != null) {
            context.read<TodayBloc>().add(UpdateTaskEntries(eventType: type!));
          } else {
            context.read<TodayBloc>().add(const GetTodayEntries());
          }
        },
        dismissThresholds: const <SlideActionType, double>{
          SlideActionType.primary: .5,
        },
        child: const SlidableDrawerDismissal(),
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
