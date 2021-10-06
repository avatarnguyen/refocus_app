import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/exceptions.dart';

import 'package:refocus_app/models/ModelProvider.dart';

abstract class TaskLocalDataSource {
  Future<List<Project>> getLastCachedProjects();
  Future<Project?> getCachedProjectWithID(String projectID);
  Future<void> cacheRemoteProjects(List<Project> projects);
}

const cachedProjects = 'CACHED_PROJECS';

@LazySingleton(as: TaskLocalDataSource)
class HiveTaskLocalDataSource implements TaskLocalDataSource {
  HiveTaskLocalDataSource({
    required this.projectsBox,
  });

  final Box<Project> projectsBox;

  @override
  Future<void> cacheRemoteProjects(List<Project> projects) async {
    try {
      await Future.forEach(projects, (Project project) {
        projectsBox.put(
          project.id,
          project,
        );
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
      throw CacheException();
    }
  }

  @override
  Future<List<Project>> getLastCachedProjects() {
    final projectList = <Project>[];

    for (var i = 0; i < projectsBox.length; i++) {
      final entry = projectsBox.getAt(i);
      if (entry != null) {
        projectList.add(entry);
      }
    }
    return Future.value(projectList);
  }

  @override
  Future<Project?> getCachedProjectWithID(String projectID) async {
    return projectsBox.get(projectID);
  }
}
