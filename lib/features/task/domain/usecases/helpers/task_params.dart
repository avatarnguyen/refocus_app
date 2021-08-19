import 'package:equatable/equatable.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';

class TaskParams extends Equatable {
  const TaskParams({required this.task, this.project});

  final ProjectEntry? project;
  final TaskEntry task;

  @override
  List<Object?> get props => [project, task];
}
