import 'package:equatable/equatable.dart';

import 'package:refocus_app/enum/today_entry_type.dart';

class TodayEntry extends Equatable {
  const TodayEntry({
    required this.id,
    required this.type,
    this.title,
    this.emoji,
    this.color,
    this.startDateTime,
    this.endDateTime,
    this.calendarEventID,
    this.projectOrCal,
  });

  final String id;
  final TodayEntryType type;
  final String? title;
  final String? emoji;
  final String? color;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final String? calendarEventID;
  final String? projectOrCal;

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        emoji,
        color,
        startDateTime,
        endDateTime,
        calendarEventID,
        projectOrCal,
      ];

  TodayEntry copyWith({
    String? id,
    TodayEntryType? type,
    String? title,
    String? emoji,
    String? color,
    DateTime? startDateTime,
    DateTime? endDateTime,
    String? calendarEventID,
    String? projectOrCal,
  }) {
    return TodayEntry(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      emoji: emoji ?? this.emoji,
      color: color ?? this.color,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      calendarEventID: calendarEventID ?? this.calendarEventID,
      projectOrCal: projectOrCal ?? this.projectOrCal,
    );
  }
}
