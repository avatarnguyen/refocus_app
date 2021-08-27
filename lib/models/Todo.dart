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
  final List<TemporalDateTime>? _startDateTime;
  final List<TemporalDateTime>? _endDateTime;
  final List<String>? _recurrentDays;
  final String? _projectID;
  final int? _priority;

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
  
  List<TemporalDateTime>? get startDateTime {
    return _startDateTime;
  }
  
  List<TemporalDateTime>? get endDateTime {
    return _endDateTime;
  }
  
  List<String>? get recurrentDays {
    return _recurrentDays;
  }
  
  String? get projectID {
    return _projectID;
  }
  
  int? get priority {
    return _priority;
  }
  
  const Todo._internal({required this.id, required title, description, required isCompleted, dueDate, startDateTime, endDateTime, recurrentDays, projectID, priority}): _title = title, _description = description, _isCompleted = isCompleted, _dueDate = dueDate, _startDateTime = startDateTime, _endDateTime = endDateTime, _recurrentDays = recurrentDays, _projectID = projectID, _priority = priority;
  
  factory Todo({String? id, required String title, String? description, required bool isCompleted, TemporalDate? dueDate, List<TemporalDateTime>? startDateTime, List<TemporalDateTime>? endDateTime, List<String>? recurrentDays, String? projectID, int? priority}) {
    return Todo._internal(
      id: id == null ? UUID.getUUID() : id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      dueDate: dueDate,
      startDateTime: startDateTime != null ? List<TemporalDateTime>.unmodifiable(startDateTime) : startDateTime,
      endDateTime: endDateTime != null ? List<TemporalDateTime>.unmodifiable(endDateTime) : endDateTime,
      recurrentDays: recurrentDays != null ? List<String>.unmodifiable(recurrentDays) : recurrentDays,
      projectID: projectID,
      priority: priority);
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
      DeepCollectionEquality().equals(_startDateTime, other._startDateTime) &&
      DeepCollectionEquality().equals(_endDateTime, other._endDateTime) &&
      DeepCollectionEquality().equals(_recurrentDays, other._recurrentDays) &&
      _projectID == other._projectID &&
      _priority == other._priority;
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
    buffer.write("startDateTime=" + (_startDateTime != null ? _startDateTime!.toString() : "null") + ", ");
    buffer.write("endDateTime=" + (_endDateTime != null ? _endDateTime!.toString() : "null") + ", ");
    buffer.write("recurrentDays=" + (_recurrentDays != null ? _recurrentDays!.toString() : "null") + ", ");
    buffer.write("projectID=" + "$_projectID" + ", ");
    buffer.write("priority=" + (_priority != null ? _priority!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Todo copyWith({String? id, String? title, String? description, bool? isCompleted, TemporalDate? dueDate, List<TemporalDateTime>? startDateTime, List<TemporalDateTime>? endDateTime, List<String>? recurrentDays, String? projectID, int? priority}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      recurrentDays: recurrentDays ?? this.recurrentDays,
      projectID: projectID ?? this.projectID,
      priority: priority ?? this.priority);
  }
  
  Todo.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _title = json['title'],
      _description = json['description'],
      _isCompleted = json['isCompleted'],
      _dueDate = json['dueDate'] != null ? TemporalDate.fromString(json['dueDate']) : null,
      _startDateTime = (json['startDateTime'] as List)?.map((e) => TemporalDateTime.fromString(e))?.toList(),
      _endDateTime = (json['endDateTime'] as List)?.map((e) => TemporalDateTime.fromString(e))?.toList(),
      _recurrentDays = json['recurrentDays']?.cast<String>(),
      _projectID = json['projectID'],
      _priority = json['priority'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'title': _title, 'description': _description, 'isCompleted': _isCompleted, 'dueDate': _dueDate?.format(), 'startDateTime': _startDateTime?.map((e) => e.format()).toList(), 'endDateTime': _endDateTime?.map((e) => e.format()).toList(), 'recurrentDays': _recurrentDays, 'projectID': _projectID, 'priority': _priority
  };

  static final QueryField ID = QueryField(fieldName: "todo.id");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField ISCOMPLETED = QueryField(fieldName: "isCompleted");
  static final QueryField DUEDATE = QueryField(fieldName: "dueDate");
  static final QueryField STARTDATETIME = QueryField(fieldName: "startDateTime");
  static final QueryField ENDDATETIME = QueryField(fieldName: "endDateTime");
  static final QueryField RECURRENTDAYS = QueryField(fieldName: "recurrentDays");
  static final QueryField PROJECTID = QueryField(fieldName: "projectID");
  static final QueryField PRIORITY = QueryField(fieldName: "priority");
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
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.dateTime))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.ENDDATETIME,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.dateTime))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.RECURRENTDAYS,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
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
  });
}

class _TodoModelType extends ModelType<Todo> {
  const _TodoModelType();
  
  @override
  Todo fromJson(Map<String, dynamic> jsonData) {
    return Todo.fromJson(jsonData);
  }
}