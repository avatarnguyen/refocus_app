import 'package:dartz/dartz.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/network/network_info.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_local_data_source.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_remote_data_source.dart';
import 'package:refocus_app/features/calendar/domain/entities/gcal_event_entry.dart';
import 'package:refocus_app/features/calendar/domain/repositories/gcal_repository.dart';

class GoogleCalendarRepositoryImpl implements GCalRepository {
  GoogleCalendarRepositoryImpl(
      {required this.remoteCalDataSource,
      required this.localCalDataSource,
      required this.networkInfo});

  final GCalRemoteDataSource remoteCalDataSource;
  final GCalLocalDataSource localCalDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, GCalEventEntry>> getGoogleEventsData() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteGCalEntry =
            await remoteCalDataSource.getAllRemoteCalendarEntries();

        await localCalDataSource.cacheGoogleCalendarEntry(remoteGCalEntry);

        return Right(remoteGCalEntry);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localGCalEntry = await localCalDataSource.getLastCalendarEntry();
        return Right(localGCalEntry);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
