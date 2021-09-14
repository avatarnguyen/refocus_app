import 'package:equatable/equatable.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';

class TaskParams extends Equatable {
  const TaskParams({this.task, this.dueDate, this.startDate, this.project});

  final ProjectEntry? project;
  final TaskEntry? task;
  final DateTime? dueDate;
  final DateTime? startDate;

  @override
  List<Object?> get props => [project, task, dueDate, startDate];
}
