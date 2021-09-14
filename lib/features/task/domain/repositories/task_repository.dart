import 'package:dartz/dartz.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';

import '../../../../core/error/failures.dart';
import '../entities/project_entry.dart';

abstract class TaskRepository {
  /// Create Project
  Future<Either<Failure, ProjectEntry>> createProject(ProjectEntry project);

  /// Update Project
  Future<Either<Failure, ProjectEntry>> updateProject(ProjectEntry project);

  /// Delete Project and all its tasks
  Future<Either<Failure, Unit>> deleteProject(ProjectEntry project);

  /// Query All Projects
  Future<Either<Failure, List<ProjectEntry>>> getAllProjects();

  /// Create Task
  Future<Either<Failure, Unit>> createTasks(List<TaskEntry> tasks);

  /// Update Task
  Future<Either<Failure, TaskEntry>> updateTask(TaskEntry task);

  /// Delete Task
  Future<Either<Failure, Unit>> deleteTask(TaskEntry task);

  /// Query Task Of Specific Project
  Future<Either<Failure, List<TaskEntry>>> getTaskOfSpecificProject(
      ProjectEntry project);

  /// Query Task With Given Attribute
  Future<Either<Failure, List<TaskEntry>>> getFilteredTask(
      {DateTime? dueDate, DateTime? startDate});
}
