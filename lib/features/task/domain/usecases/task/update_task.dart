import 'package:refocus_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/repositories/task_repository.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';

class UpdateTask implements UseCase<TaskEntry, TaskParams> {
  UpdateTask(this.repository);

  final TaskRepository repository;

  @override
  Future<Either<Failure, TaskEntry>> call(TaskParams params) async {
    return await repository.updateTask(params.task);
  }
}
