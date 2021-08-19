import 'dart:convert';

import 'package:equatable/equatable.dart';

class TaskEntry extends Equatable {
  const TaskEntry({
    required this.id,
    this.title,
    this.description,
    required this.isCompleted,
    required this.projectID,
  });

  final String id;
  final String? title;
  final String? description;
  final bool isCompleted;
  final String projectID;

  @override
  List<Object?> get props => [id, title, description, isCompleted, projectID];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'projectID': projectID,
    };
  }

  factory TaskEntry.fromMap(Map<String, dynamic> map) {
    return TaskEntry(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'],
      projectID: map['projectID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskEntry.fromJson(String source) =>
      TaskEntry.fromMap(json.decode(source));
}
