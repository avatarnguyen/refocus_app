// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import 'core/injectable_module.dart' as _i13;
import 'core/network/network_info.dart' as _i5;
import 'features/calendar/data/datasources/gcal_local_data_source.dart' as _i7;
import 'features/calendar/data/datasources/gcal_remote_data_source.dart' as _i8;
import 'features/calendar/data/repositories/google_calendar_repository_impl.dart'
    as _i10;
import 'features/calendar/domain/repositories/gcal_repository.dart' as _i9;
import 'features/calendar/domain/usecases/get_google_events.dart' as _i11;
import 'features/calendar/presentation/bloc/gcal_bloc.dart'
    as _i12; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.GoogleSignIn>(() => registerModule.gCalSignIn);
  gh.lazySingleton<_i4.InternetConnectionChecker>(
      () => registerModule.internetChecker);
  gh.lazySingleton<_i5.NetworkInfo>(
      () => _i5.NetworkInfoImpl(get<_i4.InternetConnectionChecker>()));
  await gh.factoryAsync<_i6.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.lazySingleton<_i7.GCalLocalDataSource>(() =>
      _i7.SharedPrefGCalLocalDataSource(
          sharedPreferences: get<_i6.SharedPreferences>()));
  gh.lazySingleton<_i8.GCalRemoteDataSource>(() =>
      _i8.GoogleAPIGCalRemoteDataSoure(gCalSignIn: get<_i3.GoogleSignIn>()));
  gh.lazySingleton<_i9.GCalRepository>(() => _i10.GoogleCalendarRepositoryImpl(
      remoteCalDataSource: get<_i8.GCalRemoteDataSource>(),
      localCalDataSource: get<_i7.GCalLocalDataSource>(),
      networkInfo: get<_i5.NetworkInfo>()));
  gh.lazySingleton<_i11.GetGoogleEvents>(
      () => _i11.GetGoogleEvents(get<_i9.GCalRepository>()));
  gh.factory<_i12.GcalBloc>(
      () => _i12.GcalBloc(getAllCalendarEntry: get<_i11.GetGoogleEvents>()));
  return get;
}

class _$RegisterModule extends _i13.RegisterModule {}
