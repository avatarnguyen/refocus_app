import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_datasource.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/gcal_repository.dart';

@lazySingleton
class GetGoogleEvents implements UseCase<CalendarData, NoParams> {
  GetGoogleEvents(this.repository);

  final GCalRepository repository;

  @override
  Future<Either<Failure, CalendarData>> call(NoParams params) async {
    return await repository.getGoogleEventsData();
  }
}
