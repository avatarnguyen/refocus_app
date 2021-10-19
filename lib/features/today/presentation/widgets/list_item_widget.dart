import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:refocus_app/core/presentation/widgets/edit_page_widgets/detail_task_view.dart';
import 'package:refocus_app/core/presentation/widgets/edit_page_widgets/edit_task_header.dart';
import 'package:refocus_app/core/presentation/widgets/edit_page_widgets/edit_task_view.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/enum/today_event_type.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/datetime_stream.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';
import 'package:refocus_app/features/task/presentation/bloc/cubit/subtask_cubit.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/features/today/domain/today_entry.dart';
import 'package:refocus_app/features/today/presentation/bloc/today_bloc.dart';
import 'package:refocus_app/features/today/presentation/widgets/sub_task_item.dart';
import 'package:refocus_app/injection.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:styled_widget/styled_widget.dart';

const timeLineWidth = 48.0;

class ListItemWidget extends StatefulWidget {
  const ListItemWidget(
      {Key? key, this.entry, this.selectedDate, this.task, this.projectColor})
      : super(key: key);

  final TodayEntry? entry;
  final TaskEntry? task;
  final DateTime? selectedDate;
  final String? projectColor;

  @override
  State<ListItemWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  final DateTimeStream _dateTimeStream = getIt<DateTimeStream>();
  final SheetController _sheetController = SheetController();

  final _log = logger(ListItemWidget);

  DateTime? _dueDateTime;
  DateTime? _startDateTime;
  DateTime? _endDateTime;
  String? _title;
  String? _colorID;
  late String _id;
  late bool _isCompleted;
  List<SubTaskEntry>? _subtasks;
  late TodayEntryType _type;

  TaskEntry? _currentTask;

  @override
  void initState() {
    super.initState();
    if (widget.entry != null) {
      _id = widget.entry!.id;
      _dueDateTime = widget.entry!.dueDateTime;
      _startDateTime = widget.entry!.startDateTime;
      _endDateTime = widget.entry!.endDateTime;
      _title = widget.entry!.title;
      _colorID = widget.entry!.color;
      _subtasks = widget.entry!.subTaskEntries;
      _isCompleted = widget.entry!.isCompleted ?? false;
      _type = widget.entry!.type;
    } else if (widget.task != null) {
      _currentTask = widget.task;
      _id = widget.task!.id;
      _dueDateTime = widget.task!.dueDate;
      _startDateTime = widget.task!.startDateTime;
      _endDateTime = widget.task!.endDateTime;
      _title = widget.task!.title;
      _colorID = widget.task!.colorID;
      _isCompleted = widget.task!.isCompleted;
      _type = TodayEntryType.task;
    }
    // context.read<SubtaskCubit>().getSubTasksFromTask(_id);
  }

  Widget? _cellContentContainer;

  @override
  Widget build(BuildContext context) {
    final _isEvent = _type == TodayEntryType.event;
    final _isPassed =
        _endDateTime != null && _endDateTime!.compareTo(DateTime.now()) <= 0;
    final _color = StyleUtils.getColorFromString(
        _colorID ?? widget.projectColor ?? '#115FFB');
    final _backgroudColor = StyleUtils.lighten(_color, 0.32);
    final _textColor = StyleUtils.darken(_color, 0.2);

    // print('$title Color: ${HSLColor.fromColor(_color).lightness}');

    final _taskTimeTextStyle = context.subtitle2.copyWith(color: _textColor);

    var _startTimeStr = '';
    String? _endTimeStr;
    TodayEventType? _eventBlocType;

    if (widget.selectedDate != null) {
      if (_dueDateTime != null &&
          widget.selectedDate!.day == _dueDateTime!.day) {
        _startTimeStr = 'due today';
        // Get Today Event Type for TodayBloc
        _eventBlocType = _dueDateTime!.isToday
            ? TodayEventType.today
            : _startDateTime!.isTomorrow
                ? TodayEventType.tomorrow
                : TodayEventType.upcoming;
      } else if (_startDateTime != null) {
        final _startDateTimeStr =
            CustomDateUtils.returnTime(_startDateTime!.toLocal());
        _startTimeStr = _startDateTimeStr;
        // Get Today Event Type for TodayBloc
        _eventBlocType = _startDateTime!.isToday
            ? TodayEventType.today
            : _startDateTime!.isTomorrow
                ? TodayEventType.tomorrow
                : TodayEventType.upcoming;
        if (_endDateTime != null) {
          final _endTime = _endDateTime!.toLocal();
          _endTimeStr = CustomDateUtils.returnTime(_endTime);
        }
      }
    }
    // Change to specific Date when selected Date is chose
    if (_dateTimeStream.selectedDate != null &&
        _dateTimeStream.selectedDate!.isToday == false) {
      _eventBlocType = TodayEventType.specificDate;
    }

    // _log.d('Selected Date: ${widget.selectedDate}');
    _log.d('Container: $_cellContentContainer');

    // _cellContentContainer ??=

    return Slidable.builder(
      key: Key(_id),
      actionPane: const SlidableStrechActionPane(),
      actionExtentRatio: .4,
      actionDelegate: _isEvent
          ? null
          : SlideActionBuilderDelegate(
              builder: (context, index, animation, step) {
                // print('Current Animation: ${animation?.value}');

                return IconSlideAction(
                  color: step == SlidableRenderingMode.dismiss
                      ? kcSuccess500
                      : Colors.transparent,
                  foregroundColor: step == SlidableRenderingMode.slide
                      ? kcPrimary500.withOpacity(animation!.value)
                      : (step == SlidableRenderingMode.dismiss
                          ? Colors.white
                          : kcPrimary500),
                  icon: Icons.check,
                  caption: animation!.value > 0.96 ? 'Mark as Done' : null,
                  onTap: () async {
                    // final state = Slidable.of(context);
                  },
                );
              },
              actionCount: 1,
            ),
      secondaryActionDelegate: SlideActionBuilderDelegate(
        actionCount: 2,
        builder: (context, index, animation, step) {
          // print('Current Animation: ${animation?.value}');
          if (index == 0 && step != SlidableRenderingMode.dismiss) {
            return IconSlideAction(
              icon: Icons.calendar_today_rounded,
              foregroundColor: _color,
              color: Colors.transparent,
              onTap: () {},
            );
          } else if (index == 0 && step == SlidableRenderingMode.dismiss) {
            return IconSlideAction(
              icon: Icons.calendar_today_rounded,
              foregroundColor: kcWarning500,
              color: kcWarning500,
              onTap: () {},
            );
          } else {
            return IconSlideAction(
              icon: Icons.arrow_forward_outlined,
              foregroundColor: step == SlidableRenderingMode.slide
                  ? kcPrimary500.withOpacity(
                      animation!.value <= 0.7 ? animation.value + 0.3 : 1.0)
                  : (step == SlidableRenderingMode.dismiss
                      ? kcPrimary500
                      : kcError500),
              color: step == SlidableRenderingMode.dismiss
                  ? kcWarning500
                  : Colors.transparent,
              caption: animation!.value >= 0.8 ? 'postpone by 1 day' : null,
              onTap: () async {
                // final state = Slidable.of(context);
                if (_isEvent) {
                  //TODO
                } else {
                  final _currentDate =
                      _startDateTime ?? _dueDateTime ?? DateTime.now();
                  final _newDate = _currentDate + 1.days;
                  context.read<TaskBloc>().add(EditTaskEntryEvent(
                        params: TaskParams(
                          task: widget.task ??
                              returnTaskFromTodayEntry(
                                widget.entry!,
                                newDate: _newDate,
                              ),
                        ),
                      ));

                  if (_dateTimeStream.selectedDate != null &&
                      _dateTimeStream.selectedDate!.isToday != true) {
                    context.read<TodayBloc>().add(GetTodayEntriesOfSpecificDate(
                        _dateTimeStream.selectedDate!));
                  } else {
                    context.read<TodayBloc>().add(const GetTodayEntries());
                  }
                }
              },
            );
          }
        },
      ),
      dismissal: SlidableDismissal(
        onDismissed: (actionTyp) {
          if (_isEvent) {
          } else {
            if (actionTyp == SlideActionType.primary) {
              // Mark Task as Done
              context.read<TaskBloc>().add(EditTaskEntryEvent(
                    params: TaskParams(
                        task: widget.task ??
                            returnTaskFromTodayEntry(
                              widget.entry!,
                              isCompleted: _isCompleted,
                            )),
                  ));
              context.read<TodayBloc>().add(const GetTodayEntries());
            } else {
              // Postpone Task to next day
              final _currentDate =
                  _startDateTime ?? _dueDateTime ?? DateTime.now();
              final _newDate = _currentDate + 1.days;
              context.read<TaskBloc>().add(EditTaskEntryEvent(
                    params: TaskParams(
                        task: widget.task ??
                            returnTaskFromTodayEntry(
                              widget.entry!,
                              newDate: _newDate,
                            )),
                  ));

              if (_dateTimeStream.selectedDate != null &&
                  !_dateTimeStream.selectedDate!.isToday) {
                context.read<TodayBloc>().add(UpdateTaskEntries(
                    eventType: TodayEventType.specificDate,
                    date: _dateTimeStream.selectedDate));
              } else {
                context.read<TodayBloc>().add(const GetTodayEntries());
              }
            }
            if (actionTyp == SlideActionType.secondary) {}
          }
        },
        dismissThresholds: const <SlideActionType, double>{
          SlideActionType.primary: .4,
          SlideActionType.secondary: 0.6,
        },
        child: const SlidableDrawerDismissal(),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: _textColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        padding: const EdgeInsets.only(left: 8),
        child: Container(
                // key: UniqueKey(),
                width: context.width - (8 + 28 + 8), //8 is hori padding
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                decoration: BoxDecoration(
                  color: _isEvent ? Colors.white : _backgroudColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  boxShadow: const [
                    kShadowLightBase,
                    kShadowLight20,
                  ],
                ),
                child: [
                  [
                    Text(
                      _title ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textScaleFactor: context.textScaleFactor,
                      style: context.bodyText1.copyWith(
                        color: _textColor,
                        fontSize: kSmallTextSize,
                        decoration: _isEvent && _isPassed
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ).expanded(),
                  ].toRow(),
                  [
                    Text(
                      _startTimeStr,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      textScaleFactor: context.textScaleFactor,
                      style: _startDateTime != null
                          ? context.textTheme.subtitle2!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: _textColor,
                            )
                          : _taskTimeTextStyle,
                    ),
                    if (_endDateTime != null && _endTimeStr != null) ...[
                      Icon(Icons.arrow_right_alt_rounded,
                              size: 20, color: _textColor)
                          .padding(horizontal: 2),
                      Text(
                        _endTimeStr,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        textScaleFactor: context.textScaleFactor,
                        style: _taskTimeTextStyle,
                      )
                    ]
                  ].toRow(),

                  //* Subtask
                  if (!_isEvent &&
                      _subtasks != null &&
                      _subtasks!.isNotEmpty) ...[
                    verticalSpaceTiny,
                    SubTaskItem(
                      subTask: _subtasks!.first,
                      backgroundColor: _color,
                      type: _eventBlocType,
                    ),
                    if (_subtasks!.length > 1)
                      SubTaskItem(
                        subTask: _subtasks!.second!,
                        backgroundColor: _color,
                        type: _eventBlocType,
                      ),
                  ]
                ].toColumn(mainAxisSize: MainAxisSize.min))
            .gestures(onTap: () {
          if (_isEvent) {
            //TODO: Display Event Details
          } else {
            showTaskBottomSheet();
          }
        }),
      ).paddingDirectional(horizontal: 4),
    ).padding(horizontal: 6, vertical: 6);
  }

  TaskEntry returnTaskFromTodayEntry(TodayEntry todayEntry,
      {bool? isCompleted, DateTime? newDate}) {
    final _startDateTime = newDate != null && todayEntry.startDateTime != null
        ? todayEntry.startDateTime!.copyWith(
            day: newDate.day,
            month: newDate.month,
            year: newDate.year,
          )
        : todayEntry.startDateTime;

    final _endDateTime = newDate != null && todayEntry.endDateTime != null
        ? todayEntry.endDateTime!.copyWith(
            day: newDate.day,
            month: newDate.month,
            year: newDate.year,
          )
        : todayEntry.endDateTime;

    final _dueDate = newDate != null && todayEntry.dueDateTime != null
        ? todayEntry.dueDateTime!.copyWith(
            day: newDate.day,
            month: newDate.month,
            year: newDate.year,
          )
        : todayEntry.dueDateTime;

    return TaskEntry(
      id: todayEntry.id,
      isCompleted: isCompleted ?? todayEntry.isCompleted ?? false,
      completedDate:
          (isCompleted != null && isCompleted) ? DateTime.now() : null,
      projectID: todayEntry.projectOrCalID!,
      calendarID: todayEntry.calendarEventID,
      colorID: todayEntry.color,
      title: todayEntry.title,
      dueDate: _dueDate,
      startDateTime: _startDateTime,
      endDateTime: _endDateTime,
      description: todayEntry.description,
      priority: todayEntry.priority,
      isHabit: todayEntry.type == TodayEntryType.habit,
    );
  }

  SlidingSheetDialog? _taskSheetDialog;

  dynamic showTaskBottomSheet() async {
    Widget? _headerWidget;

    await showSlidingBottomSheet<dynamic>(
      context,
      // useRootNavigator: true,
      builder: (_) {
        return SlidingSheetDialog(
          controller: _sheetController,
          elevation: 8,
          cornerRadius: 16,
          duration: 500.milliseconds,
          color: context.backgroundColor,
          snapSpec: const SnapSpec(
            initialSnap: 0.5,
            snappings: [0.5, 0.89],
            positioning: SnapPositioning.relativeToSheetHeight,
          ),
          minHeight: context.height - 56,
          liftOnScrollHeaderElevation: 6,
          headerBuilder: (_, __) => _headerWidget ??= EditTaskHeader(
            // key: Key('${_id}_header'),
            taskID: _id,
            colorID: _colorID ?? widget.projectColor,
            getEditView: _openEditView,
          ),
          builder: (_, __) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<TaskBloc>.value(
                  value: BlocProvider.of<TaskBloc>(context),
                ),
                BlocProvider<SubtaskCubit>.value(
                  value: BlocProvider.of<SubtaskCubit>(context),
                ),
              ],
              child: DetailTaskView(
                key: Key('${_id}_detail'),
                task: _currentTask,
                taskID: widget.entry?.id,
                colorID: _colorID ?? widget.projectColor,
              ),
            );
          },
        );
      },
    );
    // context.read<TaskBloc>().add(
    //       GetTaskEntriesEvent(
    //         project: ProjectEntry(id: _currentTask!.projectID),
    //       ),
    //     );
  }

  void _openEditView() async {
    print('Open Edit');
    // await _sheetController.hide();

    final _result = await showCupertinoModalBottomSheet<TaskEntry?>(
      elevation: 24,
      useRootNavigator: true,
      expand: true,
      context: context,
      topRadius: const Radius.circular(16),
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider<TaskBloc>.value(
            value: BlocProvider.of<TaskBloc>(context),
          ),
          BlocProvider<SubtaskCubit>.value(
            value: BlocProvider.of<SubtaskCubit>(context),
          ),
        ],
        child: EditTaskView(
          key: Key(_id),
          taskID: _id,
          task: _currentTask,
          colorID: _colorID ?? widget.projectColor,
          modalScrollController: ModalScrollController.of(context),
        ),
      ),
    );

    // print(_result);
    if (_result != null) {
      setState(() {
        _currentTask = _result;
        _taskSheetDialog = null;
        _cellContentContainer = null;
        _id = _result.id;
        _dueDateTime = _result.dueDate;
        _startDateTime = _result.startDateTime;
        _endDateTime = _result.endDateTime;
        _title = _result.title;
        _colorID = _result.colorID;
        _isCompleted = _result.isCompleted;
      });

      _sheetController.rebuild();
    }
  }

  Color getColor(Set<MaterialState> states) {
    const interactiveStates = <MaterialState>{
      MaterialState.selected,
      MaterialState.hovered,
      MaterialState.focused,
      // MaterialState.disabled,
    };
    if (states.any(interactiveStates.contains)) {
      return kcPrimary500;
    }
    return Colors.grey;
  }
}

class LinePainter extends CustomPainter {
  LinePainter(this.color);

  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final path = Path();
    path.moveTo(4, -2);
    path.lineTo(4, size.height + 2.5);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
