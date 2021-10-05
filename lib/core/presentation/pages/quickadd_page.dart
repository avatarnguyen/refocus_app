import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/core/presentation/helper/action_stream.dart';
import 'package:refocus_app/core/presentation/helper/setting_option.dart';
import 'package:refocus_app/core/presentation/helper/subtask_stream.dart';
import 'package:refocus_app/core/presentation/widgets/add_page_widgets/action_panel_widget.dart';
import 'package:refocus_app/core/presentation/widgets/add_page_widgets/add_textfield_widget.dart';
import 'package:refocus_app/core/presentation/widgets/add_page_widgets/add_timeblock_widget.dart';
import 'package:refocus_app/core/presentation/widgets/add_page_widgets/due_datetime_widget.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/action_selection_type.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/calendar_bloc.dart';
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
  final _actionStream = getIt<ActionStream>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _settingOption.broadCastCurrentDueDateEntry(null);
    _settingOption.broadCastCurrentStartTimeEntry(null);
    _settingOption.broadCastCurrentEndTimeEntry(null);
    _settingOption.broadCastCurrentTypeEntry(TodayEntryType.task);
    _actionStream.broadCastCurrentActionType(ActionSelectionType.task);
    _subTaskStream.broadCastCurrentSubTaskListEntry([]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primaryVariant,
      body: [
        [
          BlocProvider<ProjectBloc>.value(
            value: BlocProvider.of<ProjectBloc>(context),
            child: const AddTextFieldWidget(),
          ),
          const SetPlannedDateTimeWidget(),
          // if (_settingOption.type != TodayEntryType.event)
          //   const AddTimeBlockWidget(),
        ]
            .toColumn(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround)
            .scrollable()
            .expanded(),
        BlocProvider<CalendarBloc>.value(
          value: BlocProvider.of<CalendarBloc>(context),
          child: const ActionPanelWidget(),
        ),
      ].toColumn(mainAxisAlignment: MainAxisAlignment.spaceBetween).safeArea(),
    );
  }
}
