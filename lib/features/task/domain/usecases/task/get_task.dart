import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/repositories/task_repository.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';

@lazySingleton
class GetTasks implements UseCase<List<TaskEntry>, TaskParams> {
  GetTasks(this.repository);

  final TaskRepository repository;

  @override
  Future<Either<Failure, List<TaskEntry>>> call(TaskParams params) async {
    if (params.taskID != null) {
      return repository.getFilteredTask(taskID: params.taskID);
    } else if (params.project != null) {
      return repository.getTaskOfSpecificProject(params.project!);
    } else if (params.endDate != null) {
      //? Get Task between a certain range
      //(1 use case: getting upcoming task in today bloc)
      return repository.getFilteredTask(
          startDate: params.startDate, endDate: params.endDate);
    } else {
      //? Get Task that either due or start with given datetime
      return repository.getFilteredTask(
          dueDate: params.dueDate, startDate: params.startDate);
    }
  }
}
