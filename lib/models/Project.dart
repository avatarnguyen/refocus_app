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

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Project type in your schema. */
@immutable
class Project extends Model {
  static const classType = const _ProjectModelType();
  final String id;
  final String? _title;
  final String? _color;
  final String? _emoji;
  final List<Task>? _Tasks;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get title {
    return _title;
  }
  
  String? get color {
    return _color;
  }
  
  String? get emoji {
    return _emoji;
  }
  
  List<Task>? get Tasks {
    return _Tasks;
  }
  
  const Project._internal({required this.id, title, color, emoji, Tasks}): _title = title, _color = color, _emoji = emoji, _Tasks = Tasks;
  
  factory Project({String? id, String? title, String? color, String? emoji, List<Task>? Tasks}) {
    return Project._internal(
      id: id == null ? UUID.getUUID() : id,
      title: title,
      color: color,
      emoji: emoji,
      Tasks: Tasks != null ? List<Task>.unmodifiable(Tasks) : Tasks);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Project &&
      id == other.id &&
      _title == other._title &&
      _color == other._color &&
      _emoji == other._emoji &&
      DeepCollectionEquality().equals(_Tasks, other._Tasks);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Project {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("color=" + "$_color" + ", ");
    buffer.write("emoji=" + "$_emoji");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Project copyWith({String? id, String? title, String? color, String? emoji, List<Task>? Tasks}) {
    return Project(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      emoji: emoji ?? this.emoji,
      Tasks: Tasks ?? this.Tasks);
  }
  
  Project.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _title = json['title'],
      _color = json['color'],
      _emoji = json['emoji'],
      _Tasks = json['Tasks'] is List
        ? (json['Tasks'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Task.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'title': _title, 'color': _color, 'emoji': _emoji, 'Tasks': _Tasks?.map((e) => e?.toJson())?.toList()
  };

  static final QueryField ID = QueryField(fieldName: "project.id");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField COLOR = QueryField(fieldName: "color");
  static final QueryField EMOJI = QueryField(fieldName: "emoji");
  static final QueryField TASKS = QueryField(
    fieldName: "Tasks",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Task).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Project";
    modelSchemaDefinition.pluralName = "Projects";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Project.TITLE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Project.COLOR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Project.EMOJI,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Project.TASKS,
      isRequired: false,
      ofModelName: (Task).toString(),
      associatedKey: Task.PROJECTID
    ));
  });
}

class _ProjectModelType extends ModelType<Project> {
  const _ProjectModelType();
  
  @override
  Project fromJson(Map<String, dynamic> jsonData) {
    return Project.fromJson(jsonData);
  }
}