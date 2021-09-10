import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:rxdart/subjects.dart';

@lazySingleton
class SettingOption {
  TodayEntryType? _type;
  TodayEntryType get type => _type ?? TodayEntryType.task;
  set type(TodayEntryType? value) => _type = value;

  ProjectEntry? _projectEntry;
  ProjectEntry? get projectEntry => _projectEntry;
  set projectEntry(ProjectEntry? entry) {
    _projectEntry = entry;
  }

  final BehaviorSubject<ProjectEntry?> _projectSubject =
      BehaviorSubject<ProjectEntry?>.seeded(null);
  Stream<ProjectEntry?> get projectStream => _projectSubject.stream;

  void broadCastCurrentProjectEntry(ProjectEntry? entry) {
    _projectSubject.add(entry);
  }

  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  set dateTime(DateTime? entry) => _dateTime = entry;
}
