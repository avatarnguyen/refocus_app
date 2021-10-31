import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';

class TodayEntry extends Equatable {
  const TodayEntry({
    required this.id,
    required this.type,
    this.title,
    this.description,
    this.emoji,
    this.color,
    this.startDateTime,
    this.endDateTime,
    this.dueDateTime,
    this.calendarEventID,
    this.projectOrCalID,
    this.isCompleted,
    this.priority,
    this.subTaskEntries,
  });

  final String id;
  final TodayEntryType type;
  final String? title;
  final String? description;
  final String? emoji;
  final String? color;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final DateTime? dueDateTime;
  final String? calendarEventID;
  final String? projectOrCalID;
  final bool? isCompleted;
  final int? priority;
  final List<SubTaskEntry>? subTaskEntries;

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        description,
        emoji,
        color,
        startDateTime,
        endDateTime,
        dueDateTime,
        calendarEventID,
        projectOrCalID,
        isCompleted,
        priority,
        subTaskEntries,
      ];

  TodayEntry copyWith({
    String? id,
    TodayEntryType? type,
    String? title,
    String? description,
    String? emoji,
    String? color,
    DateTime? startDateTime,
    DateTime? endDateTime,
    DateTime? dueDateTime,
    String? calendarEventID,
    String? projectOrCalID,
    bool? isCompleted,
    int? priority,
    List<SubTaskEntry>? subTaskEntries,
  }) {
    return TodayEntry(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      emoji: emoji ?? this.emoji,
      color: color ?? this.color,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      dueDateTime: dueDateTime ?? this.dueDateTime,
      calendarEventID: calendarEventID ?? this.calendarEventID,
      projectOrCalID: projectOrCalID ?? this.projectOrCalID,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      subTaskEntries: subTaskEntries ?? this.subTaskEntries,
    );
  }
}
