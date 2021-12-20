import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/models/ModelProvider.dart';

abstract class TaskRemoteDataSource {
  //* Project
  Future<void> createOrUpdateRemoteProject(Project project);
  Future<void> deleteRemoteProject(Project project);

  /// Get All Project from AWS
  Future<List<Project>> getRemoteProject();

  //* Task
  Future<void> createOrUpdateRemoteTask(Task task);
  Future<void> deleteRemoteTask(Task task);

  /// Get Task from AWS with different option
  Future<List<Task>> getRemoteTask({
    String? todoID,
    Project? project,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? dueDate,
  });

  //* Subtask
  Future<void> createOrUpdateRemoteSubTask(Subtask subtask);
  Future<void> deleteRemoteSubTask(Subtask subtask);

  /// Get All SubTask with given Task ID
  Future<List<Subtask>> getRemoteSubTask(String taskID);
}

@LazySingleton(as: TaskRemoteDataSource)
class AWSTaskRemoteDataSource implements TaskRemoteDataSource {
  final log = logger(AWSTaskRemoteDataSource);

  //* Project Methods

  @override
  Future<void> createOrUpdateRemoteProject(Project project) async {
    try {
      final _userID = project.userID ?? await _getUserIdFromAttributes();

      await Amplify.DataStore.save(project.copyWith(
        userID: _userID,
      ));
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> deleteRemoteProject(Project project) async {
    try {
      (await Amplify.DataStore.query(Task.classType,
              where: Task.PROJECTID.eq(project.id)))
          // ignore: avoid_function_literals_in_foreach_calls
          .forEach((todo) async => Amplify.DataStore.delete(todo));

      (await Amplify.DataStore.query(Project.classType,
              where: Project.ID.eq(project.id)))
          // ignore: avoid_function_literals_in_foreach_calls
          .forEach((project) async => Amplify.DataStore.delete(project));
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  @override
  Future<List<Project>> getRemoteProject() async {
    try {
      final _userID = await _getUserIdFromAttributes();
      final projects = await Amplify.DataStore.query(
        Project.classType,
        where: Project.USERID.eq(_userID),
      );
      return projects;
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  //* Task Methods

  @override
  Future<void> createOrUpdateRemoteTask(Task task) async {
    try {
      await Amplify.DataStore.save(task);
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> deleteRemoteTask(Task task) async {
    try {
      await Amplify.DataStore.delete(task);
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  @override
  Future<List<Task>> getRemoteTask({
    String? todoID,
    Project? project,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? dueDate,
  }) async {
    var _todos = <Task>[];

    try {
      if (todoID != null) {
        _todos = await Amplify.DataStore.query(
          Task.classType,
          where: Task.ID.eq(todoID),
        );
      } else if (project != null) {
        log.d(project);
        log.v('Project ID: ${project.getId()}');

        _todos = await Amplify.DataStore.query(
          Task.classType,
          where: Task.PROJECTID
              .eq(project.getId())
              .and(Task.ISCOMPLETED.eq(false)),
        );

        log.d('AWS Tasks in project: ${_todos.length}');
      } else if (startTime != null && endTime != null) {
        //? Get Task between a certain time range

        log.i('Get AWS Task by Time Range: from $startTime until $endTime');

        final _startDateTime = CustomDateUtils.getBeginngOfDay(startTime);
        final _endDataTime = CustomDateUtils.getEndOfDay(endTime);
        final _start = TemporalDateTime(_startDateTime);
        final _end = TemporalDateTime(_endDataTime);
        log.i('\nTemporal DateTime: $_start - $_end \n');

        final _fetchedTasksByStartTime = await Amplify.DataStore.query(
          Task.classType,
          where: Task.ISCOMPLETED
              .eq(false)
              .and(Task.STARTDATETIME.gt(_start))
              .and(Task.STARTDATETIME.lt(_end)),
        );
        final _fetchedTasksByDueDate = await Amplify.DataStore.query(
          Task.classType,
          where: Task.ISCOMPLETED
              .eq(false)
              .and(Task.DUEDATE.gt(_start))
              .and(Task.DUEDATE.lt(_end)),
        );

        _todos.addAll(_fetchedTasksByStartTime);
        _todos.addAll(_fetchedTasksByDueDate);
      } else {
        //? Get Task that either due or start with given datetime

        final _startDayDateTime = CustomDateUtils.getBeginngOfDay(
          dueDate ?? startTime ?? DateTime.now(),
        );
        final _endDayDateTime = CustomDateUtils.getEndOfDay(
          dueDate ?? startTime ?? DateTime.now(),
        );
        final _startDay = TemporalDateTime(_startDayDateTime);
        final _endDay = TemporalDateTime(_endDayDateTime);

        log.i('\nTemporal DateTime: $_startDay - $_endDay \n');
        if (dueDate != null) {
          log.i('Get AWS Task with DueDate: $dueDate');
          final _tasks = await Amplify.DataStore.query(
            Task.classType,
            where: Task.ISCOMPLETED
                .eq(false)
                .and(Task.DUEDATE.gt(_startDay))
                .and(Task.DUEDATE.lt(_endDay)),
          );
          log.d('Resulted Task with DueDate: $_tasks');

          _todos.addAll(_tasks);
        }
        if (startTime != null) {
          log.i('Get AWS Task by Start Time: $startTime');

          final _tasks = await Amplify.DataStore.query(
            Task.classType,
            where: Task.ISCOMPLETED
                .eq(false)
                .and(Task.STARTDATETIME.gt(_startDay))
                .and(Task.STARTDATETIME.lt(_endDay)),
          );
          log.d('Resulted Task with StartTime: $_tasks');
          _todos.addAll(_tasks);
        }
      }
      return _todos;
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  //* Subtask Methods

  @override
  Future<void> createOrUpdateRemoteSubTask(Subtask subtask) async {
    try {
      await Amplify.DataStore.save(subtask);
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> deleteRemoteSubTask(Subtask subtask) async {
    try {
      await Amplify.DataStore.delete(subtask);
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  @override
  Future<List<Subtask>> getRemoteSubTask(String taskID) async {
    try {
      final subtasks = await Amplify.DataStore.query(
        Subtask.classType,
        where: Subtask.TASKID.eq(taskID),
      );
      return subtasks;
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  // Helper Methods

  Future<String> _getUserIdFromAttributes() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();
      final _userId = attributes
          .firstWhere((element) => element.userAttributeKey == 'sub')
          .value as String;
      return _userId;
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }
}
