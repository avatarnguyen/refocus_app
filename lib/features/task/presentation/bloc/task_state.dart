part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {
  @override
  List<Object?> get props => [];
}

class TaskError extends TaskState {
  const TaskError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class TasksLoaded extends TaskState {
  const TasksLoaded({
    this.project,
    required this.tasks,
  });

  final ProjectEntry? project;
  final List<TaskEntry> tasks;

  @override
  List<Object?> get props => [project, tasks];
}
