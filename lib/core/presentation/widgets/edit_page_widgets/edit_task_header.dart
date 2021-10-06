import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/presentation/helper/edit_task_stream.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/edit_task_state.dart';
import 'package:refocus_app/injection.dart';
import 'package:styled_widget/styled_widget.dart';

class EditTaskHeader extends StatefulWidget {
  const EditTaskHeader({Key? key, this.colorID}) : super(key: key);

  final String? colorID;

  @override
  State<EditTaskHeader> createState() => _EditTaskHeaderState();
}

class _EditTaskHeaderState extends State<EditTaskHeader> {
  final EditTaskStream _editStream = getIt<EditTaskStream>();

  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    final _color = StyleUtils.getColorFromString(widget.colorID ?? '#115FFB');
    final _backgroudColor = StyleUtils.lighten(_color, 0.28);
    final _textColor = StyleUtils.darken(_color, colorDarken1);

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
        if (isEdit) ...[
          horizontalSpaceMedium.expanded(),
          PlatformTextButton(
            child: Text('Cancel', style: _textBtnStyle),
            onPressed: () {
              _editStream.broadCastCurrentPage(EditTaskState.view);
              setState(() {
                isEdit = !isEdit;
              });
            },
          ),
        ],
        Text(
          isEdit ? 'Done' : 'Edit',
          style: _textBtnStyle,
        )
            .padding(vertical: 8, horizontal: 10)
            .decorated(
                color: _backgroudColor, borderRadius: BorderRadius.circular(12))
            .ripple()
            .padding(right: 16)
            .gestures(onTap: () {
          _editStream.broadCastCurrentPage(
              isEdit ? EditTaskState.editing : EditTaskState.edit);
          setState(() {
            isEdit = !isEdit;
          });
          // //* save edited task
        }),
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    );
  }
}
