import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/repositories/task_repository.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/project_params.dart';

@lazySingleton
class CreateProject implements UseCase<ProjectEntry, ProjectParams> {
  CreateProject(this.repository);

  final TaskRepository repository;

  @override
  Future<Either<Failure, ProjectEntry>> call(ProjectParams params) async {
    return await repository.createProject(params.project);
  }
}
