import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:refocus_app/features/task/domain/entities/task_entry.dart';

class ProjectEntry extends Equatable {
  const ProjectEntry({
    required this.id,
    this.title,
    this.tasks,
  });
  final String id;
  final String? title;
  final List<TaskEntry>? tasks;

  @override
  List<Object?> get props => [id, title, tasks];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'tasks': tasks?.map((x) => x.toMap()).toList(),
    };
  }

  factory ProjectEntry.fromMap(Map<String, dynamic> map) {
    return ProjectEntry(
      id: map['id'],
      title: map['title'],
      tasks:
          List<TaskEntry>.from(map['tasks']?.map((x) => TaskEntry.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectEntry.fromJson(String source) =>
      ProjectEntry.fromMap(json.decode(source));
}
