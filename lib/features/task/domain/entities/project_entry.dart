import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore_for_file: sort_constructors_first
class ProjectEntry extends Equatable {
  const ProjectEntry({
    required this.id,
    this.title,
    this.color,
    this.emoji,
  });
  final String id;
  final String? title;
  final String? color;
  final String? emoji;

  @override
  List<Object?> get props => [id, title, color, emoji];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'color': color,
      'emoji': emoji,
    };
  }

  factory ProjectEntry.fromMap(Map<String, dynamic> map) {
    return ProjectEntry(
      id: map['id'] as String,
      title: map['title'] as String?,
      color: map['color'] as String?,
      emoji: map['emoji'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectEntry.fromJson(String source) =>
      ProjectEntry.fromMap(json.decode(source) as Map<String, dynamic>);
}
