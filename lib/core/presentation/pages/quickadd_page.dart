import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/core/presentation/helper/setting_option.dart';
import 'package:refocus_app/core/presentation/helper/subtask_stream.dart';
import 'package:refocus_app/core/presentation/widgets/add_page_widgets/action_panel_widget.dart';
import 'package:refocus_app/core/presentation/widgets/add_page_widgets/add_textfield_widget.dart';
import 'package:refocus_app/core/presentation/widgets/add_page_widgets/due_datetime_widget.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/injection.dart';
import 'package:styled_widget/styled_widget.dart';

class QuickAddPage extends StatefulWidget {
  const QuickAddPage({Key? key}) : super(key: key);

  @override
  _QuickAddPageState createState() => _QuickAddPageState();
}

class _QuickAddPageState extends State<QuickAddPage> {
  final _settingOption = getIt<SettingOption>();
  final _subTaskStream = getIt<SubTaskStream>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _settingOption.broadCastCurrentDueDateEntry(null);
    _settingOption.broadCastCurrentStartTimeEntry(null);
    _settingOption.broadCastCurrentEndTimeEntry(null);
    _subTaskStream.broadCastCurrentSubTaskListEntry([]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcDarkBackground,
      body: BlocProvider<ProjectBloc>.value(
        value: BlocProvider.of<ProjectBloc>(context),
        child: [
          [
            const AddTextFieldWidget(),
            const SetPlannedDateTimeWidget(),
          ].toColumn().scrollable().expanded(), //.parent(textContainer),
          const ActionPanelWidget(),
        ]
            .toColumn(mainAxisAlignment: MainAxisAlignment.spaceBetween)
            .safeArea(),
      ),
    );
  }

  Widget _textContainer({required Widget child}) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Styled.widget(child: child),
      );
}
