import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/gcal_event_entry.dart';

abstract class GCalRepository {
  Future<Either<Failure, GCalEventEntry>> getGoogleEventsData();
  // TODO: Get Google Events of current months, 3 months, 6 months
}
