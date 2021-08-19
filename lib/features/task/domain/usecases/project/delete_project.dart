import 'package:refocus_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/task/domain/repositories/task_repository.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/project_params.dart';

class DeleteProject implements UseCase<Unit, ProjectParams> {
  DeleteProject(this.repository);

  final TaskRepository repository;

  @override
  Future<Either<Failure, Unit>> call(ProjectParams params) async {
    return await repository.deleteProject(params.project);
  }
}
