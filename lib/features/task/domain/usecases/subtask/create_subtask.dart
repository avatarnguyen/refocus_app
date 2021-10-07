import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/domain/repositories/task_repository.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/subtask_params.dart';

@lazySingleton
class CreateSubTask implements UseCase<SubTaskEntry, SubTaskParams> {
  CreateSubTask(this.repository);

  final TaskRepository repository;

  @override
  Future<Either<Failure, SubTaskEntry>> call(SubTaskParams params) async {
    if (params.subTaskEntry != null) {
      return repository.createSubTask(params.subTaskEntry!);
    } else {
      return Left(ArgumentFailure());
    }
  }
}
