import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore_for_file: sort_constructors_first
class TaskEntry extends Equatable {
  const TaskEntry({
    required this.id,
    this.title,
    this.description,
    required this.isCompleted,
    this.dueDate,
    this.plannedDate,
    this.recurrentDays,
    required this.projectID,
  });

  final String id;
  final String? title;
  final String? description;
  final bool isCompleted;
  final DateTime? dueDate;
  final List<DateTime>? plannedDate;
  final List<String>? recurrentDays;
  final String projectID;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        isCompleted,
        dueDate,
        plannedDate,
        recurrentDays,
        projectID
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'dueDate': dueDate,
      'plannedDate': plannedDate?.map((x) => x).toList(),
      'recurrentDays': recurrentDays,
      'projectID': projectID,
    };
  }

  factory TaskEntry.fromMap(Map<String, dynamic> map) {
    return TaskEntry(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'],
      dueDate: DateTime.parse(map['dueDate']),
      plannedDate: List<DateTime>.from(
          map['plannedDate']?.map((x) => DateTime.parse(x))),
      recurrentDays: List<String>.from(map['recurrentDays']),
      projectID: map['projectID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskEntry.fromJson(String source) =>
      TaskEntry.fromMap(json.decode(source));

  TaskEntry copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? dueDate,
    List<DateTime>? plannedDate,
    List<String>? recurrentDays,
    String? projectID,
  }) {
    return TaskEntry(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
      plannedDate: plannedDate ?? this.plannedDate,
      recurrentDays: recurrentDays ?? this.recurrentDays,
      projectID: projectID ?? this.projectID,
    );
  }
}
