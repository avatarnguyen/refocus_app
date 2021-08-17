import 'package:dartz/dartz.dart';
import 'package:refocus_app/core/error/exceptions.dart';

import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/network/network_info.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/features/task/data/datasources/aws_data_source.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/repositories/task_repository.dart';
import 'package:refocus_app/models/ModelProvider.dart';

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
  Future<Either<Failure, TaskEntry>> createTask(
      ProjectEntry project, TaskEntry task) {
    final log = logger(TaskRepositoryImpl);

    // try {
    //   final newProject = Project.fromJson(project.toMap());
    //   log.i('Create Project: ${newProject.toJson()}');

    //   await remoteDataSource.createOrUpdateRemoteTask(task);
    //   return Right(ProjectEntry.fromMap(newProject.toJson()));
    // } on ServerException {
    //   return Left(ServerFailure());
    // }
  }

  @override
  Future<Either<Failure, Unit>> deleteProject(ProjectEntry project) {
    // TODO: implement deleteProject
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(TaskEntry task) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProjectEntry>>> getAllProjects() {
    // TODO: implement getAllProjects
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TaskEntry>>> getTaskOfSpecificProject(
      ProjectEntry project) {
    // TODO: implement getTaskOfSpecificProject
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ProjectEntry>> updateProject(ProjectEntry project) {
    // TODO: implement updateProject
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TaskEntry>> updateTask(TaskEntry task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
