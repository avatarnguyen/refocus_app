import 'package:dartz/dartz.dart';

import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/calendar/domain/repositories/calendar_repository.dart';

class GetCalendarList implements UseCase<List<CalendarEntry>, NoParams> {
  GetCalendarList({
    required this.repository,
  });

  final CalendarRepository repository;

  @override
  Future<Either<Failure, List<CalendarEntry>>> call(NoParams params) async {
    return await repository.getCalendarList();
  }
}
