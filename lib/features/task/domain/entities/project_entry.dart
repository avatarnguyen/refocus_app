import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:googleapis/oauth2/v2.dart';

// ignore_for_file: sort_constructors_first
class ProjectEntry extends Equatable {
  const ProjectEntry({
    required this.id,
    this.title,
    this.color,
    this.emoji,
    this.taskCount,
    this.userID,
  });
  final String id;
  final String? title;
  final String? color;
  final String? emoji;
  final int? taskCount;
  final String? userID;

  @override
  List<Object?> get props => [id, title, color, emoji, taskCount, userID];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'color': color,
      'emoji': emoji,
      'taskCount': taskCount,
      'userID': userID,
    };
  }

  factory ProjectEntry.fromMap(Map<String, dynamic> map) {
    return ProjectEntry(
      id: map['id'] as String,
      title: map.containsKey('title') ? map['title'] as String? : null,
      color: map.containsKey('color') ? map['color'] as String? : null,
      emoji: map.containsKey('emoji') ? map['emoji'] as String? : null,
      taskCount: map.containsKey('taskCount') ? map['taskCount'] as int? : null,
      userID: map.containsKey('userID') ? map['userID'] as String? : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectEntry.fromJson(String source) =>
      ProjectEntry.fromMap(json.decode(source) as Map<String, dynamic>);

  ProjectEntry copyWith({
    String? id,
    String? title,
    String? color,
    String? emoji,
    int? taskCount,
    String? userID,
  }) {
    return ProjectEntry(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      emoji: emoji ?? this.emoji,
      taskCount: taskCount ?? this.taskCount,
      userID: userID ?? this.userID,
    );
  }
}
