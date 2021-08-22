part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class GetProjectEntriesEvent extends TaskEvent {
  @override
  List<Object?> get props => [];
}

class CreateProjectEntriesEvent extends TaskEvent {
  const CreateProjectEntriesEvent(this.params);

  final ProjectParams params;

  @override
  List<Object?> get props => [params];
}
