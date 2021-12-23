import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:refocus_app/features/task/domain/entities/date_converter.dart';
import 'package:refocus_app/features/task/domain/entities/date_time_converter.dart';

part 'task_entry.freezed.dart';
part 'task_entry.g.dart';

// ignore_for_file: sort_constructors_first
@freezed
class TaskEntry with _$TaskEntry {
  factory TaskEntry({
    required String id,
    bool? isCompleted,
    String? projectID,
    String? calendarID,
    String? colorID,
    String? title,
    String? description,
    @DateSerialiser() DateTime? dueDate,
    @DateSerialiser() DateTime? completedDate,
    @DateTimeSerialiser() DateTime? startDateTime,
    @DateTimeSerialiser() DateTime? endDateTime,
    int? priority,
    bool? isHabit,
  }) = _TaskEntry;

  factory TaskEntry.fromJson(Map<String, dynamic> json) =>
      _$TaskEntryFromJson(json);
}
