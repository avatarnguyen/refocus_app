import 'package:flutter/material.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';

class CreateSubtaskInputWidget extends StatefulWidget {
  const CreateSubtaskInputWidget(
      {Key? key, required this.subtask, this.onChanged})
      : super(key: key);

  final SubTaskEntry subtask;
  final void Function(String)? onChanged;

  @override
  _CreateSubtaskInputWidgetState createState() =>
      _CreateSubtaskInputWidgetState();
}

class _CreateSubtaskInputWidgetState extends State<CreateSubtaskInputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: Key(widget.subtask.id),
      textAlign: TextAlign.center,
      style: context.subtitle1.copyWith(color: kcPrimary100),
      scrollPadding: const EdgeInsets.all(2),
      decoration: InputDecoration(
        contentPadding: kPaddingTextField,
        hintStyle: context.subtitle1.copyWith(color: Colors.white60),
        hintText: 'Enter new sub task ...',
        border: const OutlineInputBorder(),
      ),
      onChanged: widget.onChanged,
    );
  }
}
