import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:rxdart/subjects.dart';

@lazySingleton
class SettingOption {
  TodayEntryType? _type;
  TodayEntryType get type => _type ?? TodayEntryType.task;
  set type(TodayEntryType? value) => _type = value;

  final BehaviorSubject<TodayEntryType> _typeSubject =
      BehaviorSubject<TodayEntryType>.seeded(TodayEntryType.task);
  Stream<TodayEntryType> get typeStream => _typeSubject.stream;

  void broadCastCurrentTypeEntry(TodayEntryType entry) {
    _typeSubject.add(entry);
    _type = entry;
  }

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

  CalendarEntry? _calendarEntry;
  CalendarEntry? get calendarEntry => _calendarEntry;
  set calendarEntry(CalendarEntry? entry) {
    _calendarEntry = entry;
  }

  final BehaviorSubject<CalendarEntry?> _calendarSubject =
      BehaviorSubject<CalendarEntry?>.seeded(null);
  Stream<CalendarEntry?> get calendarStream => _calendarSubject.stream;

  void broadCastCurrentCalendarEntry(CalendarEntry? entry) {
    _calendarSubject.add(entry);
    _calendarEntry = entry;
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

  //* Reminder Start DateTime Stream
  final BehaviorSubject<DateTime?> _startTimeSubject =
      BehaviorSubject<DateTime?>.seeded(null);
  Stream<DateTime?> get startTimeStream => _startTimeSubject.stream;

  void broadCastCurrentStartTimeEntry(DateTime? entry) {
    _startTimeSubject.add(entry);
    _plannedStartDate = entry;
  }

  //* Reminder End DateTime Stream
  final BehaviorSubject<DateTime?> _endTimeSubject =
      BehaviorSubject<DateTime?>.seeded(null);
  Stream<DateTime?> get endTimeStream => _endTimeSubject.stream;

  void broadCastCurrentEndTimeEntry(DateTime? entry) {
    _endTimeSubject.add(entry);
    _plannedEndDate = entry;
  }

  DateTime? _plannedStartDate;
  DateTime? get plannedStartDate => _plannedStartDate;
  set plannedStartDate(DateTime? entry) => _plannedStartDate = entry;

  DateTime? _plannedEndDate;
  DateTime? get plannedEndDate => _plannedEndDate;
  set plannedEndDate(DateTime? entry) => _plannedEndDate = entry;

  // void resetAllSettingOptions() {

  // }
}
