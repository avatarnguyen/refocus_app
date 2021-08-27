import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

// ignore_for_file: sort_constructors_first
class TaskEntry extends Equatable {
  const TaskEntry({
    required this.id,
    this.title,
    this.description,
    required this.isCompleted,
    this.dueDate,
    this.startDateTime,
    this.endDateTime,
    this.recurrentDays,
    required this.projectID,
  });

  final String id;
  final String? title;
  final String? description;
  final bool isCompleted;
  final DateTime? dueDate;
  final List<DateTime>? startDateTime;
  final List<DateTime>? endDateTime;
  final List<String>? recurrentDays;
  final String projectID;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        isCompleted,
        dueDate,
        startDateTime,
        endDateTime,
        recurrentDays,
        projectID
      ];

  TaskEntry copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? dueDate,
    List<DateTime>? startDateTime,
    List<DateTime>? endDateTime,
    List<String>? recurrentDays,
    String? projectID,
  }) {
    return TaskEntry(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      recurrentDays: recurrentDays ?? this.recurrentDays,
      projectID: projectID ?? this.projectID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'dueDate':
          dueDate != null ? DateFormat('yyyy-MM-dd').format(dueDate!) : null,
      'startDateTime':
          startDateTime?.map((x) => x.toUtc().toIso8601String()).toList() ?? [],
      'endDateTime':
          endDateTime?.map((x) => x.toUtc().toIso8601String()).toList() ?? [],
      'recurrentDays': recurrentDays ?? [],
      'projectID': projectID,
    };
  }

  factory TaskEntry.fromMap(Map<String, dynamic> map) {
    return TaskEntry(
      id: map['id'] ?? '',
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] ?? false,
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      startDateTime: List<DateTime>.from(
          map['startDateTime']?.map((x) => DateTime.parse(x))),
      endDateTime: List<DateTime>.from(
          (map['endDateTime'])?.map((x) => DateTime.parse(x))),
      recurrentDays: List<String>.from(map['recurrentDays']),
      projectID: map['projectID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskEntry.fromJson(String source) =>
      TaskEntry.fromMap(json.decode(source));
}
