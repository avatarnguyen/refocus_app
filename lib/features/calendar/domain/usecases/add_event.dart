import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/calendar/domain/repositories/calendar_repository.dart';

@lazySingleton
class AddEvent implements UseCase<Unit, EventParams> {
  AddEvent({required this.repository});

  final CalendarRepository repository;

  @override
  Future<Either<Failure, Unit>> call(EventParams params) async {
    return await repository.addEventsData(
      params.eventEntry,
      calendarId: params.calendarId,
    );
  }
}

class EventParams extends Equatable {
  const EventParams({required this.eventEntry, this.calendarId});

  final CalendarEventEntry eventEntry;
  final String? calendarId;

  @override
  List<Object?> get props => [eventEntry, calendarId];
}
