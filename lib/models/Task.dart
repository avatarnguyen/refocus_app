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


/** This is an auto generated class representing the Task type in your schema. */
@immutable
class Task extends Model {
  static const classType = const _TaskModelType();
  final String id;
  final String? _title;
  final String? _description;
  final bool? _isCompleted;
  final TemporalDate? _completedDate;
  final TemporalDate? _dueDate;
  final TemporalDateTime? _startDateTime;
  final TemporalDateTime? _endDateTime;
  final bool? _isHabit;
  final int? _priority;
  final String? _projectID;
  final List<Subtask>? _Subtasks;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get title {
    return _title;
  }
  
  String? get description {
    return _description;
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
  
  TemporalDate? get dueDate {
    return _dueDate;
  }
  
  TemporalDateTime? get startDateTime {
    return _startDateTime;
  }
  
  TemporalDateTime? get endDateTime {
    return _endDateTime;
  }
  
  bool? get isHabit {
    return _isHabit;
  }
  
  int? get priority {
    return _priority;
  }
  
  String? get projectID {
    return _projectID;
  }
  
  List<Subtask>? get Subtasks {
    return _Subtasks;
  }
  
  const Task._internal({required this.id, title, description, required isCompleted, completedDate, dueDate, startDateTime, endDateTime, isHabit, priority, projectID, Subtasks}): _title = title, _description = description, _isCompleted = isCompleted, _completedDate = completedDate, _dueDate = dueDate, _startDateTime = startDateTime, _endDateTime = endDateTime, _isHabit = isHabit, _priority = priority, _projectID = projectID, _Subtasks = Subtasks;
  
  factory Task({String? id, String? title, String? description, required bool isCompleted, TemporalDate? completedDate, TemporalDate? dueDate, TemporalDateTime? startDateTime, TemporalDateTime? endDateTime, bool? isHabit, int? priority, String? projectID, List<Subtask>? Subtasks}) {
    return Task._internal(
      id: id == null ? UUID.getUUID() : id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      completedDate: completedDate,
      dueDate: dueDate,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      isHabit: isHabit,
      priority: priority,
      projectID: projectID,
      Subtasks: Subtasks != null ? List<Subtask>.unmodifiable(Subtasks) : Subtasks);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Task &&
      id == other.id &&
      _title == other._title &&
      _description == other._description &&
      _isCompleted == other._isCompleted &&
      _completedDate == other._completedDate &&
      _dueDate == other._dueDate &&
      _startDateTime == other._startDateTime &&
      _endDateTime == other._endDateTime &&
      _isHabit == other._isHabit &&
      _priority == other._priority &&
      _projectID == other._projectID &&
      DeepCollectionEquality().equals(_Subtasks, other._Subtasks);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Task {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("isCompleted=" + (_isCompleted != null ? _isCompleted!.toString() : "null") + ", ");
    buffer.write("completedDate=" + (_completedDate != null ? _completedDate!.format() : "null") + ", ");
    buffer.write("dueDate=" + (_dueDate != null ? _dueDate!.format() : "null") + ", ");
    buffer.write("startDateTime=" + (_startDateTime != null ? _startDateTime!.format() : "null") + ", ");
    buffer.write("endDateTime=" + (_endDateTime != null ? _endDateTime!.format() : "null") + ", ");
    buffer.write("isHabit=" + (_isHabit != null ? _isHabit!.toString() : "null") + ", ");
    buffer.write("priority=" + (_priority != null ? _priority!.toString() : "null") + ", ");
    buffer.write("projectID=" + "$_projectID");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Task copyWith({String? id, String? title, String? description, bool? isCompleted, TemporalDate? completedDate, TemporalDate? dueDate, TemporalDateTime? startDateTime, TemporalDateTime? endDateTime, bool? isHabit, int? priority, String? projectID, List<Subtask>? Subtasks}) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      completedDate: completedDate ?? this.completedDate,
      dueDate: dueDate ?? this.dueDate,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      isHabit: isHabit ?? this.isHabit,
      priority: priority ?? this.priority,
      projectID: projectID ?? this.projectID,
      Subtasks: Subtasks ?? this.Subtasks);
  }
  
  Task.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _title = json['title'],
      _description = json['description'],
      _isCompleted = json['isCompleted'],
      _completedDate = json['completedDate'] != null ? TemporalDate.fromString(json['completedDate']) : null,
      _dueDate = json['dueDate'] != null ? TemporalDate.fromString(json['dueDate']) : null,
      _startDateTime = json['startDateTime'] != null ? TemporalDateTime.fromString(json['startDateTime']) : null,
      _endDateTime = json['endDateTime'] != null ? TemporalDateTime.fromString(json['endDateTime']) : null,
      _isHabit = json['isHabit'],
      _priority = json['priority'],
      _projectID = json['projectID'],
      _Subtasks = json['Subtasks'] is List
        ? (json['Subtasks'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Subtask.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'title': _title, 'description': _description, 'isCompleted': _isCompleted, 'completedDate': _completedDate?.format(), 'dueDate': _dueDate?.format(), 'startDateTime': _startDateTime?.format(), 'endDateTime': _endDateTime?.format(), 'isHabit': _isHabit, 'priority': _priority, 'projectID': _projectID, 'Subtasks': _Subtasks?.map((e) => e?.toJson())?.toList()
  };

  static final QueryField ID = QueryField(fieldName: "task.id");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField ISCOMPLETED = QueryField(fieldName: "isCompleted");
  static final QueryField COMPLETEDDATE = QueryField(fieldName: "completedDate");
  static final QueryField DUEDATE = QueryField(fieldName: "dueDate");
  static final QueryField STARTDATETIME = QueryField(fieldName: "startDateTime");
  static final QueryField ENDDATETIME = QueryField(fieldName: "endDateTime");
  static final QueryField ISHABIT = QueryField(fieldName: "isHabit");
  static final QueryField PRIORITY = QueryField(fieldName: "priority");
  static final QueryField PROJECTID = QueryField(fieldName: "projectID");
  static final QueryField SUBTASKS = QueryField(
    fieldName: "Subtasks",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Subtask).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Task";
    modelSchemaDefinition.pluralName = "Tasks";
    
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
      key: Task.TITLE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.ISCOMPLETED,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.COMPLETEDDATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.DUEDATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.STARTDATETIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.ENDDATETIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.ISHABIT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.PRIORITY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.PROJECTID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Task.SUBTASKS,
      isRequired: false,
      ofModelName: (Subtask).toString(),
      associatedKey: Subtask.TASKID
    ));
  });
}

class _TaskModelType extends ModelType<Task> {
  const _TaskModelType();
  
  @override
  Task fromJson(Map<String, dynamic> jsonData) {
    return Task.fromJson(jsonData);
  }
}