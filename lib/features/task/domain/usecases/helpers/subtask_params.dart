import 'package:equatable/equatable.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';

class SubTaskParams extends Equatable {
  const SubTaskParams({
    this.subTaskEntry,
    this.taskID,
  });

  final SubTaskEntry? subTaskEntry;
  final String? taskID;

  @override
  List<Object?> get props => [subTaskEntry, taskID];
}
