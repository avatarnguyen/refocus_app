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


/** This is an auto generated class representing the Todo type in your schema. */
@immutable
class Todo extends Model {
  static const classType = const _TodoModelType();
  final String id;
  final String? _title;
  final String? _description;
  final bool? _isCompleted;
  final TemporalDate? _dueDate;
  final TemporalDateTime? _startDateTime;
  final TemporalDateTime? _endDateTime;
  final String? _recurrenceRule;
  final String? _projectID;
  final int? _priority;
  final List<Subtask>? _Subtasks;
  final TemporalDate? _completedDate;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get title {
    try {
      return _title!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
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
  
  TemporalDate? get dueDate {
    return _dueDate;
  }
  
  TemporalDateTime? get startDateTime {
    return _startDateTime;
  }
  
  TemporalDateTime? get endDateTime {
    return _endDateTime;
  }
  
  String? get recurrenceRule {
    return _recurrenceRule;
  }
  
  String? get projectID {
    return _projectID;
  }
  
  int? get priority {
    return _priority;
  }
  
  List<Subtask>? get Subtasks {
    return _Subtasks;
  }
  
  TemporalDate? get completedDate {
    return _completedDate;
  }
  
  const Todo._internal({required this.id, required title, description, required isCompleted, dueDate, startDateTime, endDateTime, recurrenceRule, projectID, priority, Subtasks, completedDate}): _title = title, _description = description, _isCompleted = isCompleted, _dueDate = dueDate, _startDateTime = startDateTime, _endDateTime = endDateTime, _recurrenceRule = recurrenceRule, _projectID = projectID, _priority = priority, _Subtasks = Subtasks, _completedDate = completedDate;
  
  factory Todo({String? id, required String title, String? description, required bool isCompleted, TemporalDate? dueDate, TemporalDateTime? startDateTime, TemporalDateTime? endDateTime, String? recurrenceRule, String? projectID, int? priority, List<Subtask>? Subtasks, TemporalDate? completedDate}) {
    return Todo._internal(
      id: id == null ? UUID.getUUID() : id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      dueDate: dueDate,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      recurrenceRule: recurrenceRule,
      projectID: projectID,
      priority: priority,
      Subtasks: Subtasks != null ? List<Subtask>.unmodifiable(Subtasks) : Subtasks,
      completedDate: completedDate);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Todo &&
      id == other.id &&
      _title == other._title &&
      _description == other._description &&
      _isCompleted == other._isCompleted &&
      _dueDate == other._dueDate &&
      _startDateTime == other._startDateTime &&
      _endDateTime == other._endDateTime &&
      _recurrenceRule == other._recurrenceRule &&
      _projectID == other._projectID &&
      _priority == other._priority &&
      DeepCollectionEquality().equals(_Subtasks, other._Subtasks) &&
      _completedDate == other._completedDate;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Todo {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("isCompleted=" + (_isCompleted != null ? _isCompleted!.toString() : "null") + ", ");
    buffer.write("dueDate=" + (_dueDate != null ? _dueDate!.format() : "null") + ", ");
    buffer.write("startDateTime=" + (_startDateTime != null ? _startDateTime!.format() : "null") + ", ");
    buffer.write("endDateTime=" + (_endDateTime != null ? _endDateTime!.format() : "null") + ", ");
    buffer.write("recurrenceRule=" + "$_recurrenceRule" + ", ");
    buffer.write("projectID=" + "$_projectID" + ", ");
    buffer.write("priority=" + (_priority != null ? _priority!.toString() : "null") + ", ");
    buffer.write("completedDate=" + (_completedDate != null ? _completedDate!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Todo copyWith({String? id, String? title, String? description, bool? isCompleted, TemporalDate? dueDate, TemporalDateTime? startDateTime, TemporalDateTime? endDateTime, String? recurrenceRule, String? projectID, int? priority, List<Subtask>? Subtasks, TemporalDate? completedDate}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      projectID: projectID ?? this.projectID,
      priority: priority ?? this.priority,
      Subtasks: Subtasks ?? this.Subtasks,
      completedDate: completedDate ?? this.completedDate);
  }
  
  Todo.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _title = json['title'],
      _description = json['description'],
      _isCompleted = json['isCompleted'],
      _dueDate = json['dueDate'] != null ? TemporalDate.fromString(json['dueDate']) : null,
      _startDateTime = json['startDateTime'] != null ? TemporalDateTime.fromString(json['startDateTime']) : null,
      _endDateTime = json['endDateTime'] != null ? TemporalDateTime.fromString(json['endDateTime']) : null,
      _recurrenceRule = json['recurrenceRule'],
      _projectID = json['projectID'],
      _priority = json['priority'],
      _Subtasks = json['Subtasks'] is List
        ? (json['Subtasks'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Subtask.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _completedDate = json['completedDate'] != null ? TemporalDate.fromString(json['completedDate']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'title': _title, 'description': _description, 'isCompleted': _isCompleted, 'dueDate': _dueDate?.format(), 'startDateTime': _startDateTime?.format(), 'endDateTime': _endDateTime?.format(), 'recurrenceRule': _recurrenceRule, 'projectID': _projectID, 'priority': _priority, 'Subtasks': _Subtasks?.map((e) => e?.toJson())?.toList(), 'completedDate': _completedDate?.format()
  };

  static final QueryField ID = QueryField(fieldName: "todo.id");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField ISCOMPLETED = QueryField(fieldName: "isCompleted");
  static final QueryField DUEDATE = QueryField(fieldName: "dueDate");
  static final QueryField STARTDATETIME = QueryField(fieldName: "startDateTime");
  static final QueryField ENDDATETIME = QueryField(fieldName: "endDateTime");
  static final QueryField RECURRENCERULE = QueryField(fieldName: "recurrenceRule");
  static final QueryField PROJECTID = QueryField(fieldName: "projectID");
  static final QueryField PRIORITY = QueryField(fieldName: "priority");
  static final QueryField SUBTASKS = QueryField(
    fieldName: "Subtasks",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Subtask).toString()));
  static final QueryField COMPLETEDDATE = QueryField(fieldName: "completedDate");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Todo";
    modelSchemaDefinition.pluralName = "Todos";
    
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
      key: Todo.TITLE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.ISCOMPLETED,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.DUEDATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.STARTDATETIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.ENDDATETIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.RECURRENCERULE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.PROJECTID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.PRIORITY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Todo.SUBTASKS,
      isRequired: false,
      ofModelName: (Subtask).toString(),
      associatedKey: Subtask.TODOID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.COMPLETEDDATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
  });
}

class _TodoModelType extends ModelType<Todo> {
  const _TodoModelType();
  
  @override
  Todo fromJson(Map<String, dynamic> jsonData) {
    return Todo.fromJson(jsonData);
  }
}