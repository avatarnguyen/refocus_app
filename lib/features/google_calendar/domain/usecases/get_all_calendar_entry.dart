import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/google_calendar_entry.dart';
import '../repositories/google_calendar_repository.dart';

class GetAllCalendarEntry implements UseCase<GoogleCalendarEntry, NoParams> {
  GetAllCalendarEntry(this.repository);

  final GoogleCalendarRepository repository;

  @override
  Future<Either<Failure, GoogleCalendarEntry>> call(NoParams params) async {
    return await repository.getAllCalendarEntries();
  }
}
