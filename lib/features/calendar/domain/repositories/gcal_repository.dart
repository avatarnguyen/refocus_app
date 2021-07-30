import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/calendar_datasource.dart';

abstract class GCalRepository {
  Future<Either<Failure, CalendarData>> getGoogleEventsData();
  // TODO: Get Google Events of current months, 3 months, 6 months
}
