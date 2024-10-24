import 'package:equatable/equatable.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';

class CalendarParams extends Equatable {
  const CalendarParams({required this.calendar});

  final CalendarEntry calendar;

  @override
  List<Object?> get props => [calendar];
}
