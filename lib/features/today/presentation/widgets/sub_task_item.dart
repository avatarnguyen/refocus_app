import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:styled_widget/styled_widget.dart';

class SubTaskItem extends StatelessWidget {
  const SubTaskItem({
    Key? key,
    required this.text,
    required this.priority,
    this.textStyle,
    this.backgroundColor,
  }) : super(key: key);

  final String text;
  final int priority;
  final TextStyle? textStyle;
  final Color? backgroundColor;

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
          print('Cheched');
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
          text,
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
