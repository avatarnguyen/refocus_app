import 'package:freezed_annotation/freezed_annotation.dart';

import 'date_converter.dart';

part 'subtask_entry.freezed.dart';
part 'subtask_entry.g.dart';

// ignore_for_file: sort_constructors_first
@freezed
class SubTaskEntry with _$SubTaskEntry {
  factory SubTaskEntry({
    required String id,
    required bool isCompleted,
    required String todoID,
    required String title,
    @DateSerialiser() DateTime? completedDate,
  }) = _SubTaskEntry;

  factory SubTaskEntry.fromJson(Map<String, dynamic> json) =>
      _$SubTaskEntryFromJson(json);
}
