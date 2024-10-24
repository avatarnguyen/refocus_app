import 'package:dartz/dartz.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';

abstract class TaskRepository {
  //* Project
  /// Create Project
  Future<Either<Failure, ProjectEntry>> createProject(ProjectEntry project);

  /// Update Project
  Future<Either<Failure, ProjectEntry>> updateProject(ProjectEntry project);

  /// Delete Project and all its tasks
  Future<Either<Failure, Unit>> deleteProject(ProjectEntry project);

  /// Query All Projects
  Future<Either<Failure, List<ProjectEntry>>> getAllProjects();

  //* Task
  /// Create Task
  Future<Either<Failure, Unit>> createTasks(List<TaskEntry> tasks);

  /// Update Task
  Future<Either<Failure, TaskEntry>> updateTask(
      TaskEntry? task, String? taskID);

  /// Delete Task
  Future<Either<Failure, Unit>> deleteTask(TaskEntry task);

  /// Query Task Of Specific Project
  Future<Either<Failure, List<TaskEntry>>> getTaskOfSpecificProject(
      ProjectEntry project);

  /// Query Task With Given Attribute
  Future<Either<Failure, List<TaskEntry>>> getFilteredTask({
    String? taskID,
    DateTime? dueDate,
    DateTime? startDate,
    DateTime? endDate,
  });

  //*Subtask
  /// Create SubTask
  Future<Either<Failure, SubTaskEntry>> createSubTask(
      SubTaskEntry subTaskEntry);

  /// Update SubTask
  Future<Either<Failure, SubTaskEntry>> updateSubTask(
      SubTaskEntry subTaskEntry);

  /// Delete SubTask and all its tasks
  Future<Either<Failure, Unit>> deleteSubTask(SubTaskEntry subTaskEntry);

  /// Query All SubTasks
  Future<Either<Failure, List<SubTaskEntry>>> getSubTasksOfTask(String taskID);
}
