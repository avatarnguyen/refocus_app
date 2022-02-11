import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:refocus_app/core/core.dart';
import 'package:refocus_app/core/presentation/widgets/edit_page_widgets/detail_event_view.dart';
import 'package:refocus_app/core/presentation/widgets/edit_page_widgets/detail_task_view.dart';
import 'package:refocus_app/core/presentation/widgets/edit_page_widgets/edit_task_header.dart';
import 'package:refocus_app/core/presentation/widgets/edit_page_widgets/edit_task_view.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/enum/today_event_type.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/datetime_stream.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/presentation/bloc/cubit/subtask_cubit.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/features/today/domain/today_entry.dart';
import 'package:refocus_app/features/today/presentation/widgets/sub_task_item.dart';
import 'package:refocus_app/injection.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

const timeLineWidth = 48.0;

class ListItemWidget extends StatefulWidget {
  const ListItemWidget({
    Key? key,
    this.entry,
    this.selectedDate,
    this.task,
    this.project,
    this.deleteItem,
    this.markItemAsDone,
    this.postponeItem,
    this.changeItemDate,
  }) : super(key: key);

  final TodayEntry? entry;
  final TaskEntry? task;
  final DateTime? selectedDate;
  final ProjectEntry? project;
  final VoidCallback? deleteItem;
  final VoidCallback? markItemAsDone;
  final VoidCallback? postponeItem;
  final VoidCallback? changeItemDate;

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
  // late bool _isCompleted;
  List<SubTaskEntry>? _subtasks;
  late TodayEntryType _type;

  TaskEntry? _currentTask;
  TodayEntry? _currentEvent;

  @override
  void initState() {
    super.initState();
    if (widget.entry != null) {
      if (widget.entry!.type != TodayEntryType.task) {
        _currentEvent = widget.entry;
      }
      _id = widget.entry!.id;
      _dueDateTime = widget.entry!.dueDateTime;
      _startDateTime = widget.entry!.startDateTime;
      _endDateTime = widget.entry!.endDateTime;
      _title = widget.entry!.title;
      _colorID = widget.entry!.color;
      _subtasks = widget.entry!.subTaskEntries;
      // _isCompleted = widget.entry?.isCompleted ?? false;
      _type = widget.entry!.type;
    } else if (widget.task != null) {
      // Item come from Task Page
      _currentTask = widget.task;
      _id = widget.task!.id;
      _dueDateTime = widget.task!.dueDate;
      _startDateTime = widget.task!.startDateTime;
      _endDateTime = widget.task!.endDateTime;
      _title = widget.task!.title;
      _colorID = widget.task!.colorID;
      // _isCompleted = widget.task!.isCompleted;
      _type = TodayEntryType.task;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _isEvent = _type == TodayEntryType.event;
    final _isPassed = _endDateTime != null && _endDateTime!.compareTo(DateTime.now()) <= 0;
    final _color = StyleUtils.getColorFromString(_colorID ?? widget.project?.color ?? '#115FFB');
    final _backgroudColor = StyleUtils.lighten(_color, 0.32);
    final _textColor = StyleUtils.darken(_color, 0.2);

    // print('$title Color: ${HSLColor.fromColor(_color).lightness}');

    final _taskTimeTextStyle = context.subtitle2.copyWith(color: _textColor);

    var _startTimeStr = '';
    String? _endTimeStr;
    TodayEventType? _eventBlocType;

    // Time Subtitle String depends on where is display
    // and whether the time is start time or due time
    if (widget.project != null) {
      if (_startDateTime != null) {
        final _startDateTimeStr = CustomDateUtils.returnTime(_startDateTime!.toLocal());
        _startTimeStr = _startDateTimeStr;
        // Get Today Event Type for TodayBloc
        if (_endDateTime != null) {
          final _endTime = _endDateTime!.toLocal();
          _endTimeStr = CustomDateUtils.returnTime(_endTime);
        }
      }
    } else if (widget.selectedDate != null) {
      if (_dueDateTime != null && widget.selectedDate!.day == _dueDateTime!.day) {
        _startTimeStr = 'due today';
        // Get Today Event Type for TodayBloc
        _eventBlocType = _dueDateTime!.isToday
            ? TodayEventType.today
            : _startDateTime!.isTomorrow
                ? TodayEventType.tomorrow
                : TodayEventType.upcoming;
      } else if (_startDateTime != null) {
        final _startDateTimeStr = CustomDateUtils.returnTime(_startDateTime!.toLocal());
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
    if (_dateTimeStream.selectedDate != null && _dateTimeStream.selectedDate!.isToday == false) {
      _eventBlocType = TodayEventType.specificDate;
    }

    return Slidable(
      key: widget.key ?? Key(_id),
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            backgroundColor: Slidable.of(context)?.actionPaneType.value == ActionPaneType.end ? kcSuccess500 : Colors.transparent,
            foregroundColor: Slidable.of(context)?.actionPaneType.value == ActionPaneType.start ? kcPrimary500 : Colors.white,
            label: Slidable.of(context) != null && Slidable.of(context)!.animation.value > 0.96 ? 'Mark as Done' : null,
            icon: Icons.check,
            onPressed: (_) {},
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            icon: Icons.calendar_today_rounded,
            foregroundColor: Slidable.of(context)?.isDismissibleReady == true
                ? _color
                : widget.project != null
                    ? kcError500
                    : kcWarning500,
            backgroundColor: Slidable.of(context)?.isDismissibleReady == true
                ? Colors.transparent
                : widget.project != null
                    ? kcError500
                    : kcWarning500,
            label: Slidable.of(context) != null && Slidable.of(context)!.animation.value >= 0.8 ? 'change date' : null,
            onPressed: (_) {
              if (widget.changeItemDate != null) {
                widget.changeItemDate?.call();
              }
            },
          )
          //     if (widget.project != null)
          // SlidableAction(
          //     icon: Icons.delete,
          //     foregroundColor: step == SlidableRenderingMode.slide
          //         ? kcPrimary500.withOpacity(
          //       animation!.value <= 0.7 ? animation.value + 0.3 : 1.0,
          //     )
          //         : (step == SlidableRenderingMode.dismiss
          //         ? kcPrimary500
          //         : kcError500),
          //     color: step == SlidableRenderingMode.dismiss
          //         ? kcError500
          //         : Colors.transparent,
          //     caption: animation!.value >= 0.8 ? 'delete item' : null,
          //     onTap: () async {
          //       if (widget.deleteItem != null) {
          //         final _result = await _showDeleteAlertDialog();
          //         if (_result) {
          //           widget.deleteItem!();
          //         }
          //       }
          //     },
          //   )
          //  else
          // SlidableAction(
          // icon: Icons.arrow_forward_outlined,
          // foregroundColor: step == SlidableRenderingMode.slide
          // ? kcPrimary500.withOpacity(
          // animation!.value <= 0.7 ? animation.value + 0.3 : 1.0,
          // )
          //     : (step == SlidableRenderingMode.dismiss
          // ? kcPrimary500
          //     : kcError500),
          // color: step == SlidableRenderingMode.dismiss
          // ? kcWarning500
          //     : Colors.transparent,
          // caption: animation!.value >= 0.8 ? 'to next day' : null,
          // onTap: () async {
          // // final state = Slidable.of(context);
          // if (widget.postponeItem != null) {
          // widget.postponeItem?.call();
          // }
          // },
          // );
          // }
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: _textColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        padding: const EdgeInsets.only(left: 8),
        child: Container(
                width: context.width - (8 + 28 + 8), //8 is hori padding
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
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
                        decoration: _isEvent && _isPassed ? TextDecoration.lineThrough : null,
                      ),
                    ).expanded(),
                  ].toRow(),
                  [
                    [
                      Text(
                        _startTimeStr,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        textScaleFactor: context.textScaleFactor,
                        style: _startDateTime != null
                            ? context.textTheme.subtitle2!.copyWith(
                                fontWeight: FontWeight.w700,
                                color: _textColor,
                              )
                            : _taskTimeTextStyle,
                      ),
                      if (_endDateTime != null && _endTimeStr != null) ...[
                        Icon(Icons.arrow_right_alt_rounded, size: 20, color: _textColor).padding(horizontal: 2),
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
                    if (widget.project != null && _dueDateTime != null)
                      Text(
                        'due: ${CustomDateUtils.returnDateAndMonth(_dueDateTime!)}',
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.right,
                        textScaleFactor: context.textScaleFactor,
                        style: _taskTimeTextStyle,
                      ),
                  ].toRow(mainAxisAlignment: (widget.project != null && _dueDateTime != null) ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start),

                  //* Subtask
                  if (!_isEvent && _subtasks != null && _subtasks!.isNotEmpty) ...[
                    verticalSpaceTiny,
                    SubTaskItem(
                      subTask: _subtasks!.first,
                      backgroundColor: _color,
                      type: _eventBlocType,
                    ),
                    if (_subtasks!.length > 1)
                      SubTaskItem(
                        subTask: _subtasks!.second,
                        backgroundColor: _color,
                        type: _eventBlocType,
                      ),
                  ]
                ].toColumn(mainAxisSize: MainAxisSize.min))
            .gestures(onTap: showDetailBottomSheet),
      ).paddingDirectional(horizontal: 4),
    ).padding(horizontal: 6, vertical: 6);
  }

  dynamic showDetailBottomSheet() async {
    Widget? _headerWidget;

    final _isTask = _type == TodayEntryType.task;

    await showSlidingBottomSheet<dynamic>(
      context,
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
            colorID: _colorID ?? widget.project?.color,
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
              child: _isTask
                  ? DetailTaskView(
                      key: Key('${_id}_task_detail_${_currentTask?.title}'),
                      task: _currentTask,
                      taskID: widget.entry?.id,
                      colorID: _colorID ?? widget.project?.color,
                    )
                  : DetailEventView(
                      key: Key('${_id}_event_detail_${_currentEvent?.title}'),
                      event: _currentEvent,
                    ),
            );
          },
        );
      },
    );
  }

  Future<void> _openEditView() async {
    final _isTask = _type == TodayEntryType.task;

    final dynamic _result = await showCupertinoModalBottomSheet<dynamic>(
      useRootNavigator: true,
      expand: true,
      bounce: true,
      context: context,
      topRadius: const Radius.circular(16),
      builder: (_) {
        final _editTaskView = EditTaskView(
          key: Key('edit_$_id'),
          taskID: _id,
          task: _currentTask,
          entry: _isTask ? null : _currentEvent,
          colorID: _colorID ?? widget.project?.color,
          modalScrollController: ModalScrollController.of(context),
        );
        return _isTask
            ? MultiBlocProvider(
                providers: [
                  BlocProvider<CalendarListBloc>.value(
                    value: BlocProvider.of<CalendarListBloc>(context),
                  ),
                  BlocProvider<TaskBloc>.value(
                    value: BlocProvider.of<TaskBloc>(context),
                  ),
                  BlocProvider<SubtaskCubit>.value(
                    value: BlocProvider.of<SubtaskCubit>(context),
                  ),
                ],
                child: _editTaskView,
              )
            : MultiBlocProvider(
                providers: [
                  BlocProvider<CalendarListBloc>.value(
                    value: BlocProvider.of<CalendarListBloc>(context),
                  ),
                  BlocProvider<CalendarBloc>.value(
                    value: BlocProvider.of<CalendarBloc>(context),
                  ),
                ],
                child: _editTaskView,
              );
      },
    );

    if (_result is TaskEntry?) {
      if (_result != null) {
        setState(() {
          _currentTask = _result;
          _id = _result.id;
          _dueDateTime = _result.dueDate;
          _startDateTime = _result.startDateTime;
          _endDateTime = _result.endDateTime;
          _title = _result.title;
          _colorID = _result.colorID;
          // _isCompleted = _result.isCompleted;
        });
        _sheetController.rebuild();
      }
    } else if (_result is CalendarEventEntry) {
      setState(() {
        _currentEvent = _currentEvent!.copyWith(
          title: _result.subject,
          startDateTime: _result.startDateTime,
          endDateTime: _result.endDateTime,
          color: _result.colorId,
          projectOrCalID: _result.calendarId,
        );
        _id = _result.id!;
        _startDateTime = _result.startDateTime;
        _endDateTime = _result.endDateTime;
        _title = _result.subject;
        _colorID = _result.colorId;
      });
      _sheetController.rebuild();
    }
  }

  Future<bool> _showDeleteAlertDialog() async {
    final _result = await showPlatformDialog<bool>(
      context: context,
      builder: (context) {
        return PlatformAlertDialog(
          title: 'Delete Task'.toH5(color: context.colorScheme.primary),
          content: 'Do you want to delete this task permanently?'.toSubtitle1(color: context.colorScheme.primary),
          actions: [
            PlatformButton(
              color: Colors.transparent,
              onPressed: () => context.pop(),
              child: 'Cancel'.toButtonText(color: context.colorScheme.primary),
            ),
            PlatformButton(
              color: Colors.transparent,
              onPressed: () => context.pop(),
              child: 'Delete'.toButtonText(color: context.colorScheme.error),
            ),
          ],
        );
      },
    );
    return _result ?? false;
  }
}
