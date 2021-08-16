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
  final List<Todo>? _Todos;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get title {
    return _title;
  }
  
  List<Todo>? get Todos {
    return _Todos;
  }
  
  const Project._internal({required this.id, title, Todos}): _title = title, _Todos = Todos;
  
  factory Project({String? id, String? title, List<Todo>? Todos}) {
    return Project._internal(
      id: id == null ? UUID.getUUID() : id,
      title: title,
      Todos: Todos != null ? List<Todo>.unmodifiable(Todos) : Todos);
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
      DeepCollectionEquality().equals(_Todos, other._Todos);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Project {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$_title");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Project copyWith({String? id, String? title, List<Todo>? Todos}) {
    return Project(
      id: id ?? this.id,
      title: title ?? this.title,
      Todos: Todos ?? this.Todos);
  }
  
  Project.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _title = json['title'],
      _Todos = json['Todos'] is List
        ? (json['Todos'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Todo.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'title': _title, 'Todos': _Todos?.map((e) => e?.toJson())?.toList()
  };

  static final QueryField ID = QueryField(fieldName: "project.id");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField TODOS = QueryField(
    fieldName: "Todos",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Todo).toString()));
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Project.TODOS,
      isRequired: false,
      ofModelName: (Todo).toString(),
      associatedKey: Todo.PROJECTID
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