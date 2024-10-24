import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart';
import 'package:refocus_app/features/create/presentation/bloc/create_bloc.dart';
import 'package:refocus_app/features/create/presentation/widgets/create_subtasks_input_widget.dart';
import 'package:styled_widget/styled_widget.dart';

class CreateTitleInputWidget extends StatefulWidget {
  const CreateTitleInputWidget({Key? key}) : super(key: key);
  @override
  _CreateTitleInputWidgetState createState() => _CreateTitleInputWidgetState();
}

class _CreateTitleInputWidgetState extends State<CreateTitleInputWidget> {
  final log = logger(CreateTitleInputWidget);

  // If still needed, better import the new package version
  // late RichTextController _textController;
  final FocusNode _focusNode = FocusNode();

  // final _matcherDueDate = StringMatcher.matcherDueDate;
  // final _matcherRemindDate = StringMatcher.matcherRemindDate;
  // final _matcherRemindTime = StringMatcher.matcherRemindTime;
  // final _matcherPrio = StringMatcher.matcherPrio;

  @override
  void initState() {
    // _textController = RichTextController(
    //   patternMap: {
    //     // Matching for Due Date
    //     _matcherDueDate: const TextStyle(color: kcPrimary500),
    //     // Matcher for Reminder
    //     _matcherRemindDate: const TextStyle(color: kcSecondary500),
    //     _matcherRemindTime: const TextStyle(color: kcSecondary500),
    //     // /
    //     RegExp(r'\B/[a-zA-Z0-9]+\b'): const TextStyle(color: Colors.green),
    //     // '!' Matcher for Prio
    //     _matcherPrio: const TextStyle(color: Colors.red),
    //   },
    //   onMatch: (List<String> matches) {
    //     print(matches);
    //     //TODO: Do sth with matches
    //   },
    // );

    // _focusNode.addListener(() {
    //  if (!_focusNode.hasFocus) {
    //     FocusScope.of(context).requestFocus(_focusNode);
    //   }
    // });

    super.initState();

    BlocProvider.of<CalendarListBloc>(context, listen: false)
        .add(GetCalendarListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateBloc, CreateState>(
      builder: (context, state) {
        return state.map(
          current: (_state) => SizedBox(
            width: context.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                verticalSpaceSmall,
                //* Text Field for Entering Task Title
                PlatformTextField(
                  // controller: _textController,
                  focusNode: _focusNode,
                  onChanged: (text) {
                    context
                        .read<CreateBloc>()
                        .add(CreateEvent.titleChanged(text));
                  },
                  textAlign: TextAlign.center,
                  autofocus: true,
                  minLines: 1,
                  maxLines: 4,
                  style: context.h4.copyWith(color: kcPrimary100),
                  material: (context, platform) => MaterialTextFieldData(
                    decoration: InputDecoration(
                      hintText: 'Enter ...',
                      hintStyle: context.h4.copyWith(color: Colors.white38),
                      contentPadding: const EdgeInsets.all(16),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                  cupertino: (context, platform) => CupertinoTextFieldData(
                    placeholder: 'Enter ...',
                    placeholderStyle:
                        context.h4.copyWith(color: Colors.white38),
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                ).flexible(),
                if (_state.subTasks != null)
                  for (int i = 0; i < _state.subTasks!.length; i++)
                    CreateSubtaskInputWidget(
                      subtask: _state.subTasks![i],
                      onChanged: (text) {
                        final _subTask = _state.subTasks![i];
                        _state.subTasks![i] = _subTask.copyWith(title: text);
                        context.read<CreateBloc>().add(
                            CreateEvent.subTaskListChanged(_state.subTasks!));
                      },
                    ),

                if (_state.dueDate != null)
                  Text(
                    ' Due on ${CustomDateUtils.returnDateAndMonth(_state.dueDate!)} ',
                    style: context.textTheme.subtitle2!.copyWith(
                      color: kcPrimary700,
                      backgroundColor: kcPrimary200,
                    ),
                  ).padding(bottom: 16, top: 4).alignment(Alignment.center),
              ],
            ),
          ),
        );
      },
    );
  }
}
