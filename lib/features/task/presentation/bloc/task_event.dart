part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class GetTaskEntriesEvent extends TaskEvent {
  const GetTaskEntriesEvent({
    required this.project,
  });

  final ProjectEntry project;
  @override
  List<Object?> get props => [project];
}

class GetSingleTaskEntryEvent extends TaskEvent {
  const GetSingleTaskEntryEvent({
    required this.taskID,
  });

  final String taskID;
  @override
  List<Object?> get props => [taskID];
}

class CreateTaskEntriesEvent extends TaskEvent {
  const CreateTaskEntriesEvent({
    required this.params,
  });

  final List<TaskParams> params;
  @override
  List<Object?> get props => [params];
}

class EditTaskEntryEvent extends TaskEvent {
  const EditTaskEntryEvent({
    required this.params,
  });

  final TaskParams params;
  @override
  List<Object?> get props => [params];
}

class DeleteTaskEntryEvent extends TaskEvent {
  const DeleteTaskEntryEvent({
    required this.params,
  });

  final TaskParams params;
  @override
  List<Object?> get props => [params];
}
