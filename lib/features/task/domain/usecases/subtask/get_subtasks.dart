import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/domain/repositories/task_repository.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/subtask_params.dart';

@lazySingleton
class GetSubTasks implements UseCase<List<SubTaskEntry>, SubTaskParams> {
  GetSubTasks(this.repository);

  final TaskRepository repository;

  @override
  Future<Either<Failure, List<SubTaskEntry>>> call(SubTaskParams params) async {
    if (params.taskID != null) {
      return repository.getSubTasksOfTask(params.taskID!);
    } else {
      return Left(ArgumentFailure());
    }
  }
}
