import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:refocus_app/core/network/network_info.dart';
import 'package:refocus_app/features/google_calendar/data/datasources/gcal_local_data_source.dart';
import 'package:refocus_app/features/google_calendar/data/datasources/gcal_remote_data_source.dart';
import 'package:refocus_app/features/google_calendar/data/repositories/google_calendar_repository_impl.dart';
import 'package:refocus_app/features/google_calendar/domain/repositories/google_calendar_repository.dart';
import 'package:refocus_app/features/google_calendar/domain/usecases/get_all_calendar_entry.dart';
import 'package:refocus_app/features/google_calendar/presentation/bloc/gcal_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

void init() {
  //* Features - Get Calendar Entry
  // Bloc
  sl.registerFactory(
    () => GcalBloc(getAllCalendarEntry: sl()),
  );

  // Use cases
  // ignore: cascade_invocations
  sl.registerLazySingleton(() => GetAllCalendarEntry(sl()));

  // Repository
  // ignore: cascade_invocations
  sl.registerLazySingleton<GoogleCalendarRepository>(
      () => GoogleCalendarRepositoryImpl(
            remoteCalDataSource: sl(),
            localCalDataSource: sl(),
            networkInfo: sl(),
          ));

  // Data sources
  // ignore: cascade_invocations
  sl.registerLazySingleton<GCalRemoteDataSource>(
      () => HttpGCalRemoteDataSoure(client: sl()));
  // ignore: cascade_invocations
  sl.registerLazySingleton<GCalLocalDataSource>(
      () => SharedPrefGCalLocalDataSource(sharedPreferences: sl()));

  //* Core
  // ignore: cascade_invocations
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //* External
  // ignore: cascade_invocations
  sl.registerLazySingletonAsync<SharedPreferences>(
      SharedPreferences.getInstance);
  sl.registerLazySingleton(() => http.Client()); // ignore: cascade_invocations
  // ignore: cascade_invocations
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
