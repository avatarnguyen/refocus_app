import 'package:amplify_flutter/amplify.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/models/ModelProvider.dart';

@lazySingleton
class AwsStream {
  Stream get getTaskStream => Amplify.DataStore.observe(Todo.classType);
  Stream get getProjectStream => Amplify.DataStore.observe(Project.classType);
}
