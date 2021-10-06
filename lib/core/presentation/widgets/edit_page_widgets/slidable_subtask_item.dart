import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';

class SlidableSubTaskItem extends StatelessWidget {
  const SlidableSubTaskItem({
    Key? key,
    required this.subTask,
    this.colorID,
  }) : super(key: key);

  final SubTaskEntry subTask;
  final String? colorID;

  @override
  Widget build(BuildContext context) {
    final _color = StyleUtils.getColorFromString(colorID ?? '#115FFB');
    final _backgroudColor = StyleUtils.darken(_color, colorDarken1);

    return Slidable.builder(
        key: key ?? const Key('subtask_value'),
        actionPane: const SlidableStrechActionPane(),
        actionExtentRatio: .6,
        actionDelegate: SlideActionBuilderDelegate(
          builder: (context, index, animation, step) {
            // print('Current Animation: ${animation}');
            if (animation!.isCompleted) {
              final controller = Slidable.of(context);
              controller!.close();
            }
            return Icon(
              Icons.check,
              size: 40 * animation.value,
              color: animation.value > 0.5 ? _backgroudColor : Colors.grey,
            ).alignment(Alignment.centerRight).padding(right: 16);
          },
          actionCount: 1,
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
            subTask.title ?? '',
            textAlign: TextAlign.center,
            style: context.caption.copyWith(
              color: Colors.white,
              decoration:
                  subTask.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
        ));
  }
}
