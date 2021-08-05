import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:refocus_app/features/calendar/domain/entities/calendar_datasource.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/calendar_repository.dart';
import 'query_params.dart';

@lazySingleton
class GetEventsOfMonth implements UseCase<CalendarData, Params> {
  GetEventsOfMonth(this.repository);

  final CalendarRepository repository;

  @override
  Future<Either<Failure, CalendarData>> call(Params params) async {
    return await repository.getEventsDataOfMonth(params.year, params.month);
  }
}
