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
