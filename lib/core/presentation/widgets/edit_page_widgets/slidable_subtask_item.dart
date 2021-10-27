import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/presentation/bloc/cubit/subtask_cubit.dart';

class SlidableSubTaskItem extends StatefulWidget {
  const SlidableSubTaskItem({
    Key? key,
    required this.subTask,
    this.colorID,
  }) : super(key: key);

  final SubTaskEntry subTask;
  final String? colorID;

  @override
  State<SlidableSubTaskItem> createState() => _SlidableSubTaskItemState();
}

class _SlidableSubTaskItemState extends State<SlidableSubTaskItem> {
  // late final SlidableController _slidableController;

  bool _shouldDisplayLine = false;

  @override
  void initState() {
    super.initState();
    _shouldDisplayLine = widget.subTask.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    final _color = StyleUtils.getColorFromString(widget.colorID ?? '#115FFB');
    final _backgroudColor = StyleUtils.darken(_color, kcdarker1);

    final _doneStrIndicator =
        widget.subTask.isCompleted ? 'Mark as Undone' : 'Mark as Done';

    return Slidable.builder(
        key: widget.key ?? const Key('subtask_value'),
        actionPane: const SlidableStrechActionPane(),
        actionExtentRatio: .6,
        actionDelegate: SlideActionBuilderDelegate(
          builder: (context, index, animation, step) {
            return IconSlideAction(
              color: step == SlidableRenderingMode.dismiss
                  ? kcSuccess500
                  : Colors.transparent,
              foregroundColor: step == SlidableRenderingMode.slide
                  ? kcPrimary500.withOpacity(animation!.value)
                  : (step == SlidableRenderingMode.dismiss
                      ? Colors.white
                      : kcPrimary500),
              icon: Icons.check,
              caption: animation!.value > 0.96 ? _doneStrIndicator : null,
              onTap: () {
                context
                    .read<SubtaskCubit>()
                    .updateSubtask(widget.subTask.copyWith(
                      isCompleted: !widget.subTask.isCompleted,
                    ));
              },
            );
          },
          actionCount: 1,
        ),
        secondaryActionDelegate: SlideActionBuilderDelegate(
          actionCount: 1,
          builder: (context, index, animation, step) {
            return IconSlideAction(
              icon: Icons.delete,
              foregroundColor: step == SlidableRenderingMode.slide
                  ? kcPrimary500.withOpacity(
                      animation!.value <= 0.7 ? animation.value + 0.3 : 1.0)
                  : (step == SlidableRenderingMode.dismiss
                      ? Colors.white
                      : kcError500),
              color: step == SlidableRenderingMode.dismiss
                  ? kcError500
                  : Colors.transparent,
              caption: animation!.value >= 0.8 ? 'Delete' : null,
              onTap: () async {
                final state = Slidable.of(context);
                state!.dismiss();
              },
            );
          },
        ),
        dismissal: SlidableDismissal(
          child: const SlidableDrawerDismissal(),
          onDismissed: (actionTyp) {
            if (actionTyp == SlideActionType.primary) {
              context
                  .read<SubtaskCubit>()
                  .updateSubtask(widget.subTask.copyWith(
                    isCompleted: !widget.subTask.isCompleted,
                  ));
            }
            if (actionTyp == SlideActionType.secondary) {
              context.read<SubtaskCubit>().deleteSubtask(widget.subTask);
            }
          },
          onWillDismiss: (SlideActionType? actionType) async {
            if (actionType == SlideActionType.secondary) {
              final dismiss = await _deleteConfirmationDialog(context);
              if (dismiss != null && dismiss) {
                return true;
              } else {
                return false;
              }
            }
            return false;
          },
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          padding: const EdgeInsets.all(16),
          width: context.width - 16,
          decoration: BoxDecoration(
              color: _backgroudColor,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: const [
                kShadowLightBase,
                kShadowLight40,
              ]),
          child: Text(
            widget.subTask.title ?? '',
            textAlign: TextAlign.center,
            style: context.caption.copyWith(
              color: Colors.white,
              decoration:
                  _shouldDisplayLine ? TextDecoration.lineThrough : null,
            ),
          ),
        ));
  }

  Future<bool?> _deleteConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context2) {
        return PlatformAlertDialog(
          title: PlatformText('Delete'),
          content: PlatformText('Item will be deleted'),
          actions: <Widget>[
            PlatformTextButton(
              child: PlatformText('Cancel'),
              onPressed: () => Navigator.of(context2).pop(false),
            ),
            PlatformTextButton(
              child: PlatformText('Ok'),
              onPressed: () => Navigator.of(context2).pop(true),
            ),
          ],
        );
      },
    );
  }
}
