import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:refocus_app/core/core.dart';

class TaskPageHeaderWidget extends StatelessWidget {
  const TaskPageHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.backgroundColor,
      height: 56,
      width: double.infinity,
      child: [
        const Icon(
          Icons.clear,
          color: kcPrimary500,
          size: 28,
        ).padding(all: 4).decorated(color: kcPrimary100, borderRadius: BorderRadius.circular(12)).ripple().padding(left: 16).gestures(onTap: context.pop),
        const Icon(
          Icons.add,
          color: kcPrimary500,
          size: 28,
        ).padding(all: 4).decorated(color: kcPrimary100, borderRadius: BorderRadius.circular(12)).ripple().padding(right: 16).gestures(onTap: context.pop),
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    );
  }
}
