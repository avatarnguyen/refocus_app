import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:loggy/loggy.dart';
import 'package:refocus_app/features/calendar/domain/usecases/get_events_day.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/query_params.dart';
import 'package:refocus_app/injection.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:dartx/dartx.dart';

import 'calendar_event_entry.dart';

class CalendarData extends CalendarDataSource
    with UiLoggy
    implements EquatableMixin {
  CalendarData({List<CalendarEventEntry>? events}) {
    appointments = events;
  }

  @override
  bool isAllDay(int index) {
    final CalendarEventEntry? event = appointments?[index];
    return event?.allDay != null;
  }

  @override
  DateTime getStartTime(int index) {
    final CalendarEventEntry? event = appointments?[index];
    return event?.startDate ?? event!.startDateTime!.toLocal();
  }

  @override
  DateTime getEndTime(int index) {
    final CalendarEventEntry event = appointments![index];
    return (event.endDate == null && event.endDateTime == null)
        ? (event.startDate ?? event.startDateTime!.toLocal())
        : (event.endDate != null
            ? event.endDate!.add(const Duration(days: -1))
            : event.endDateTime!.toLocal());
  }

  @override
  String getSubject(int index) {
    final CalendarEventEntry event = appointments?[index];
    return event.subject.isEmpty ? 'No Title' : event.subject;
  }

  @override
  Object? getId(int index) {
    final CalendarEventEntry event = appointments?[index];
    return event.id;
  }

  @override
  Color getColor(int index) {
    final CalendarEventEntry event = appointments?[index];
    //! Should replace with real Color String
    loggy.debug('Color: ${event.colorId}');
    var color = '#115FFB'.replaceAll('#', '0xff');

    return Color(int.parse(color));
  }

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    final newEvents = <CalendarEventEntry>[];

    loggy.info('Load More: $startDate - $endDate');
    if (startDate.isAtSameDayAs(endDate) &&
        startDate.isAtSameMonthAs(endDate)) {
      // Update Date
      final getEventsDay = getIt<GetEventsOfDay>();
      final result = await getEventsDay(Params(
          year: startDate.year, month: startDate.month, day: startDate.day));
      loggy.debug(result);
      //TODO
      result.fold((failure) => null, (entries) => null);
    } else {
      // Update Month
    }

    if (appointments != null) {
      appointments!.addAll(newEvents);
    }
    notifyListeners(CalendarDataSourceAction.add, newEvents);
  }

  @override
  List<Object?> get props => [appointments];

  @override
  bool? get stringify => true;
}
