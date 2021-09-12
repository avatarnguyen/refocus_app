import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/core/presentation/widgets/add_page_widgets/action_panel_widget.dart';
import 'package:refocus_app/core/presentation/widgets/add_page_widgets/add_textfield_widget.dart';
import 'package:refocus_app/core/presentation/widgets/add_page_widgets/option_widget.dart';
import 'package:refocus_app/core/presentation/helper/setting_option.dart';
import 'package:refocus_app/core/util/ui/layout_helpers.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:get/get.dart';

import '../../../injection.dart';

class QuickAddPage extends StatefulWidget {
  const QuickAddPage({Key? key}) : super(key: key);

  @override
  _QuickAddPageState createState() => _QuickAddPageState();
}

class _QuickAddPageState extends State<QuickAddPage> {
  final _settingOption = getIt<SettingOption>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _settingOption.dueDate = null;
    _settingOption.remindDate = null;
    _settingOption.remindTime = null;
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
            verticalSpaceLarge,
            const AddTextFieldWidget(),
            const OptionRowWidget().paddingOnly(top: 24),
          ].toColumn().parent(textContainer),
          const ActionPanelWidget(),
        ]
            .toColumn(mainAxisAlignment: MainAxisAlignment.spaceBetween)
            .safeArea(),
      ),
    );
  }

  Widget textContainer({required Widget child}) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Styled.widget(child: child),
      );
}
