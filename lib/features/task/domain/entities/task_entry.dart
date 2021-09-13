import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_entry.freezed.dart';
part 'task_entry.g.dart';

// ignore_for_file: sort_constructors_first
// ignore_for:file: implicit_dynamic_parameter
@freezed
class TaskEntry with _$TaskEntry {
  factory TaskEntry({
    required String id,
    required bool isCompleted,
    required String projectID,
    String? title,
    String? description,
    DateTime? dueDate,
    List<DateTime>? startDateTime,
    List<DateTime>? endDateTime,
    List<String>? recurrentDays,
    int? priority,
  }) = _TaskEntry;

  // @override
  // List<Object?> get props => [
  //       id,
  //       title,
  //       description,
  //       isCompleted,
  //       dueDate,
  //       startDateTime,
  //       endDateTime,
  //       recurrentDays,
  //       priority,
  //       projectID
  //     ];

  factory TaskEntry.fromJson(Map<String, dynamic> json) =>
      _$TaskEntryFromJson(json);
}
