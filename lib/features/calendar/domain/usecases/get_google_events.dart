import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/gcal_event_entry.dart';
import '../repositories/gcal_repository.dart';

class GetGoogleEvents implements UseCase<GCalEventEntry, NoParams> {
  GetGoogleEvents(this.repository);

  final GCalRepository repository;

  @override
  Future<Either<Failure, GCalEventEntry>> call(NoParams params) async {
    return await repository.getGoogleEventsData();
  }
}
