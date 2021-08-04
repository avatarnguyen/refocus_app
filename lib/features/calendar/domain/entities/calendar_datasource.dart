import 'package:equatable/equatable.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'calendar_event_entry.dart';

class CalendarData extends CalendarDataSource implements EquatableMixin {
  CalendarData({List<GCalEventEntry>? events}) {
    appointments = events;
  }

  @override
  bool isAllDay(int index) {
    final GCalEventEntry? event = appointments?[index];
    return event?.allDay ?? false;
  }

  @override
  DateTime getStartTime(int index) {
    final GCalEventEntry? event = appointments?[index];
    return event?.startDate ?? event!.startDateTime!.toLocal();
  }

  @override
  DateTime getEndTime(int index) {
    final GCalEventEntry event = appointments![index];
    return (event.endDate == null && event.endDateTime == null)
        ? (event.startDate ?? event.startDateTime!.toLocal())
        : (event.endDate != null
            ? event.endDate!.add(const Duration(days: -1))
            : event.endDateTime!.toLocal());
  }

  @override
  String getSubject(int index) {
    final GCalEventEntry event = appointments?[index];
    return event.subject.isEmpty ? 'No Title' : event.subject;
  }

  @override
  Object? getId(int index) {
    final GCalEventEntry event = appointments?[index];
    return event.id;
  }

  @override
  List<Object?> get props => [appointments];

  @override
  bool? get stringify => true;
}
