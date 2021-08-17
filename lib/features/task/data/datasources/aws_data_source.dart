import 'package:amplify_flutter/amplify.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/models/ModelProvider.dart';

abstract class TaskRemoteDataSource {
  Future<void> createOrUpdateRemoteProject(Project project);
  Future<void> deleteRemoteProject(Project project);
  Future<List<Project>> getRemoteProject();

  Future<void> createOrUpdateRemoteTask(Todo task);
  Future<void> deleteRemoteTask(Todo task);
  Future<List<Todo>> getRemoteTask(Project project);
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
    try {} catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<void> deleteRemoteProject(Project project) async {
    try {} catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<void> deleteRemoteTask(Todo task) async {
    try {} catch (e) {
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
  Future<List<Todo>> getRemoteTask(Project project) async {
    try {
      final todos = await Amplify.DataStore.query(
        Todo.classType,
        where: Todo.PROJECTID.eq(project.id),
      );
      return todos;
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
