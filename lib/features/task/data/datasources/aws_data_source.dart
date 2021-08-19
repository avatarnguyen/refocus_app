import 'package:amplify_flutter/amplify.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/models/ModelProvider.dart';

abstract class TaskRemoteDataSource {
  Future<void> createOrUpdateRemoteProject(Project project);
  Future<void> deleteRemoteProject(Project project);
  Future<List<Project>> getRemoteProject();

  Future<void> createOrUpdateRemoteTask(Todo task);
  Future<void> deleteRemoteTask(Todo task);
  Future<List<Todo>> getRemoteTask(
      {Project? project, DateTime? startTime, DateTime? endTime});
}

class AWSRemoteDataSource implements TaskRemoteDataSource {
  @override
  Future<void> createOrUpdateRemoteProject(Project project) async {
    try {
      await Amplify.DataStore.save(project);
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<void> createOrUpdateRemoteTask(Todo task) async {
    try {
      await Amplify.DataStore.save(task);
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<void> deleteRemoteProject(Project project) async {
    try {
      (await Amplify.DataStore.query(Todo.classType,
              where: Todo.PROJECTID.eq(project.id)))
          // ignore: avoid_function_literals_in_foreach_calls
          .forEach((todo) async => await Amplify.DataStore.delete(todo));

      (await Amplify.DataStore.query(Project.classType,
              where: Project.ID.eq(project.id)))
          // ignore: avoid_function_literals_in_foreach_calls
          .forEach((project) async => await Amplify.DataStore.delete(project));
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<void> deleteRemoteTask(Todo task) async {
    try {
      await Amplify.DataStore.delete(task);
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<List<Project>> getRemoteProject() async {
    try {
      final projects = await Amplify.DataStore.query(Project.classType);
      return projects;
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<List<Todo>> getRemoteTask(
      {Project? project, DateTime? startTime, DateTime? endTime}) async {
    var _todos = <Todo>[];
    try {
      if (project != null) {
        _todos = await Amplify.DataStore.query(
          Todo.classType,
          where: Todo.PROJECTID.eq(project.id),
        );
      } else {
        // _todos = await Amplify.DataStore.query(
        //   Todo.classType,
        //   where: Todo
        // );
      }
      return _todos;
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
