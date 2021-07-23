import 'package:dartz/dartz.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/platform/network_info.dart';
import 'package:refocus_app/features/google_calendar/data/datasources/google_calendar_local_data_source.dart';
import 'package:refocus_app/features/google_calendar/data/datasources/google_calendar_remote_data_source.dart';
import 'package:refocus_app/features/google_calendar/data/models/google_calendar_entry_model.dart';
import 'package:refocus_app/features/google_calendar/domain/entities/google_calendar_entry.dart';
import 'package:refocus_app/features/google_calendar/domain/repositories/google_calendar_repository.dart';

class GoogleCalendarRepositoryImpl implements GoogleCalendarRepository {
  GoogleCalendarRepositoryImpl(
      {required this.remoteCalDataSource,
      required this.localCalDataSource,
      required this.networkInfo});

  final GoogleCalendarRemoteDataSource remoteCalDataSource;
  final GoogleCalendarLocalDataSource localCalDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, GoogleCalendarEntry>> getAllCalendarEntries() async {
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
