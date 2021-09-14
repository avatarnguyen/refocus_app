import 'dart:async';

import 'package:flutter/material.dart';
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

  //* Due Date Stream
  final BehaviorSubject<DateTime?> _dueDateSubject =
      BehaviorSubject<DateTime?>.seeded(null);
  Stream<DateTime?> get dueDateStream => _dueDateSubject.stream;

  void broadCastCurrentDueDateEntry(DateTime? entry) {
    _dueDateSubject.add(entry);
    _dueDate = entry;
  }

  DateTime? _dueDate;
  DateTime? get dueDate => _dueDate;
  set dueDate(DateTime? entry) => _dueDate = entry;

  //* Reminder DateTime Stream
  final BehaviorSubject<DateTime?> _reminderSubject =
      BehaviorSubject<DateTime?>.seeded(null);
  Stream<DateTime?> get reminderStream => _reminderSubject.stream;

  void broadCastCurrentReminderEntry(DateTime? entry) {
    _reminderSubject.add(entry);
    _remindDate = entry;
  }

  DateTime? _remindDate;
  DateTime? get remindDate => _remindDate;
  set remindDate(DateTime? entry) => _remindDate = entry;
  // TimeOfDay? _remindTime;
  // TimeOfDay? get remindTime => _remindTime;
  // set remindTime(TimeOfDay? entry) => _remindTime = entry;
}
