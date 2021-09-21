import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/date_range_query_params.dart';

/// required [DateRangeParams] for start and end dates
@lazySingleton
class GetEventsBetween
    implements UseCase<List<CalendarEventEntry>, DateRangeParams> {
  GetEventsBetween(this.repository);

  final CalendarRepository repository;

  @override
  Future<Either<Failure, List<CalendarEventEntry>>> call(
      DateRangeParams params) async {
    return repository.getEventsDataBetween(params.startDate, params.endDate);
  }
}
