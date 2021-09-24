import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:dartx/dartx.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/models/ModelProvider.dart';

abstract class TaskRemoteDataSource {
  Future<void> createOrUpdateRemoteProject(Project project);
  Future<void> deleteRemoteProject(Project project);
  Future<List<Project>> getRemoteProject();

  Future<void> createOrUpdateRemoteTask(Todo task);
  Future<void> deleteRemoteTask(Todo task);
  Future<List<Todo>> getRemoteTask({
    String? todoID,
    Project? project,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? dueDate,
  });
}

@LazySingleton(as: TaskRemoteDataSource)
class AWSTaskRemoteDataSource implements TaskRemoteDataSource {
  final log = logger(AWSTaskRemoteDataSource);

  @override
  Future<void> createOrUpdateRemoteProject(Project project) async {
    try {
      await Amplify.DataStore.save(project);
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> createOrUpdateRemoteTask(Todo task) async {
    try {
      await Amplify.DataStore.save(task);
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> deleteRemoteProject(Project project) async {
    try {
      (await Amplify.DataStore.query(Todo.classType,
              where: Todo.PROJECTID.eq(project.id)))
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
  Future<void> deleteRemoteTask(Todo task) async {
    try {
      await Amplify.DataStore.delete(task);
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  @override
  Future<List<Project>> getRemoteProject() async {
    try {
      final projects = await Amplify.DataStore.query(Project.classType);
      return projects;
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  @override
  Future<List<Todo>> getRemoteTask(
      {String? todoID,
      Project? project,
      DateTime? startTime,
      DateTime? endTime,
      DateTime? dueDate}) async {
    var _todos = <Todo>[];

    try {
      if (todoID != null) {
        _todos = await Amplify.DataStore.query(
          Todo.classType,
          where: Todo.ID.eq(todoID),
        );
      } else if (project != null) {
        log.d(project);
        log.v('Project ID: ${project.getId()}');

        _todos = await Amplify.DataStore.query(
          Todo.classType,
          where: Todo.PROJECTID.eq(project.getId()),
        );
      } else if (startTime != null && endTime != null) {
        log.i('Get AWS Task by Time Range until: $endTime');

        final _fetchedTodos = await Amplify.DataStore.query(
          Todo.classType,
          where: Todo.ISCOMPLETED.eq(false),
        );

        final _filteredTodos = <Todo>[];

        for (final _todo in _fetchedTodos) {
          if (_todo.dueDate != null) {
            final _tmpDueDate = _todo.dueDate;
            final _dueDateUtc = _tmpDueDate!.getDateTime();

            if (_dueDateUtc.isBefore(endTime) &&
                _dueDateUtc.isAfter(startTime)) {
              _filteredTodos.add(_todo);
            }
          } else if (_todo.startDateTime != null) {
            final _tmpStartDateTime = _todo.startDateTime!;
            final _startUtc = _tmpStartDateTime.getDateTimeInUtc();

            if (_startUtc.isBefore(endTime) && _startUtc.isAfter(startTime)) {
              _filteredTodos.add(_todo);
            }
          } else {
            continue;
          }
        }

        _todos.addAll(_filteredTodos);
      } else {
        //Amplify DataStore cannot query AWSDateTime
        //Therefore the list has to be filtered manually
        final _fetchedTodos = await Amplify.DataStore.query(
          Todo.classType,
          where: Todo.ISCOMPLETED.eq(false),
        );
        if (dueDate != null) {
          log.i('Get AWS Task with DueDate: $dueDate');
          final _startDate = TemporalDate(dueDate);

          final _filteredTodos = _fetchedTodos
              .where((todo) => todo.dueDate == _startDate)
              .toList();
          _todos.addAll(_filteredTodos);
        }
        if (startTime != null) {
          log.i('Get AWS Task by Start Time: $startTime');

          final _filteredTodos = <Todo>[];

          for (final _todo in _fetchedTodos) {
            if (_todo.startDateTime != null) {
              final _tmpDateTime = _todo.startDateTime!;
              final _dateTimeUtc = _tmpDateTime.getDateTimeInUtc();
              if (startTime.isAtSameDayAs(_dateTimeUtc) &&
                  startTime.isAtSameMonthAs(_dateTimeUtc) &&
                  startTime.isAtSameYearAs(_dateTimeUtc)) {
                _filteredTodos.add(_todo);
              }
            }
          }
          _todos.addAll(_filteredTodos);
        }
      }
      return _todos;
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }
}
