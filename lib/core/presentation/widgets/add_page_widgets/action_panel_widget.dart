import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/core/presentation/helper/setting_option.dart';
import 'package:refocus_app/core/presentation/helper/subtask_stream.dart';
import 'package:refocus_app/core/presentation/helper/text_stream.dart';
import 'package:refocus_app/core/presentation/widgets/add_page_widgets/add_timeblock_widget.dart';
import 'package:refocus_app/core/presentation/widgets/add_page_widgets/set_duedate_widget.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/prio_type.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/event_params.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/project_params.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/injection.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:uuid/uuid.dart';

class ActionPanelWidget extends StatefulWidget {
  const ActionPanelWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ActionPanelWidgetState createState() => _ActionPanelWidgetState();
}

class _ActionPanelWidgetState extends State<ActionPanelWidget> {
  Uuid uuid = const Uuid();

  final _textStream = getIt<TextStream>();
  final _settingOption = getIt<SettingOption>();
  final _subTaskStream = getIt<SubTaskStream>();

  bool _onSelectingDueDate = false;
  bool _onSelectingPrio = false;
  bool _onAddingTimeBlock = false;
  bool _onAddingNote = false;

  final _prioList = [
    PrioType.low,
    PrioType.medium,
    PrioType.high,
  ];
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _textStream.getTextStream,
      builder: (context, AsyncSnapshot<String> textStream) {
        final _currentText = textStream.data;
        return [
          if (_onSelectingPrio)
            _buildSelectionListRow(context, _prioList, _currentText),

          if (_onAddingTimeBlock)
            const AddTimeBlockWidget().padding(vertical: 4),

          if (_onSelectingDueDate)
            const SetDueDateWidget().padding(vertical: 4),

          // Action Bottom Panel
          _buildActionInputRow(_currentText, context)
        ].toColumn(mainAxisSize: MainAxisSize.min);
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

  String _getItemString(dynamic item) {
    if (item is ProjectEntry) {
      return item.title?.trim() ?? '';
    } else if (item is PrioType) {
      final _dueDateString = <String>['Low Prio', 'Medium Prio', 'High Prio'];
      return _dueDateString[item.index];
    } else {
      return item as String;
    }
  }

  Widget _buildSelectionListRow(
      BuildContext context, List items, String? currentText) {
    return SizedBox(
      height: 44,
      width: context.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final dynamic _item = items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              backgroundColor: context.colorScheme.primaryVariant,
              selectedColor: context.colorScheme.secondary,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: kcPrimary100),
                borderRadius: BorderRadius.circular(8),
              ),
              label: Text(
                _getItemString(_item),
                style: context.subtitle1.copyWith(
                  color: kcPrimary100,
                ),
              ),
              selected:
                  _settingOption.projectEntry == _item || _currentPrio == _item,
              onSelected: (bool selected) {
                setState(() {
                  if (_item is ProjectEntry) {
                    _settingOption.projectEntry = _item;
                    _settingOption.broadCastCurrentProjectEntry(_item);
                  }
                  if (_item is PrioType) {
                    _currentPrio = _item;
                    _mapPrioTypeToAction(_item, currentText ?? '');
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }

  void _mapPrioTypeToAction(PrioType prio, String currentText) {
    final _tmpStr = currentText.replaceAll(RegExp('!{1,3}'), '');
    switch (prio) {
      case PrioType.low:
        _textStream.updateText('$_tmpStr!');
        break;
      case PrioType.medium:
        _textStream.updateText('$_tmpStr!!');
        break;
      case PrioType.high:
        _textStream.updateText('$_tmpStr!!!');
        break;
      default:
    }
  }

  //* Action Row at the Bottom
  Container _buildActionInputRow(String? textData, BuildContext context) {
    return Container(
      height: 40,
      color: kcPrimary900,
      child: [
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
              if (value == 0) {
                _settingOption.broadCastCurrentTypeEntry(TodayEntryType.task);
              } else {
                _settingOption.broadCastCurrentTypeEntry(TodayEntryType.event);
                _settingOption.broadCastCurrentDueDateEntry(null);
              }

              setState(() {
                _currentSegmentedIdx = value;
                _onSelectingPrio = false;
                _onSelectingDueDate = false;
                _onAddingTimeBlock = false;
                _onAddingNote = false;
              });
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
              setState(() {
                _onSelectingPrio = false;
                _onAddingTimeBlock = false;
                _onSelectingDueDate = !_onSelectingDueDate;
              });
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
              setState(() {
                _onSelectingDueDate = false;
                _onAddingTimeBlock = false;
                _onSelectingPrio = !_onSelectingPrio;
              });
            }),
            //* Adding Sub Tasks
            _buildActionItem(Icons.bookmark_add).gestures(
              onTap: () {
                setState(() {
                  _onSelectingDueDate = false;
                  _onSelectingPrio = false;
                  _onAddingTimeBlock = !_onAddingTimeBlock;
                });
              },
            ),
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
        // horizontalSpaceTiny,
        Icon(
          Icons.send,
          size: 26,
          color: context.primaryColor,
        ).gestures(
          onTap: () {
            final _type = _settingOption.type;
            if (_type == TodayEntryType.project) {
              BlocProvider.of<ProjectBloc>(context).add(
                CreateProjectEntriesEvent(ProjectParams(
                    ProjectEntry(id: uuid.v1(), title: textData))),
              );
            }
            if (_type == TodayEntryType.task) {
              final _startDateTime = _settingOption.plannedStartDate;
              final _endDateTime = _settingOption.plannedEndDate;
              final _subtaskList = _subTaskStream.subTasks;

              //TODO: Create Subtask
              Future.forEach(_subtaskList, (String _title) {
                final newSubTask = SubTaskEntry(
                  id: uuid.v1(),
                  isCompleted: false,
                  todoID: _taskID,
                  title: _title,
                );
              });

              context.read<TaskBloc>().add(
                    CreateTaskEntriesEvent(
                      params: [
                        TaskParams(
                          task: TaskEntry(
                            id: _taskID,
                            isCompleted: false,
                            dueDate: _settingOption.dueDate,
                            projectID:
                                _settingOption.projectEntry?.id ?? 'inbox_2021',
                            title: textData,
                            startDateTime: _startDateTime,
                            endDateTime: _endDateTime,
                            priority: 0,
                            isHabit: false,
                          ),
                        ),
                      ],
                    ),
                  );
            }
            if (_type == TodayEntryType.timeblock ||
                _type == TodayEntryType.timeblockPrivate) {
              // context.read<CalendarBloc>().add(AddCalendarEvent(EventParams(eventEntry: CalendarEventEntry(subject: ))))
            }
            context.router.pop();
          },
        ),
        // horizontalSpaceTiny,
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceEvenly),
    );
  }
}
