import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/presentation/widgets/custom_bottom_menu_widget.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart'
    as cal_list;
import 'package:refocus_app/features/create/presentation/bloc/create_bloc.dart';
import 'package:refocus_app/features/create/presentation/widgets/action_bottom_widget.dart';
import 'package:refocus_app/features/create/presentation/widgets/create_title_input_widget.dart';
import 'package:refocus_app/features/create/presentation/widgets/planned_datatime_picker_widget.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/presentation/bloc/cubit/subtask_cubit.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/injection.dart';
import 'package:styled_widget/styled_widget.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateBloc>(
      create: (context) => getIt<CreateBloc>()
        ..add(const CreateEvent.typeEntryChanged(TodayEntryType.task)),
      child: const CreatePageWidget(),
    );
  }
}

class CreatePageWidget extends StatefulWidget {
  const CreatePageWidget({Key? key}) : super(key: key);

  @override
  _CreatePageWidgetState createState() => _CreatePageWidgetState();
}

class _CreatePageWidgetState extends State<CreatePageWidget> {
  ProjectEntry? _currentProject;
  CalendarEntry? _currentCalendar;

  @override
  Widget build(BuildContext context) {
    final _topMenuStyle = context.bodyText1.copyWith(
      decoration: TextDecoration.underline,
      color: kcPrimary100,
    );

    return Material(
      child: PlatformScaffold(
        backgroundColor: context.colorScheme.background,
        appBar: PlatformAppBar(
          backgroundColor: Colors.transparent,
          title: BlocBuilder<CreateBloc, CreateState>(
            buildWhen: (previous, current) =>
                previous.todayEntryType != current.todayEntryType,
            builder: (context, state) {
              final _entryType = state.todayEntryType;
              if (_entryType != null) {
                if (_entryType == TodayEntryType.event) {
                  _currentCalendar = state.calendar;
                  return BlocBuilder<cal_list.CalendarListBloc,
                      cal_list.CalendarListState>(
                    builder: (context, cState) {
                      if (cState is cal_list.CalendarListLoaded) {
                        final _calendars = cState.calendarList;
                        return PlatformButton(
                          padding: EdgeInsets.zero,
                          child: Text(
                            _currentCalendar?.name ?? _calendars.first.name,
                            style: _topMenuStyle,
                          ),
                          onPressed: () async {
                            final _optionsMenu = <String, CalendarEntry>{};
                            await Future.forEach(_calendars,
                                (CalendarEntry _calendar) {
                              _optionsMenu.addAll({_calendar.name: _calendar});
                            });
                            final _menuResult =
                                await showCustomBottomMenu<CalendarEntry>(
                              context: context,
                              menuOptionBuilder: () => _optionsMenu,
                            );
                            if (_menuResult != null) {
                              // ignore: use_build_context_synchronously
                              context.read<CreateBloc>().add(
                                  CreateEvent.calendarChanged(_menuResult));
                            }
                          },
                        );
                      } else {
                        return progressIndicator;
                      }
                    },
                  );
                } else {
                  _currentProject = state.project;
                  return BlocBuilder<ProjectBloc, ProjectState>(
                    builder: (context, pState) {
                      if (pState is ProjectLoaded) {
                        final _projects = pState.project;
                        return PlatformButton(
                          padding: EdgeInsets.zero,
                          child: Text(
                            _currentProject?.title ?? _projects.first.title!,
                            style: _topMenuStyle,
                          ),
                          onPressed: () async {
                            final _optionsMenu = <String, ProjectEntry>{};
                            await Future.forEach(_projects,
                                (ProjectEntry _project) {
                              _optionsMenu.addAll({_project.title!: _project});
                            });
                            final _menuResult =
                                await showCustomBottomMenu<ProjectEntry>(
                              context: context,
                              menuOptionBuilder: () => _optionsMenu,
                            );
                            if (_menuResult != null) {
                              // ignore: use_build_context_synchronously
                              context
                                  .read<CreateBloc>()
                                  .add(CreateEvent.projectChanged(_menuResult));
                            }
                          },
                        );
                      } else {
                        return progressIndicator;
                      }
                    },
                  );
                }
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        body: [
          [
            BlocProvider<ProjectBloc>.value(
              value: BlocProvider.of<ProjectBloc>(context),
              child: const CreateTitleInputWidget(),
            ),
            const PlannedDatetimePickerWidget(),
          ]
              .toColumn(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              )
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
            child: const ActionBottomWidget(),
          ),
        ]
            .toColumn(mainAxisAlignment: MainAxisAlignment.spaceBetween)
            .safeArea(),
      ),
    );
  }
}
