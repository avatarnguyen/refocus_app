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

class CreateTaskEntriesEvent extends TaskEvent {
  const CreateTaskEntriesEvent({
    required this.params,
  });

  final List<TaskParams> params;
  @override
  List<Object?> get props => [params];
}
