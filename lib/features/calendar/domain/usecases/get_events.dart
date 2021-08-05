import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_datasource.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/calendar_repository.dart';

@lazySingleton
class GetEvents implements UseCase<CalendarData, NoParams> {
  GetEvents(this.repository);

  final CalendarRepository repository;

  @override
  Future<Either<Failure, CalendarData>> call(NoParams params) async {
    return await repository.getEventsData();
  }
}
