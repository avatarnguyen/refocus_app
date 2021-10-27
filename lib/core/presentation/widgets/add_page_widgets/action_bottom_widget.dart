import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/core/presentation/helper/action_stream.dart';
import 'package:refocus_app/core/presentation/helper/setting_option.dart';
import 'package:refocus_app/core/presentation/helper/subtask_stream.dart';
import 'package:refocus_app/core/presentation/helper/text_stream.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/action_selection_type.dart';
import 'package:refocus_app/enum/prio_type.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/event_params.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';
import 'package:refocus_app/features/task/presentation/bloc/cubit/subtask_cubit.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/injection.dart';
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

  final _textStream = getIt<TextStream>();
  final _settingOption = getIt<SettingOption>();
  final _subTaskStream = getIt<SubTaskStream>();
  final _actionStream = getIt<ActionStream>();

  bool _onSelectingDueDate = false;
  bool _onSelectingPrio = false;
  bool _onAddingTimeBlock = false;
  bool _onAddingNote = false;

  PrioType? _currentPrio;

  int _currentSegmentedIdx = 0;

  late String _taskID;

  @override
  void initState() {
    super.initState();
    _taskID = uuid.v1();
    if (_settingOption.type == TodayEntryType.event) {
      _currentSegmentedIdx = 1;
    } else {
      _currentSegmentedIdx = 0;
    }
  }

  void _onChangingSelection(ActionSelectionType type) {
    switch (type) {
      case ActionSelectionType.dueDate:
        if (_onSelectingDueDate) {
          _actionStream.broadCastCurrentActionType(ActionSelectionType.task);
        } else {
          _actionStream.broadCastCurrentActionType(type);
        }
        setState(() {
          _onSelectingPrio = false;
          _onAddingTimeBlock = false;
          _onAddingNote = false;
          _onSelectingDueDate = !_onSelectingDueDate;
        });
        break;
      case ActionSelectionType.prio:
        if (_onSelectingPrio) {
          _actionStream.broadCastCurrentActionType(ActionSelectionType.task);
        } else {
          _actionStream.broadCastCurrentActionType(type);
        }
        setState(() {
          _onSelectingPrio = !_onSelectingPrio;
          _onAddingTimeBlock = false;
          _onAddingNote = false;
          _onSelectingDueDate = false;
        });
        break;
      case ActionSelectionType.note:
        if (_onAddingNote) {
          _actionStream.broadCastCurrentActionType(ActionSelectionType.event);
        } else {
          _actionStream.broadCastCurrentActionType(type);
        }
        setState(() {
          _onSelectingPrio = false;
          _onSelectingDueDate = false;
          _onAddingTimeBlock = false;
          _onAddingNote = !_onAddingNote;
        });
        break;
      default:
        setState(() {
          if (_currentSegmentedIdx == 0) {
            _actionStream.broadCastCurrentActionType(ActionSelectionType.task);
          } else {
            _actionStream.broadCastCurrentActionType(ActionSelectionType.event);
          }

          _onSelectingPrio = false;
          _onSelectingDueDate = false;
          _onAddingTimeBlock = false;
          _onAddingNote = false;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _textStream.getTextStream,
      builder: (context, snapshot) {
        final _currentText = snapshot.data;

        return Container(
          height: 40,
          color: kcPrimary900,
          child: _buildActionInputRow(_currentText, context),
        );
      },
    );
  }

  Widget _buildActionInputRow(String? textData, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Icon(
          Icons.close,
          size: 28,
          color: kcSecondary100,
        ).gestures(onTap: () {
          _settingOption.projectEntry = null;
          _settingOption.broadCastCurrentProjectEntry(null);
          context.router.pop();
        }),
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
              _onChangingSelection(ActionSelectionType.task);

              if (value == 0) {
                _settingOption.broadCastCurrentTypeEntry(TodayEntryType.task);
              } else {
                _settingOption.broadCastCurrentTypeEntry(TodayEntryType.event);
                _settingOption.broadCastCurrentDueDateEntry(null);
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
              _onChangingSelection(ActionSelectionType.dueDate);
            }),
            _buildActionItem(
              Icons.flag,
              color: _onSelectingPrio
                  ? context.colorScheme.secondary
                  : kcSecondary200,
            ).gestures(onTap: () {
              if (_currentPrio == null) {
                _textStream.updateText('${textData ?? ''} !');
                _currentPrio = PrioType.low;
              }
              _onChangingSelection(ActionSelectionType.prio);
            }),
            // _buildActionItem(Icons.bookmark_add).gestures(
            //   onTap: () {
            //     _onChangingSelection(ActionSelectionType.timeBlock);
            //   },
            // ),
            //* Adding Sub Tasks
            _buildActionItem(Icons.add).gestures(
              onTap: () {
                final newSubTasks = _subTaskStream.subTasks;
                newSubTasks.add('');
                _subTaskStream.broadCastCurrentSubTaskListEntry(newSubTasks);
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
            final _type = _settingOption.type;

            final _calEventID = uuid.v4().replaceAll('-', '');
            print('Calendar Event ID $_calEventID');

            if (textData != null) {
              final _startDateTime = _settingOption.plannedStartDate;
              final _endDateTime = _settingOption.plannedEndDate;

              print('Current Type: $_type');

              if (_type == TodayEntryType.task ||
                  _type == TodayEntryType.timeblock ||
                  _type == TodayEntryType.timeblockPrivate) {
                final _subtaskList = _subTaskStream.subTasks;

                context.read<TaskBloc>().add(
                      CreateTaskEntriesEvent(
                        params: [
                          TaskParams(
                            task: TaskEntry(
                              id: _taskID,
                              isCompleted: false,
                              dueDate: _settingOption.dueDate,
                              projectID: _settingOption.projectEntry?.id ??
                                  'inbox_2021',
                              title: textData,
                              startDateTime: _startDateTime,
                              endDateTime: _endDateTime,
                              priority: 0,
                              isHabit: false,
                              calendarID: _calEventID,
                            ),
                          ),
                        ],
                      ),
                    );
                if (_subtaskList.isNotEmpty) {
                  for (final title in _subtaskList) {
                    final newSubTask = SubTaskEntry(
                      id: uuid.v4(),
                      isCompleted: false,
                      taskID: _taskID,
                      title: title,
                      priority: 0,
                    );
                    context.read<SubtaskCubit>().createNewSubtask(newSubTask);
                  }
                }
              }
              if (_type == TodayEntryType.event ||
                  _type == TodayEntryType.timeblock ||
                  _type == TodayEntryType.timeblockPrivate) {
                final _selectedCal = _settingOption.calendarEntry;
                if (_startDateTime != null) {
                  final _event = EventParams(
                    calendarId: _selectedCal?.id,
                    eventEntry: CalendarEventEntry(
                      id: _calEventID,
                      subject: _type == TodayEntryType.timeblockPrivate
                          ? 'Blocked'
                          : textData,
                      calendarId: _selectedCal?.id,
                      startDateTime:
                          CustomDateUtils.toGoogleRFCDateTime(_startDateTime),
                      endDateTime: CustomDateUtils.toGoogleRFCDateTime(
                          _endDateTime ?? _startDateTime + 1.hours),
                    ),
                  );
                  print('Add New Event: $_event');

                  context.read<CalendarBloc>().add(AddCalendarEvent(_event));
                }
              }
              context.router.pop();
            }
          },
        ),
      ],
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
