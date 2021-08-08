import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/calendar_repository.dart';
import 'helpers/query_params.dart';

@lazySingleton
class GetEventsOfDay implements UseCase<List<CalendarEventEntry>, Params> {
  GetEventsOfDay(this.repository);

  final CalendarRepository repository;

  @override
  Future<Either<Failure, List<CalendarEventEntry>>> call(Params params) async {
    return await repository.getEventsDataOfDay(
        params.year, params.month, params.day ?? DateTime.now().day);
  }
}
