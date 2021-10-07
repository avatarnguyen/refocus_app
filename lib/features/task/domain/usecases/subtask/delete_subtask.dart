import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/task/domain/repositories/task_repository.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/subtask_params.dart';

@lazySingleton
class DeleteSubTask implements UseCase<Unit, SubTaskParams> {
  DeleteSubTask(this.repository);

  final TaskRepository repository;

  @override
  Future<Either<Failure, Unit>> call(SubTaskParams params) async {
    if (params.subTaskEntry != null) {
      return repository.deleteSubTask(params.subTaskEntry!);
    } else {
      return Left(ArgumentFailure());
    }
  }
}
