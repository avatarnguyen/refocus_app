import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/exceptions.dart';

import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/features/task/data/datasources/aws_data_source.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/repositories/task_repository.dart';
import 'package:refocus_app/models/ModelProvider.dart';

@LazySingleton(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl({
    required this.remoteDataSource,
  });

  final TaskRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, ProjectEntry>> createProject(
      ProjectEntry project) async {
    final log = logger(TaskRepositoryImpl);

    try {
      final newProject = Project.fromJson(project.toMap());
      log.i('Create Project: ${newProject.toJson()}');

      await remoteDataSource.createOrUpdateRemoteProject(newProject);
      return Right(ProjectEntry.fromMap(newProject.toJson()));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> createTasks(List<TaskEntry> tasks) async {
    final log = logger(TaskRepositoryImpl);
    try {
      for (final task in tasks) {
        // log.i('Task: ${task.toJson()}');
        final _todo = Todo.fromJson(task.toJson());
        log.i('Created Todo: ${_todo.toJson()}');

        await remoteDataSource.createOrUpdateRemoteTask(_todo);
      }

      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProject(ProjectEntry project) async {
    final log = logger(TaskRepositoryImpl);

    try {
      final _project = Project.fromJson(project.toMap());

      log.i('Delete Project: ${_project.toJson()}');

      await remoteDataSource.deleteRemoteProject(_project);

      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(TaskEntry task) async {
    final log = logger(TaskRepositoryImpl);

    try {
      final _todo = Todo.fromJson(task.toJson());

      log.i('Delete Project: ${_todo.toJson()}');

      await remoteDataSource.deleteRemoteTask(_todo);

      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProjectEntry>>> getAllProjects() async {
    final log = logger(TaskRepositoryImpl);

    try {
      final _projects = await remoteDataSource.getRemoteProject();
      log.v('Fetched Projects Count: ${_projects.length}');

      final _projectsEntry = _projects
          .map((project) => ProjectEntry.fromMap(project.toJson()))
          .toList();

      return Right(_projectsEntry);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<TaskEntry>>> getTaskOfSpecificProject(
      ProjectEntry project) async {
    final log = logger(TaskRepositoryImpl);

    try {
      final _project = Project.fromJson(project.toMap());
      log.v('${_project.toJson()}');

      final _todos = await remoteDataSource.getRemoteTask(
        project: _project,
      );
      log.v('Todo: $_todos');

      final _tasks = _todos
          .map((todo) => TaskEntry.fromJson(
                todo.toJson(),
              ))
          .toList();
      // log.d('Tasks: $_tasks');
      return Right(_tasks);
    } on ServerException catch (e) {
      log.e(e);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ProjectEntry>> updateProject(
      ProjectEntry project) async {
    final log = logger(TaskRepositoryImpl);

    try {
      final _project = Project.fromJson(project.toMap());
      log.v('${_project.toJson()}');
      await remoteDataSource.createOrUpdateRemoteProject(_project);

      return Right(project);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, TaskEntry>> updateTask(TaskEntry task) async {
    final log = logger(TaskRepositoryImpl);

    try {
      final _todo = Todo.fromJson(task.toJson());
      log.v('${_todo.toJson()}');
      await remoteDataSource.createOrUpdateRemoteTask(_todo);

      return Right(task);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
