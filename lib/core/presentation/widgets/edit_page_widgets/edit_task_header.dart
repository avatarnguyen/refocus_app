import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/presentation/helper/edit_task_stream.dart';
import 'package:refocus_app/core/presentation/helper/setting_option.dart';
import 'package:refocus_app/core/presentation/helper/text_stream.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/injection.dart';
import 'package:styled_widget/styled_widget.dart';

class EditTaskHeader extends StatefulWidget {
  const EditTaskHeader({Key? key}) : super(key: key);

  @override
  State<EditTaskHeader> createState() => _EditTaskHeaderState();
}

class _EditTaskHeaderState extends State<EditTaskHeader> {
  final EditTaskStream _editStream = getIt<EditTaskStream>();

  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    final _textBtnStyle = context.bodyText2.copyWith(
      fontWeight: FontWeight.w600,
      color: kcPrimary500,
    );
    return Container(
      color: context.backgroundColor,
      height: 56,
      width: double.infinity,
      child: [
        const Icon(
          Icons.clear,
          color: kcPrimary500,
          size: 28,
        )
            .padding(all: 4)
            .decorated(
                color: kcPrimary100, borderRadius: BorderRadius.circular(12))
            .ripple()
            .padding(left: 16)
            .gestures(onTap: context.router.pop),
        if (isEdit) ...[
          horizontalSpaceMedium.expanded(),
          PlatformTextButton(
            child: Text('Cancel', style: _textBtnStyle),
            onPressed: () {
              _editStream.broadCastCurrentPage(!isEdit);
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
                color: kcPrimary100, borderRadius: BorderRadius.circular(12))
            .ripple()
            .padding(right: 16)
            .gestures(onTap: () {
          _editStream.broadCastCurrentPage(!isEdit);
          setState(() {
            isEdit = !isEdit;
          });
          // //* save edited task
        }),
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    );
  }
}