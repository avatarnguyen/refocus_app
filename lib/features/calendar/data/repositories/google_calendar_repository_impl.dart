import 'package:dartz/dartz.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/network/network_info.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_local_data_source.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_remote_data_source.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_datasource.dart';
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
  Future<Either<Failure, CalendarData>> getGoogleEventsData() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteGCalEntries =
            await remoteCalDataSource.getRemoteGoogleEventsData();
        print('remoteGCalEntries ${remoteGCalEntries.length}');
        await localCalDataSource.cacheGoogleCalendarEntry(remoteGCalEntries);

        final calendarData = CalendarData(events: remoteGCalEntries);
        print('Repository Impl: ${calendarData.appointments?.length}');
        return Right(calendarData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localGCalEntry = await localCalDataSource.getLastCalendarEntry();
        return Right(CalendarData(events: localGCalEntry));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
