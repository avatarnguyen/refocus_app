import 'package:equatable/equatable.dart';

import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';

class TaskParams extends Equatable {
  const TaskParams({
    this.project,
    this.task,
    this.taskID,
    this.dueDate,
    this.startDate,
    this.endDate,
  });

  final ProjectEntry? project;
  final TaskEntry? task;
  final String? taskID;
  final DateTime? dueDate;
  final DateTime? startDate;
  final DateTime? endDate;

  @override
  List<Object?> get props =>
      [project, task, taskID, dueDate, startDate, endDate];
}
