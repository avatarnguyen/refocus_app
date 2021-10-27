import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/task/domain/repositories/task_repository.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';

@lazySingleton
class DeleteTask implements UseCase<Unit, TaskParams> {
  DeleteTask(this.repository);

  final TaskRepository repository;

  @override
  Future<Either<Failure, Unit>> call(TaskParams params) async {
    if (params.task != null) {
      return repository.deleteTask(params.task!);
    } else {
      return Left(ArgumentFailure());
    }
  }
}
