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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Subtask type in your schema. */
@immutable
class Subtask extends Model {
  static const classType = const _SubtaskModelType();
  final String id;
  final String? _title;
  final bool? _isCompleted;
  final TemporalDate? _completedDate;
  final int? _priority;
  final String? _taskID;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get title {
    return _title;
  }
  
  bool get isCompleted {
    try {
      return _isCompleted!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  TemporalDate? get completedDate {
    return _completedDate;
  }
  
  int? get priority {
    return _priority;
  }
  
  String? get taskID {
    return _taskID;
  }
  
  const Subtask._internal({required this.id, title, required isCompleted, completedDate, priority, taskID}): _title = title, _isCompleted = isCompleted, _completedDate = completedDate, _priority = priority, _taskID = taskID;
  
  factory Subtask({String? id, String? title, required bool isCompleted, TemporalDate? completedDate, int? priority, String? taskID}) {
    return Subtask._internal(
      id: id == null ? UUID.getUUID() : id,
      title: title,
      isCompleted: isCompleted,
      completedDate: completedDate,
      priority: priority,
      taskID: taskID);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Subtask &&
      id == other.id &&
      _title == other._title &&
      _isCompleted == other._isCompleted &&
      _completedDate == other._completedDate &&
      _priority == other._priority &&
      _taskID == other._taskID;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Subtask {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("isCompleted=" + (_isCompleted != null ? _isCompleted!.toString() : "null") + ", ");
    buffer.write("completedDate=" + (_completedDate != null ? _completedDate!.format() : "null") + ", ");
    buffer.write("priority=" + (_priority != null ? _priority!.toString() : "null") + ", ");
    buffer.write("taskID=" + "$_taskID");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Subtask copyWith({String? id, String? title, bool? isCompleted, TemporalDate? completedDate, int? priority, String? taskID}) {
    return Subtask(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      completedDate: completedDate ?? this.completedDate,
      priority: priority ?? this.priority,
      taskID: taskID ?? this.taskID);
  }
  
  Subtask.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _title = json['title'],
      _isCompleted = json['isCompleted'],
      _completedDate = json['completedDate'] != null ? TemporalDate.fromString(json['completedDate']) : null,
      _priority = json['priority'],
      _taskID = json['taskID'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'title': _title, 'isCompleted': _isCompleted, 'completedDate': _completedDate?.format(), 'priority': _priority, 'taskID': _taskID
  };

  static final QueryField ID = QueryField(fieldName: "subtask.id");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField ISCOMPLETED = QueryField(fieldName: "isCompleted");
  static final QueryField COMPLETEDDATE = QueryField(fieldName: "completedDate");
  static final QueryField PRIORITY = QueryField(fieldName: "priority");
  static final QueryField TASKID = QueryField(fieldName: "taskID");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Subtask";
    modelSchemaDefinition.pluralName = "Subtasks";
    
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
      key: Subtask.TITLE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Subtask.ISCOMPLETED,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Subtask.COMPLETEDDATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Subtask.PRIORITY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Subtask.TASKID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _SubtaskModelType extends ModelType<Subtask> {
  const _SubtaskModelType();
  
  @override
  Subtask fromJson(Map<String, dynamic> jsonData) {
    return Subtask.fromJson(jsonData);
  }
}