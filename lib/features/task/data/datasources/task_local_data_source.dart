import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/exceptions.dart';

import 'package:refocus_app/models/ModelProvider.dart';

abstract class TaskLocalDataSource {
  Future<String?> getCachedProjectColorWithID(String projectID);
  Future<void> cacheRemoteProjectColors(List<Project> projects);
}

const cachedProjectsColor = 'CACHED_PROJECS_COLOR';

@LazySingleton(as: TaskLocalDataSource)
class HiveTaskLocalDataSource implements TaskLocalDataSource {
  HiveTaskLocalDataSource({
    required this.projectColorBox,
  });

  final Box<String> projectColorBox;

  @override
  Future<void> cacheRemoteProjectColors(List<Project> projects) async {
    try {
      await Future.forEach(projects, (Project project) {
        projectColorBox.put(
          project.id,
          project.color ?? '#115FFB',
        );
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
      throw CacheException();
    }
  }

  @override
  Future<String?> getCachedProjectColorWithID(String projectID) async {
    return projectColorBox.get(projectID);
  }
}
