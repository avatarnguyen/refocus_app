import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/calendar_repository.dart';

@lazySingleton
class GetEvents implements UseCase<List<CalendarEventEntry>, NoParams> {
  GetEvents(this.repository);

  final CalendarRepository repository;

  @override
  Future<Either<Failure, List<CalendarEventEntry>>> call(
      NoParams params) async {
    final _start = CustomDateUtils.firstDayOfCurrentMonth();
    final _end = CustomDateUtils.lastDayOfFutureMonthIn(2);

    return repository.getEventsDataBetween(_start, _end);
  }
}
