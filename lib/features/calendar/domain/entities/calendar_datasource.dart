import 'package:equatable/equatable.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'gcal_event_entry.dart';

class CalendarData extends CalendarDataSource implements EquatableMixin {
  CalendarData({List<GCalEventEntry>? events}) {
    appointments = events;
  }

  @override
  DateTime getStartTime(int index) {
    final GCalEventEntry? event = appointments?[index];
    return event?.start ?? event!.start!.toLocal();
  }

  @override
  DateTime getEndTime(int index) {
    final GCalEventEntry event = appointments![index];
    return event.end != null
        ? (event.end != null
            ? event.end!.add(const Duration(days: -1))
            : event.end!.toLocal())
        : (event.start ?? event.start!.toLocal());
  }

  @override
  String getSubject(int index) {
    final GCalEventEntry event = appointments?[index];
    return event.subject.isEmpty ? 'No Title' : event.subject;
  }

  @override
  List<Object?> get props => [appointments];

  @override
  bool? get stringify => true;
}
