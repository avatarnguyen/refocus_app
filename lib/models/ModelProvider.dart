/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'Project.dart';
import 'Subtask.dart';
import 'Task.dart';
import 'User.dart';

export 'Project.dart';
export 'Subtask.dart';
export 'Task.dart';
export 'User.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "2e4cde317a9bf54fa3cf294071097358";
  @override
  List<ModelSchema> modelSchemas = [Project.schema, Subtask.schema, Task.schema, User.schema];
  static final ModelProvider _instance = ModelProvider();

  static ModelProvider get instance => _instance;
  
  ModelType getModelTypeByModelName(String modelName) {
    switch(modelName) {
    case "Project": {
    return Project.classType;
    }
    break;
    case "Subtask": {
    return Subtask.classType;
    }
    break;
    case "Task": {
    return Task.classType;
    }
    break;
    case "User": {
    return User.classType;
    }
    break;
    default: {
    throw Exception("Failed to find model in model provider for model name: " + modelName);
    }
    }
  }
}