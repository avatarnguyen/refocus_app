import 'package:dartz/dartz.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/features/google_calendar/domain/entities/google_calendar_entry.dart';

import '../repositories/google_calendar_repository.dart';

class GetAllCalendarEntry {
  GetAllCalendarEntry(this.repository);

  final GoogleCalendarRepository repository;

  Future<Either<Failure, GoogleCalendarEntry>> execute(
      {required String message}) async {
    return await repository.getAllCalendarEntries();
  }
}
