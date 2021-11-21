import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/prio_type.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/create/presentation/bloc/create_bloc.dart';
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

  //TODO: Refactor this
  bool _onSelectingDueDate = false;
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
              ).gestures(onTap: context.router.pop),
              //* Adding Event/Task Switch when selecting date

              CupertinoSlidingSegmentedControl<int>(
                key: const Key('sliding_switch_event_task'),
                padding: const EdgeInsets.all(4),
                groupValue: _currentSegmentedIdx,
                thumbColor: kcPrimary100,
                children: {
                  0: Icon(
                    Icons.task_alt_rounded,
                    color:
                        _currentSegmentedIdx == 0 ? kcPrimary800 : kcPrimary100,
                  ),
                  1: Icon(
                    CupertinoIcons.calendar,
                    color:
                        _currentSegmentedIdx == 1 ? kcPrimary800 : kcPrimary100,
                  ),
                },
                onValueChanged: (value) {
                  if (value != null) {
                    _currentSegmentedIdx = value;
                    //TODO:
                    // _onChangingSelection(ActionSelectionType.task);

                    if (value == 0) {
                      context.read<CreateBloc>().add(
                          const CreateEvent.typeEntryChanged(
                              TodayEntryType.task));
                    } else {
                      context.read<CreateBloc>().add(
                          const CreateEvent.typeEntryChanged(
                              TodayEntryType.event));
                      context
                          .read<CreateBloc>()
                          .add(const CreateEvent.dueDateChanged(null));
                    }
                  }
                },
              ),
              [
                if (_currentSegmentedIdx == 0) ...[
                  //* Adding due dates
                  _buildActionItem(Icons.today_rounded,
                          color: _onSelectingDueDate
                              ? context.colorScheme.secondary
                              : kcSecondary200)
                      .gestures(onTap: () {
                    //TODO
                    // _onChangingSelection(ActionSelectionType.dueDate);
                  }),
                  _buildActionItem(
                    Icons.flag,
                    color: _onSelectingPrio
                        ? context.colorScheme.secondary
                        : kcSecondary200,
                  ).gestures(onTap: () {
                    if (_currentPrio == null) {
                      context.read<CreateBloc>().add(
                          CreateEvent.titleChanged('${_currentText ?? ''} !'));

                      _currentPrio = PrioType.low;
                    }
                    //TODO
                    // _onChangingSelection(ActionSelectionType.prio);
                  }),
                  //* Adding Sub Tasks
                  _buildActionItem(Icons.add).gestures(
                    onTap: () {
                      final _currentSubtasks =
                          context.read<CreateBloc>().state.subTasks ??
                              <SubTaskEntry>[];
                      _currentSubtasks.add(
                        SubTaskEntry(
                          id: uuid.v1(),
                          isCompleted: false,
                          taskID: _taskID,
                        ),
                      );

                      context.read<CreateBloc>().add(
                          CreateEvent.subTaskListChanged(_currentSubtasks));
                    },
                  ),
                ] else ...[
                  _buildActionItem(Icons.pin_drop).gestures(
                    onTap: () {},
                  ),
                  _buildActionItem(Icons.note_add).gestures(
                    onTap: () {},
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
                  //   final _type = _settingOption.type;

                  //   final _calEventID = uuid.v4().replaceAll('-', '');
                  //   print('Calendar Event ID $_calEventID');

                  //   if (_currentText != null) {
                  //     final _startDateTime = _settingOption.plannedStartDate;
                  //     final _endDateTime = _settingOption.plannedEndDate;

                  //     print('Current Type: $_type');

                  //     if (_type == TodayEntryType.task ||
                  //         _type == TodayEntryType.timeblock ||
                  //         _type == TodayEntryType.timeblockPrivate) {
                  //       final _subtaskList = _subTaskStream.subTasks;

                  //       context.read<TaskBloc>().add(
                  //             CreateTaskEntriesEvent(
                  //               params: [
                  //                 TaskParams(
                  //                   task: TaskEntry(
                  //                     id: _taskID,
                  //                     isCompleted: false,
                  //                     dueDate: _settingOption.dueDate,
                  //                     projectID: _settingOption.projectEntry!
                  //                         .id, //! cannot read projectEntry
                  //                     title: _currentText,
                  //                     startDateTime: _startDateTime,
                  //                     endDateTime: _endDateTime,
                  //                     priority: 0,
                  //                     isHabit: false,
                  //                     calendarID: _calEventID,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           );
                  //       if (_subtaskList.isNotEmpty) {
                  //         for (final title in _subtaskList) {
                  //           final newSubTask = SubTaskEntry(
                  //             id: uuid.v4(),
                  //             isCompleted: false,
                  //             taskID: _taskID,
                  //             title: title,
                  //             priority: 0,
                  //           );
                  //           context.read<SubtaskCubit>().createNewSubtask(newSubTask);
                  //         }
                  //       }
                  //     }
                  //     if (_type == TodayEntryType.event ||
                  //         _type == TodayEntryType.timeblock ||
                  //         _type == TodayEntryType.timeblockPrivate) {
                  //       final _selectedCal = _settingOption.calendarEntry;
                  //       if (_startDateTime != null) {
                  //         final _event = EventParams(
                  //           calendarId: _selectedCal?.id,
                  //           eventEntry: CalendarEventEntry(
                  //             id: _calEventID,
                  //             subject: _type == TodayEntryType.timeblockPrivate
                  //                 ? 'Blocked'
                  //                 : _currentText,
                  //             calendarId: _selectedCal?.id,
                  //             startDateTime:
                  //                 CustomDateUtils.toGoogleRFCDateTime(_startDateTime),
                  //             endDateTime: CustomDateUtils.toGoogleRFCDateTime(
                  //                 _endDateTime ?? _startDateTime + 1.hours),
                  //           ),
                  //         );
                  //         print('Add New Event: $_event');

                  //         context.read<CalendarBloc>().add(AddCalendarEvent(_event));
                  //       }
                  //     }
                  //     context.router.pop();
                  //   }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionItem(IconData? icon, {Color? color}) {
    return Icon(
      icon,
      size: 24,
      color: color ?? kcSecondary200,
    ).padding(horizontal: 8);
  }
}
