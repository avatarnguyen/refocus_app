import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/repositories/task_repository.dart';

@lazySingleton
class GetProjects implements UseCase<List<ProjectEntry>, NoParams> {
  GetProjects(this.repository);

  final TaskRepository repository;

  @override
  Future<Either<Failure, List<ProjectEntry>>> call(NoParams params) async {
    return await repository.getAllProjects();
  }
}
