import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:styled_widget/styled_widget.dart';

class InsideTaskItem extends StatelessWidget {
  const InsideTaskItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return [
      const Icon(
        Icons.check_box_outline_blank,
        color: kcPrimary700,
        size: 16,
      ),
      horizontalSpaceTiny,
      Text(
        'Task A Ajhdu lkjasdofj kjasdföljasoiejr jköldska jf',
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.caption!.copyWith(
          color: kcPrimary700,
        ),
      ).expanded(),
    ].toRow().paddingOnly(left: 34, right: 16).gestures(onTap: () {
      print('Check');
    });
  }
}
