import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:refocus_app/core/network/network_info.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_local_data_source.dart';
import 'package:refocus_app/features/calendar/data/datasources/gcal_remote_data_source.dart';
import 'package:refocus_app/features/calendar/data/repositories/google_calendar_repository_impl.dart';
import 'package:refocus_app/features/calendar/domain/repositories/gcal_repository.dart';
import 'package:refocus_app/features/calendar/domain/usecases/get_google_events.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/gcal_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //* Features - Get Calendar Entry
  // Bloc
  sl.registerFactory(
    () => GcalBloc(getAllCalendarEntry: sl()),
  );

  // Use cases
  // ignore: cascade_invocations
  sl.registerLazySingleton(() => GetGoogleEvents(sl()));

  // Repository
  // ignore: cascade_invocations
  sl.registerLazySingleton<GCalRepository>(() => GoogleCalendarRepositoryImpl(
        remoteCalDataSource: sl(),
        localCalDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  // ignore: cascade_invocations
  sl.registerLazySingleton<GCalRemoteDataSource>(
      () => GoogleAPIGCalRemoteDataSoure(client: sl()));
  // ignore: cascade_invocations
  sl.registerLazySingleton<GCalLocalDataSource>(
      () => SharedPrefGCalLocalDataSource(sharedPreferences: sl()));

  //* Core
  // ignore: cascade_invocations
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //* External
  // ignore: cascade_invocations
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client()); // ignore: cascade_invocations
  // ignore: cascade_invocations
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
