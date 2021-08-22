import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:refocus_app/core/util/ui/ui_helpers.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/project_params.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';

import '../../../injection.dart';
import '../text_stream.dart';

class ActionPanelWidget extends StatefulWidget {
  const ActionPanelWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ActionPanelWidgetState createState() => _ActionPanelWidgetState();
}

class _ActionPanelWidgetState extends State<ActionPanelWidget> {
  Widget iconContainer({required Widget child}) => Container(
        alignment: Alignment.center,
        width: 32,
        child: Styled.widget(child: child),
      );

  Uuid uuid = Uuid();

  final _textStream = getIt<TextStream>();

  @override
  Widget build(BuildContext context) {
    final _iconTextStyle = context.textTheme.headline5!.copyWith(
      color: Colors.white70,
    );
    return StreamBuilder(
        stream: _textStream.getTextStream,
        builder: (context, AsyncSnapshot<String> textStream) {
          return Container(
            height: 48,
            color: kcPrimary800,
            child: [
              const Icon(
                Icons.add,
                size: 32,
                color: Colors.white70,
              ).gestures(onTap: () {}),
              horizontalSpaceSmall,
              Text('!', style: _iconTextStyle)
                  .parent(iconContainer)
                  .gestures(onTap: () {}),
              Text('?', style: _iconTextStyle)
                  .parent(iconContainer)
                  .gestures(onTap: () {}),
              Text('/', style: _iconTextStyle)
                  .parent(iconContainer)
                  .gestures(onTap: () {}),
              Text('#', style: _iconTextStyle)
                  .parent(iconContainer)
                  .gestures(onTap: () {}),
              Text('@', style: _iconTextStyle)
                  .parent(iconContainer)
                  .gestures(onTap: () {}),
              horizontalSpaceSmall,
              Icon(
                Icons.send,
                size: 28,
                color: context.theme.primaryColor,
              ).gestures(onTap: () {
                BlocProvider.of<TaskBloc>(context).add(
                  CreateProjectEntriesEvent(ProjectParams(
                      ProjectEntry(id: uuid.v1(), title: textStream.data))),
                );
                // _textStream.dispose();
                Get.back();
              }),
            ].toRow(mainAxisAlignment: MainAxisAlignment.spaceEvenly),
          );
        });
  }
}
