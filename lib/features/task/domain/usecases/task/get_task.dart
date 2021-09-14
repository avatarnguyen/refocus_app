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
    if (params.project != null) {
      return repository.getTaskOfSpecificProject(params.project!);
    } else {
      return repository.getFilteredTask(
          dueDate: params.dueDate, startDate: params.startDate);
    }
  }
}
