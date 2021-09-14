import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:refocus_app/features/task/domain/entities/datetime_converter.dart';
import 'package:refocus_app/features/task/domain/entities/list_datetime_converter.dart';

part 'task_entry.freezed.dart';
part 'task_entry.g.dart';

// ignore_for_file: sort_constructors_first
@freezed
class TaskEntry with _$TaskEntry {
  factory TaskEntry({
    required String id,
    required bool isCompleted,
    required String projectID,
    String? title,
    String? description,
    @DateTimeSerialiser() DateTime? dueDate,
    @ListDateTimeSerialiser() List<DateTime>? startDateTime,
    @ListDateTimeSerialiser() List<DateTime>? endDateTime,
    List<String>? recurrentDays,
    int? priority,
  }) = _TaskEntry;

  factory TaskEntry.fromJson(Map<String, dynamic> json) =>
      _$TaskEntryFromJson(json);
}
