part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class GetProjectEntriesEvent extends TaskEvent {
  @override
  List<Object?> get props => [];
}
