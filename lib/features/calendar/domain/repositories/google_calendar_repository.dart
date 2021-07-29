import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../calendar/domain/entities/google_calendar_entry.dart';

abstract class GoogleCalendarRepository {
  Future<Either<Failure, GoogleCalendarEntry>> getAllCalendarEntries();
}
