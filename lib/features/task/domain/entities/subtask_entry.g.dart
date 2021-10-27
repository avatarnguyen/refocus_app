// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtask_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SubTaskEntry _$$_SubTaskEntryFromJson(Map<String, dynamic> json) =>
    _$_SubTaskEntry(
      id: json['id'] as String,
      isCompleted: json['isCompleted'] as bool,
      taskID: json['taskID'] as String,
      title: json['title'] as String?,
      completedDate:
          const DateSerialiser().fromJson(json['completedDate'] as String?),
      priority: json['priority'] as int?,
    );

Map<String, dynamic> _$$_SubTaskEntryToJson(_$_SubTaskEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isCompleted': instance.isCompleted,
      'taskID': instance.taskID,
      'title': instance.title,
      'completedDate': const DateSerialiser().toJson(instance.completedDate),
      'priority': instance.priority,
    };
