import 'dart:developer';

import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/presentation/helper/edit_task_stream.dart';
import 'package:refocus_app/core/presentation/widgets/edit_page_widgets/edit_task_view.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/edit_task_state.dart';
import 'package:refocus_app/features/task/presentation/bloc/cubit/subtask_cubit.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/injection.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:styled_widget/styled_widget.dart';

class EditTaskHeader extends StatefulWidget {
  const EditTaskHeader({
    Key? key,
    this.colorID,
    required this.taskID,
    required this.getEditView,
  }) : super(key: key);

  final String taskID;
  final String? colorID;
  final VoidCallback getEditView;

  @override
  State<EditTaskHeader> createState() => _EditTaskHeaderState();
}

class _EditTaskHeaderState extends State<EditTaskHeader> {
  final EditTaskStream _editStream = getIt<EditTaskStream>();

  late Color _color;
  late Color _backgroudColor;
  late Color _textColor;

  @override
  void initState() {
    super.initState();

    _color = StyleUtils.getColorFromString(widget.colorID ?? '#115FFB');
    _backgroudColor = StyleUtils.lighten(_color, 0.28);
    _textColor = StyleUtils.darken(_color, colorDarken1);
  }

  @override
  Widget build(BuildContext context) {
    final _textBtnStyle = context.bodyText2.copyWith(
      fontWeight: FontWeight.w600,
      color: _textColor,
    );
    return Container(
      color: context.backgroundColor,
      height: 56,
      width: double.infinity,
      child: [
        Icon(
          Icons.clear,
          color: _textColor,
          size: 28,
        )
            .padding(all: 4)
            .decorated(
                color: _backgroudColor, borderRadius: BorderRadius.circular(12))
            .ripple()
            .padding(left: 16)
            .gestures(onTap: context.router.pop),
        Text(
          'Edit',
          style: _textBtnStyle,
        )
            .padding(vertical: 8, horizontal: 10)
            .decorated(
                color: _backgroudColor, borderRadius: BorderRadius.circular(12))
            .ripple()
            .padding(right: 16)
            .gestures(onTap: () => widget.getEditView()),
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    );
  }
}
