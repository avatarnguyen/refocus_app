import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/core/core.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/prio_type.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/create/presentation/bloc/create_bloc.dart';
import 'package:refocus_app/features/create/presentation/widgets/action_icon.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:uuid/uuid.dart';

class ActionBottomWidget extends StatefulWidget {
  const ActionBottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ActionBottomWidget> createState() => _ActionBottomWidgetState();
}

class _ActionBottomWidgetState extends State<ActionBottomWidget> {
  Uuid uuid = const Uuid();
  final _log = logger(ActionBottomWidget);

  //TODO: Refactor this
  final bool _onSelectingDueDate = false;
  bool _onSelectingPrio = false;
  // bool _onAddingTimeBlock = false;

  PrioType? _currentPrio;

  int _currentSegmentedIdx = 0;
  late String _taskID;

  @override
  void initState() {
    super.initState();
    _taskID = uuid.v1();
    context.read<CreateBloc>().add(CreateEvent.idChanged(_taskID));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateBloc, CreateState>(
      builder: (context, state) {
        final _currentText = state.title;

        if (state.todayEntryType == TodayEntryType.event) {
          _currentSegmentedIdx = 1;
        } else {
          _currentSegmentedIdx = 0;
        }

        return Container(
          height: 40,
          color: kcPrimary900,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.close,
                size: 28,
                color: kcSecondary100,
              ).gestures(onTap: context.pop),
              //* Adding Event/Task Switch when selecting date

              CupertinoSlidingSegmentedControl<int>(
                key: const Key('sliding_switch_event_task'),
                padding: const EdgeInsets.all(4),
                groupValue: _currentSegmentedIdx,
                thumbColor: kcPrimary100,
                children: {
                  0: Icon(
                    Icons.task_alt_rounded,
                    color: _currentSegmentedIdx == 0 ? kcPrimary800 : kcPrimary100,
                  ),
                  1: Icon(
                    CupertinoIcons.calendar,
                    color: _currentSegmentedIdx == 1 ? kcPrimary800 : kcPrimary100,
                  ),
                },
                onValueChanged: (value) {
                  if (value != null) {
                    _currentSegmentedIdx = value;
                    //TODO:
                    // _onChangingSelection(ActionSelectionType.task);

                    if (value == 0) {
                      context.read<CreateBloc>().add(const CreateEvent.typeEntryChanged(TodayEntryType.task));
                    } else {
                      context.read<CreateBloc>().add(const CreateEvent.typeEntryChanged(TodayEntryType.event));
                      context.read<CreateBloc>().add(const CreateEvent.dueDateChanged(null));
                    }
                  }
                },
              ),
              [
                if (_currentSegmentedIdx == 0) ...[
                  //* Adding due dates
                  ActionIcon(
                    icon: Icons.today_rounded,
                    color: _onSelectingDueDate ? context.colorScheme.secondary : kcSecondary200,
                    onTap: () {},
                  ),
                  ActionIcon(
                    icon: Icons.flag,
                    onTap: () {
                      if (_currentPrio == null) {
                        context.read<CreateBloc>().add(CreateEvent.titleChanged('${_currentText ?? ''} !'));

                        _currentPrio = PrioType.low;
                      }
                    },
                  ),
                  //* Adding Sub Tasks
                  ActionIcon(
                    icon: Icons.add,
                    onTap: () {
                      final _currentSubtasks = context.read<CreateBloc>().state.subTasks ?? <SubTaskEntry>[];
                      _currentSubtasks.add(
                        SubTaskEntry(
                          id: uuid.v1(),
                          isCompleted: false,
                          taskID: _taskID,
                        ),
                      );

                      context.read<CreateBloc>().add(CreateEvent.subTaskListChanged(_currentSubtasks));
                    },
                  )
                ]
              ].toRow(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
              ),
              Icon(
                Icons.send,
                size: 26,
                color: context.primaryColor,
              ).gestures(
                onTap: () {
                  _log.d('Submit new Event');
                  context.read<CreateBloc>().add(const CreateEvent.submit());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
