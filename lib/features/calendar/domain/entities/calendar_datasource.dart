import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/features/calendar/domain/usecases/get_events_day.dart';
import 'package:refocus_app/features/calendar/domain/usecases/get_events_month.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/date_range_query_params.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/query_params.dart';
import 'package:refocus_app/injection.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:dartx/dartx.dart';

import 'calendar_event_entry.dart';

class CalendarData extends CalendarDataSource implements EquatableMixin {
  CalendarData({List<CalendarEventEntry>? events}) {
    appointments = events;
  }

  final log = logger(CalendarData);

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
    // log.d('Color: ${event.colorId}');
    var color = '#115FFB'.replaceAll('#', '0xff');

    return Color(int.parse(color));
  }

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    var newEvents = [];

    log.i('Load More: $startDate - $endDate');
    if (startDate.isAtSameDayAs(endDate) &&
        startDate.isAtSameMonthAs(endDate)) {
      //* Update Daily
      final getEventsDay = getIt<GetEventsOfDay>();
      final result = await getEventsDay(Params(
          year: startDate.year, month: startDate.month, day: startDate.day));
      log.d('Result: $result');

      newEvents = _eitherFailureOrSuccess(result);
    } else {
      //* UPDATE MONTHLY
      log.i('UPDATE IN RANGE');
      final getEventsMonth = getIt<GetEventsOfMonth>();
      final result = await getEventsMonth(
          DateRangeParams(startDate: startDate, endDate: endDate));
      log.d('Result: $result');

      newEvents = _eitherFailureOrSuccess(result);
    }

    //* Add New Events to Calendar (appointments)
    if (appointments != null && newEvents.isNotEmpty) {
      log.i('Add ${newEvents.length} New Event');
      try {
        await Future.forEach(newEvents, (event) => appointments!.add(event));
      } catch (e) {
        log.e(e);
      }
    }
    notifyListeners(CalendarDataSourceAction.add, newEvents);
  }

  List<dynamic> _eitherFailureOrSuccess(
    Either<Failure, List<CalendarEventEntry>> result,
  ) {
    final newEvents = [];

    result.fold(log.e, (events) {
      log.i('Success: $events');
      if (events.isNotEmpty) {
        for (var event in events) {
          if (appointments!.contains(event)) {
            continue;
          } else {
            log.i('New Event: $event');
            newEvents.add(event);
          }
        }
      }
    });
    return newEvents;
  }

  @override
  List<Object?> get props => [appointments];

  @override
  bool? get stringify => true;
}
