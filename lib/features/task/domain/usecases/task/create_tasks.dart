import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/repositories/task_repository.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';

@lazySingleton
class CreateTasks implements UseCase<Unit, List<TaskParams>> {
  CreateTasks(this.repository);

  final TaskRepository repository;

  @override
  Future<Either<Failure, Unit>> call(List<TaskParams> paramsList) async {
    final _taskEntries = <TaskEntry>[];

    await Future.forEach(
        paramsList, (TaskParams params) => _taskEntries.add(params.task!));
    return repository.createTasks(_taskEntries);
  }
}
