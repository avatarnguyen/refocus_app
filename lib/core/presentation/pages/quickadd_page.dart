import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/presentation/helper/action_stream.dart';
import 'package:refocus_app/core/presentation/helper/setting_option.dart';
import 'package:refocus_app/core/presentation/helper/subtask_stream.dart';
import 'package:refocus_app/core/presentation/widgets/add_page_widgets/action_panel_widget.dart';
import 'package:refocus_app/core/presentation/widgets/add_page_widgets/add_textfield_widget.dart';
import 'package:refocus_app/core/presentation/widgets/add_page_widgets/due_datetime_widget.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/action_selection_type.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart'
    as calList;
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/presentation/bloc/cubit/subtask_cubit.dart';
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

  ProjectEntry? _currentProject;
  CalendarEntry? _currentCalendar;

  @override
  void initState() {
    _currentProject = _settingOption.projectEntry;

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

  void _showIOSPicker({
    List<CalendarEntry>? calendars,
    List<ProjectEntry>? projects,
  }) {
    showCupertinoModalPopup<dynamic>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          if (calendars != null)
            buildPicker(calendars)
          else
            buildPicker(projects!)
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => context.router.pop(),
          child: 'Cancel'.toButtonText(color: kcError500),
        ),
      ),
    );
  }

  Widget materialDropDownMenu({
    List<CalendarEntry>? calendars,
    List<ProjectEntry>? projects,
  }) {
    late List items;
    if (calendars != null) {
      items = calendars;
    } else {
      items = projects!;
    }

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.colorScheme.background,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isDense: true,
          focusColor: Colors.white,
          iconEnabledColor: Colors.white,
          value: _currentCalendar?.name,
          dropdownColor: context.colorScheme.background,
          alignment: AlignmentDirectional.center,
          style: context.subtitle1.copyWith(
            color: Colors.white,
          ),
          items: items.map<DropdownMenuItem<String>>(
            (dynamic _item) {
              if (_item is CalendarEntry) {
                return DropdownMenuItem<String>(
                  value: _item.name,
                  child: Text(
                    _item.name,
                    textAlign: TextAlign.center,
                    style: context.subtitle1.copyWith(
                      color: Colors.white,
                    ),
                  ),
                );
              } else if (_item is ProjectEntry) {
                return DropdownMenuItem<String>(
                  value: _item.title,
                  child: Text(
                    _item.title ?? '',
                    textAlign: TextAlign.center,
                    style: context.subtitle1.copyWith(
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                return const DropdownMenuItem<String>(
                  value: '',
                  child: Text(''),
                );
              }
            },
          ).toList(),
          hint: Text(
            calendars != null ? 'Select a calendar' : 'Select a project',
            textAlign: TextAlign.center,
            style: context.subtitle1.copyWith(
              color: Colors.white,
            ),
          ),
          onChanged: (String? newValue) {
            if (items is List<CalendarEntry>) {
              final selectedCal = items.singleWhere(
                (element) => element.name == newValue,
              );
              _settingOption.broadCastCurrentCalendarEntry(selectedCal);
              setState(() {
                _currentCalendar = selectedCal;
              });
            }
            if (items is List<ProjectEntry>) {
              final _selectedProject = items.singleWhere(
                (element) => element.title == newValue,
              );
              _settingOption.broadCastCurrentProjectEntry(_selectedProject);
              setState(() {
                _currentProject = _selectedProject;
              });
            }
          },
        ),
      ),
    );
  }

  Widget buildPicker(List items) => SizedBox(
        height: 240,
        child: CupertinoPicker(
          backgroundColor: context.backgroundColor,
          itemExtent: 40,
          onSelectedItemChanged: (index) {
            if (items is List<CalendarEntry>) {
              _settingOption.broadCastCurrentCalendarEntry(items[index]);
              setState(() {
                _currentCalendar = items[index];
              });
            }
            if (items is List<ProjectEntry>) {
              _settingOption.broadCastCurrentProjectEntry(items[index]);
              setState(() {
                _currentProject = items[index];
              });
            }
          },
          children: items.map<Widget>((dynamic item) {
            final _itemTextStyle = context.bodyText2;
            if (item is CalendarEntry) {
              final _currentColor =
                  StyleUtils.getColorFromString(item.color ?? '#8879FC');
              return Center(
                child: Text(
                  item.name,
                  style: _itemTextStyle.copyWith(color: _currentColor),
                ),
              );
            } else if (item is ProjectEntry) {
              final _currentColor =
                  StyleUtils.getColorFromString(item.color ?? '#8879FC');
              return Center(
                child: Text(
                  item.title ?? '',
                  style: _itemTextStyle.copyWith(color: _currentColor),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }).toList(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final _projectTextStyle = context.bodyText1.copyWith(
      decoration: TextDecoration.underline,
      color: kcPrimary100,
    );

    return Material(
      child: PlatformScaffold(
        backgroundColor: context.colorScheme.background,
        material: (_, __) => MaterialScaffoldData(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: StreamBuilder<TodayEntryType>(
                stream: _settingOption.typeStream,
                builder: (context, snapshot) {
                  final _entryType = snapshot.data;
                  if (_entryType != null) {
                    if (_entryType == TodayEntryType.event) {
                      return BlocBuilder<calList.CalendarListBloc,
                          calList.CalendarListState>(builder: (context, state) {
                        if (state is calList.Loaded) {
                          final calendars = state.calendarList;
                          return Text(
                            _currentCalendar?.name ?? 'Tap to choose',
                            style: _projectTextStyle,
                          ).gestures(
                            onTap: () =>
                                materialDropDownMenu(calendars: calendars),
                          );
                        } else {
                          return progressIndicator;
                        }
                      });
                    } else {
                      return BlocBuilder<ProjectBloc, ProjectState>(
                          builder: (context, state) {
                        if (state is ProjectLoaded) {
                          final _projects = state.project;
                          return Text(
                            _currentProject?.title ?? 'Tap to choose',
                            style: _projectTextStyle,
                          ).gestures(
                            onTap: () =>
                                materialDropDownMenu(projects: _projects),
                          );
                        } else {
                          return progressIndicator;
                        }
                      });
                    }
                  }
                  return const SizedBox.shrink();
                }),
          ),
        ),
        cupertino: (_, __) => CupertinoPageScaffoldData(
            navigationBar: CupertinoNavigationBar(
          backgroundColor: context.colorScheme.background,
          border: null,
          automaticallyImplyLeading: false,
          middle: StreamBuilder<TodayEntryType>(
              stream: _settingOption.typeStream,
              builder: (context, snapshot) {
                final _entryType = snapshot.data;
                if (_entryType != null) {
                  if (_entryType == TodayEntryType.event) {
                    return BlocBuilder<calList.CalendarListBloc,
                        calList.CalendarListState>(builder: (context, state) {
                      if (state is calList.Loaded) {
                        final calendars = state.calendarList;
                        final _currentColor = StyleUtils.getColorFromString(
                            _currentCalendar?.color ?? '#8879FC');
                        return Text(
                          _currentCalendar?.name ?? 'Select a calendar',
                          style: _projectTextStyle.copyWith(
                            color: _currentColor,
                          ),
                        ).gestures(
                          onTap: () => _showIOSPicker(calendars: calendars),
                        );
                      } else {
                        return progressIndicator;
                      }
                    });
                  } else {
                    return BlocBuilder<ProjectBloc, ProjectState>(
                        builder: (context, state) {
                      if (state is ProjectLoaded) {
                        final _projects = state.project;
                        final _currentColor = StyleUtils.getColorFromString(
                            _currentProject?.color ?? '#8879FC');
                        return Text(
                          _currentProject?.title ?? 'Select a project',
                          style: _projectTextStyle.copyWith(
                            color: _currentColor,
                          ),
                        ).gestures(
                          onTap: () => _showIOSPicker(projects: _projects),
                        );
                      } else {
                        return progressIndicator;
                      }
                    });
                  }
                }
                return const SizedBox.shrink();
              }),
        )),
        body: [
          [
            BlocProvider<ProjectBloc>.value(
              value: BlocProvider.of<ProjectBloc>(context),
              child: const AddTextFieldWidget(),
            ),
            const SetPlannedDateTimeWidget(),
          ]
              .toColumn(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround)
              .scrollable()
              .expanded(),
          MultiBlocProvider(
            providers: [
              BlocProvider<CalendarBloc>.value(
                value: BlocProvider.of<CalendarBloc>(context),
              ),
              BlocProvider<SubtaskCubit>.value(
                value: BlocProvider.of<SubtaskCubit>(context),
              ),
            ],
            child: const ActionPanelWidget(),
          ),
        ]
            .toColumn(mainAxisAlignment: MainAxisAlignment.spaceBetween)
            .safeArea(),
      ),
    );
  }
}
