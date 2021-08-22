import 'package:flutter/material.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:styled_widget/styled_widget.dart';

class OptionRowWidget extends StatelessWidget {
  const OptionRowWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: const [
        Icon(
          Icons.calendar_today,
          size: 32,
          color: kcSecondary200,
        ),
        Icon(
          Icons.alarm,
          size: 32,
          color: kcSecondary200,
        ),
        Icon(
          Icons.notes,
          size: 32,
          color: kcSecondary200,
        ),
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceEvenly),
    );
  }
}
