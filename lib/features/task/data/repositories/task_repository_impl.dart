import 'package:dartz/dartz.dart' as dartz;
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/exceptions.dart';

import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/features/task/data/datasources/aws_data_source.dart';
import 'package:refocus_app/features/task/data/datasources/task_local_data_source.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/repositories/task_repository.dart';
import 'package:refocus_app/models/ModelProvider.dart';

@LazySingleton(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final TaskRemoteDataSource remoteDataSource;
  final TaskLocalDataSource localDataSource;
  final log = logger(TaskRepositoryImpl);

  @override
  Future<dartz.Either<Failure, ProjectEntry>> createProject(
      ProjectEntry project) async {
    try {
      final newProject = Project.fromJson(project.toMap());
      log.i('Create Project: ${newProject.toJson()}');

      await remoteDataSource.createOrUpdateRemoteProject(newProject);
      return dartz.Right(ProjectEntry.fromMap(newProject.toJson()));
    } on ServerException {
      return dartz.Left(ServerFailure());
    }
  }

  @override
  Future<dartz.Either<Failure, dartz.Unit>> createTasks(
      List<TaskEntry> tasks) async {
    try {
      for (final task in tasks) {
        // log.i('Task: ${task.toJson()}');
        final _todo = Task.fromJson(task.toJson());
        log.i('Created Task: ${_todo.toJson()}');

        await remoteDataSource.createOrUpdateRemoteTask(_todo);
      }

      return const dartz.Right(dartz.unit);
    } on ServerException {
      return dartz.Left(ServerFailure());
    }
  }

  @override
  Future<dartz.Either<Failure, dartz.Unit>> deleteProject(
      ProjectEntry project) async {
    try {
      final _project = Project.fromJson(project.toMap());

      log.i('Delete Project: ${_project.toJson()}');

      await remoteDataSource.deleteRemoteProject(_project);

      return const dartz.Right(dartz.unit);
    } on ServerException {
      return dartz.Left(ServerFailure());
    }
  }

  @override
  Future<dartz.Either<Failure, dartz.Unit>> deleteTask(TaskEntry task) async {
    try {
      final _todo = Task.fromJson(task.toJson());

      log.i('Delete Project: ${_todo.toJson()}');

      await remoteDataSource.deleteRemoteTask(_todo);

      return const dartz.Right(dartz.unit);
    } on ServerException {
      return dartz.Left(ServerFailure());
    }
  }

  @override
  Future<dartz.Either<Failure, List<ProjectEntry>>> getAllProjects() async {
    try {
      final _projects = await remoteDataSource.getRemoteProject();
      log.v('Fetched Projects Count: ${_projects.length}');

      final _projectsEntry = _projects
          .map((project) => ProjectEntry.fromMap(project.toJson()))
          .toList();

      //Cache Color of Projects to add to task locally
      await localDataSource.cacheRemoteProjectColors(_projects);

      return dartz.Right(_projectsEntry);
    } on ServerException {
      return dartz.Left(ServerFailure());
    }
  }

  @override
  Future<dartz.Either<Failure, List<TaskEntry>>> getTaskOfSpecificProject(
      ProjectEntry project) async {
    try {
      final _project = Project.fromJson(project.toMap());
      log.v('${_project.toJson()}');

      final _todos = await remoteDataSource.getRemoteTask(
        project: _project,
      );
      log.v('Task: $_todos');

      final _tasks = _todos
          .map((todo) => TaskEntry.fromJson(
                todo.toJson(),
              ))
          .toList();
      // log.d('Tasks: $_tasks');
      return dartz.Right(_tasks);
    } on ServerException catch (e) {
      log.e(e);
      return dartz.Left(ServerFailure());
    }
  }

  @override
  Future<dartz.Either<Failure, ProjectEntry>> updateProject(
      ProjectEntry project) async {
    try {
      final _project = Project.fromJson(project.toMap());
      log.v('${_project.toJson()}');
      await remoteDataSource.createOrUpdateRemoteProject(_project);

      return dartz.Right(project);
    } on ServerException {
      return dartz.Left(ServerFailure());
    }
  }

  @override
  Future<dartz.Either<Failure, TaskEntry>> updateTask(
      TaskEntry? task, String? taskID) async {
    try {
      if (task != null) {
        final _todo = Task.fromJson(task.toJson());
        log.v('${_todo.toJson()}');
        await remoteDataSource.createOrUpdateRemoteTask(_todo);
        return dartz.Right(task);
      } else if (taskID != null) {
        final _task = await remoteDataSource.getRemoteTask(todoID: taskID);
        final _updatedTask =
            _task.first.copyWith(isCompleted: !_task.first.isCompleted);

        await remoteDataSource.createOrUpdateRemoteTask(_updatedTask);
        return dartz.Right(TaskEntry.fromJson(_updatedTask.toJson()));
      } else {
        return dartz.Left(ArgumentFailure());
      }
    } on ServerException {
      return dartz.Left(ServerFailure());
    }
  }

  @override
  Future<dartz.Either<Failure, List<TaskEntry>>> getFilteredTask({
    String? taskID,
    DateTime? dueDate,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final _todos = await remoteDataSource.getRemoteTask(
        todoID: taskID,
        startTime: startDate,
        dueDate: dueDate,
        endTime: endDate,
      );
      log.v('getFilteredTask - Task: $_todos');

      final _tasks = <TaskEntry>[];

      await Future.forEach(_todos, (Task todo) async {
        final _projectColor = await localDataSource
            .getCachedProjectColorWithID(todo.projectID ?? '');
        log.d('Project Color: $_projectColor');

        final _tmpTask = TaskEntry.fromJson(todo.toJson());
        final _task = _tmpTask.copyWith(colorID: _projectColor ?? '#115FFB');
        log.d('Task Color: ${_task.colorID}');
        _tasks.add(_task);
      });
      return dartz.Right(_tasks);
    } on ServerException catch (e) {
      log.e(e);
      return dartz.Left(ServerFailure());
    }
  }
}
