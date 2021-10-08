import 'package:flutter/material.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:styled_widget/styled_widget.dart';

class SubTaskItem extends StatelessWidget {
  const SubTaskItem({
    Key? key,
    required this.text,
    required this.priority,
    this.textStyle,
    this.checkboxColor,
  }) : super(key: key);

  final String text;
  final int priority;
  final TextStyle? textStyle;
  final Color? checkboxColor;

  @override
  Widget build(BuildContext context) {
    return [
      Icon(
        Icons.check_box_outline_blank,
        color: checkboxColor ?? kcPrimary700,
        size: 16,
      ),
      horizontalSpaceTiny,
      Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: textStyle ??
            context.textTheme.caption!.copyWith(
              color: kcPrimary700,
            ),
      ).expanded(),
    ].toRow().padding(left: 30, right: 16).gestures(onTap: () {
      print('Check');
    });
  }
}
