// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskEntry _$$_TaskEntryFromJson(Map<String, dynamic> json) => _$_TaskEntry(
      id: json['id'] as String,
      isCompleted: json['isCompleted'] as bool,
      projectID: json['projectID'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      dueDate: const DateTimeSerialiser().fromJson(json['dueDate'] as String?),
      startDateTime: const ListDateTimeSerialiser()
          .fromJson(json['startDateTime'] as List<String>?),
      endDateTime: const ListDateTimeSerialiser()
          .fromJson(json['endDateTime'] as List<String>?),
      recurrentDays: (json['recurrentDays'] as List<dynamic>?)
          ?.map((e) => e as String)
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
      'dueDate': const DateTimeSerialiser().toJson(instance.dueDate),
      'startDateTime':
          const ListDateTimeSerialiser().toJson(instance.startDateTime),
      'endDateTime':
          const ListDateTimeSerialiser().toJson(instance.endDateTime),
      'recurrentDays': instance.recurrentDays,
      'priority': instance.priority,
    };
