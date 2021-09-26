import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/core/presentation/widgets/add_page_widgets/due_datetime_widget.dart';
import 'package:refocus_app/core/presentation/widgets/add_page_widgets/option_widget.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/prio_type.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/project_params.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:uuid/uuid.dart';

import '../../../../injection.dart';
import '../../helper/setting_option.dart';
import '../../helper/text_stream.dart';

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
  bool _onSelectingDueDate = false;
  bool _onSelectingReminder = false;
  bool _onSelectingPrio = false;
  bool _onAddingNote = false;

  final _prioList = [
    PrioType.low,
    PrioType.medium,
    PrioType.high,
  ];

  PrioType? _currentPrio;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _textStream.getTextStream,
      builder: (context, AsyncSnapshot<String> textStream) {
        final _currentText = textStream.data;
        final _key =
            _onSelectingDueDate ? 'Due Date Widget' : 'Reminder Widget';
        return [
          if (_onSelectingPrio)
            _buildSelectionListRow(context, _prioList, _currentText),
          if (_onSelectingDueDate || _onSelectingReminder)
            DueDateTimeWidget(
              key: Key(_key),
              currentText: _currentText ?? '',
              onSelectingReminder: _onSelectingReminder,
              onSelectingDueDate: _onSelectingDueDate,
            ),
          if (!_onSelectingReminder)
            const OptionRowWidget().padding(bottom: 8, top: 4),
          _buildActionInputRow(_currentText, context)
        ].toColumn(
          mainAxisSize: MainAxisSize.min,
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
              backgroundColor: kcPrimary800,
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
    final _tmpStr = currentText.replaceAll(RegExp(r'!{1,3}'), '');
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
        if (_onSelectingReminder)
          _buildActionItem(
            (_settingOption.type == TodayEntryType.event)
                ? Icons.task_alt_rounded
                : CupertinoIcons.calendar,
          ),
        [
          //* Adding due dates and reminder
          _buildActionItem(Icons.today_rounded,
                  color: _onSelectingDueDate
                      ? context.colorScheme.secondary
                      : kcSecondary200)
              .gestures(onTap: () {
            setState(() {
              _onSelectingReminder = false;
              _onSelectingPrio = false;
              _onSelectingDueDate = !_onSelectingDueDate;
            });
          }),
          _buildActionItem(
            Icons.alarm_add,
            color: _onSelectingReminder
                ? context.colorScheme.secondary
                : kcSecondary200,
          ).gestures(onTap: () {
            setState(() {
              _onSelectingDueDate = false;
              _onSelectingPrio = false;
              _onSelectingReminder = !_onSelectingReminder;
            });
          }),
          // Adding Priority
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
              _onSelectingReminder = false;
              _onSelectingDueDate = false;
              _onSelectingPrio = !_onSelectingPrio;
            });
          }),
          //* Adding Sub Tasks
          _buildActionItem(Icons.add).gestures(
            onTap: () {},
          ),
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
            if (_settingOption.type == TodayEntryType.project) {
              BlocProvider.of<ProjectBloc>(context).add(
                CreateProjectEntriesEvent(ProjectParams(
                    ProjectEntry(id: uuid.v1(), title: textData))),
              );
            }
            if (_settingOption.type == TodayEntryType.task) {
              final _startDateTime = _settingOption.plannedStartDate;
              final _endDateTime = _settingOption.plannedEndDate;
              context.read<TaskBloc>().add(
                    CreateTaskEntriesEvent(
                      params: [
                        TaskParams(
                          task: TaskEntry(
                            id: uuid.v1(),
                            isCompleted: false,
                            dueDate: _settingOption.dueDate,
                            projectID:
                                _settingOption.projectEntry?.id ?? 'inbox_2021',
                            title: textData,
                            startDateTime: _startDateTime,
                            endDateTime: _endDateTime,
                            //     _endDateTime != null ? [_endDateTime] : null,
                          ),
                        ),
                      ],
                    ),
                  );
            }
            context.router.pop();
          },
        ),
        // horizontalSpaceTiny,
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceEvenly),
    );
  }
}
