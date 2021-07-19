import 'package:dartz/dartz.dart';
import 'package:refocus_app/features/google_calendar/domain/entities/google_calendar_entry.dart';

import '../../../../core/error/failures.dart';

abstract class GoogleCalendarRepository {
  Future<Either<Failure, GoogleCalendarEntry>> getAllCalendarEntries();
}
