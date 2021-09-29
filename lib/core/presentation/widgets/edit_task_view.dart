import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:dartx/dartx.dart';

class EditTaskView extends StatefulWidget {
  const EditTaskView({Key? key, required this.taskID}) : super(key: key);

  final String taskID;

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(
          GetSingleTaskEntryEvent(taskID: widget.taskID),
        );
  }

  @override
  Widget build(BuildContext context) {
    final _timeTextStyle = context.bodyText1.copyWith(
      color: kcPrimary100,
    );
    final _dateTextStyle = context.bodyText2.copyWith(
      color: kcPrimary100,
    );

    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TasksLoaded) {
          if (state.tasks.isNotEmpty) {
            final _fetchedTask = state.tasks.first;
            return ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  _fetchedTask.title ?? '',
                  style: context.h3.copyWith(
                    fontWeight: FontWeight.w600,
                    color: kcPrimary100,
                  ),
                ).alignment(Alignment.center),
                verticalSpaceMedium,
                [
                  if (_fetchedTask.startDateTime != null)
                    Text(
                      CustomDateUtils.returnTime(_fetchedTask.startDateTime!),
                      style: _timeTextStyle,
                    ),
                  if (_fetchedTask.endDateTime != null) ...[
                    const Icon(
                      Icons.arrow_right_alt_rounded,
                      color: kcPrimary100,
                    ),
                    Text(
                      CustomDateUtils.returnTime(_fetchedTask.endDateTime!),
                      style: _timeTextStyle,
                    ),
                  ]
                ].toRow().alignment(Alignment.center),
                [
                  if (_fetchedTask.startDateTime != null)
                    Text(
                      CustomDateUtils.returnDateAndMonth(
                          _fetchedTask.startDateTime!),
                      style: _dateTextStyle,
                    ),
                  if (_fetchedTask.endDateTime != null &&
                      !_fetchedTask.endDateTime!
                          .isAtSameDayAs(_fetchedTask.startDateTime!)) ...[
                    const Icon(
                      Icons.arrow_right_alt_rounded,
                      color: kcPrimary100,
                    ),
                    Text(
                      CustomDateUtils.returnDateAndMonth(
                          _fetchedTask.endDateTime!),
                      style: _dateTextStyle,
                    ),
                  ]
                ].toRow(),
              ],
            );
          } else {
            return const MessageDisplay(message: '');
          }
        } else {
          return progressIndicator;
        }
      },
    );
  }
}
