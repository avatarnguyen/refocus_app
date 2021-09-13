// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
// ignore_for:file: implicit_dynamic_parameter

_$_TaskEntry _$$_TaskEntryFromJson(Map<String, dynamic> json) => _$_TaskEntry(
      id: json['id'] as String,
      isCompleted: json['isCompleted'] as bool,
      projectID: json['projectID'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      startDateTime: (json['startDateTime'] as List<dynamic>?)
          ?.map((dynamic e) => DateTime.parse(e as String))
          .toList(),
      endDateTime: (json['endDateTime'] as List<dynamic>?)
          ?.map((dynamic e) => DateTime.parse(e as String))
          .toList(),
      recurrentDays: (json['recurrentDays'] as List<dynamic>?)
          ?.map((dynamic e) => e as String)
          .toList(),
      priority: json['priority'] as int?,
    );

Map<String, dynamic> _$$_TaskEntryToJson(_$_TaskEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isCompleted': instance.isCompleted,
      'projectID': instance.projectID,
      'title': instance.title,
      'description': instance.description,
      'dueDate': instance.dueDate?.toIso8601String(),
      'startDateTime':
          instance.startDateTime?.map((e) => e.toIso8601String()).toList(),
      'endDateTime':
          instance.endDateTime?.map((e) => e.toIso8601String()).toList(),
      'recurrentDays': instance.recurrentDays,
      'priority': instance.priority,
    };
