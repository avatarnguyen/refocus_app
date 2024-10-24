import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/calendar/domain/repositories/calendar_repository.dart';

import '../helpers/calendar_params.dart';

@lazySingleton
class UpdateCalendarList implements UseCase<CalendarEntry, CalendarParams> {
  UpdateCalendarList({
    required this.repository,
  });

  final CalendarRepository repository;

  @override
  Future<Either<Failure, CalendarEntry>> call(CalendarParams params) async {
    return await repository.updateCalendarList(params.calendar);
  }
}
