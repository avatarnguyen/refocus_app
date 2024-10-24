import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/calendar/domain/repositories/calendar_repository.dart';

import '../helpers/event_params.dart';

@lazySingleton
class UpdateEvent implements UseCase<Unit, EventParams> {
  UpdateEvent({required this.repository});

  final CalendarRepository repository;

  @override
  Future<Either<Failure, Unit>> call(EventParams params) async {
    return repository.updateEventsData(
      params.eventEntry,
      calendarId: params.calendarId,
    );
  }
}
