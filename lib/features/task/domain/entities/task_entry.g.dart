// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskEntry _$$_TaskEntryFromJson(Map<String, dynamic> json) => _$_TaskEntry(
      id: json['id'] as String,
      isCompleted: json['isCompleted'] as bool,
      projectID: json['projectID'] as String,
      calendarID: json['calendarID'] as String?,
      colorID: json['colorID'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      dueDate: const DateSerialiser().fromJson(json['dueDate'] as String?),
      completedDate:
          const DateSerialiser().fromJson(json['completedDate'] as String?),
      startDateTime:
          const DateTimeSerialiser().fromJson(json['startDateTime'] as String?),
      endDateTime:
          const DateTimeSerialiser().fromJson(json['endDateTime'] as String?),
      priority: json['priority'] as int?,
      isHabit: json['isHabit'] as bool?,
    );

Map<String, dynamic> _$$_TaskEntryToJson(_$_TaskEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isCompleted': instance.isCompleted,
      'projectID': instance.projectID,
      'calendarID': instance.calendarID,
      'colorID': instance.colorID,
      'title': instance.title,
      'description': instance.description,
      'dueDate': const DateSerialiser().toJson(instance.dueDate),
      'completedDate': const DateSerialiser().toJson(instance.completedDate),
      'startDateTime':
          const DateTimeSerialiser().toJson(instance.startDateTime),
      'endDateTime': const DateTimeSerialiser().toJson(instance.endDateTime),
      'priority': instance.priority,
      'isHabit': instance.isHabit,
    };
