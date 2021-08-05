// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i3;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import 'core/injectable_module.dart' as _i18;
import 'core/network/network_info.dart' as _i4;
import 'features/calendar/data/datasources/gcal_local_data_source.dart' as _i6;
import 'features/calendar/data/datasources/gcal_remote_data_source.dart' as _i7;
import 'features/calendar/data/repositories/calendar_repository_impl.dart'
    as _i10;
import 'features/calendar/domain/repositories/calendar_repository.dart' as _i9;
import 'features/calendar/domain/usecases/add_event.dart' as _i16;
import 'features/calendar/domain/usecases/delete_event.dart' as _i11;
import 'features/calendar/domain/usecases/get_events.dart' as _i12;
import 'features/calendar/domain/usecases/get_events_day.dart' as _i13;
import 'features/calendar/domain/usecases/get_events_month.dart' as _i14;
import 'features/calendar/domain/usecases/update_event.dart' as _i15;
import 'features/calendar/presentation/bloc/calendar_bloc.dart'
    as _i17; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.InternetConnectionChecker>(
      () => registerModule.internetChecker);
  gh.lazySingleton<_i4.NetworkInfo>(
      () => _i4.NetworkInfoImpl(get<_i3.InternetConnectionChecker>()));
  await gh.factoryAsync<_i5.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.lazySingleton<_i6.GCalLocalDataSource>(() =>
      _i6.SharedPrefGCalLocalDataSource(
          sharedPreferences: get<_i5.SharedPreferences>()));
  gh.lazySingleton<_i7.GCalRemoteDataSource>(() =>
      _i7.GoogleAPIGCalRemoteDataSoure(gCalSignIn: get<_i8.GoogleSignIn>()));
  gh.lazySingleton<_i9.CalendarRepository>(() => _i10.CalendarRepositoryImpl(
      remoteCalDataSource: get<_i7.GCalRemoteDataSource>(),
      localCalDataSource: get<_i6.GCalLocalDataSource>(),
      networkInfo: get<_i4.NetworkInfo>()));
  gh.lazySingleton<_i11.DeleteEvent>(
      () => _i11.DeleteEvent(repository: get<_i9.CalendarRepository>()));
  gh.lazySingleton<_i12.GetEvents>(
      () => _i12.GetEvents(get<_i9.CalendarRepository>()));
  gh.lazySingleton<_i13.GetEventsOfDay>(
      () => _i13.GetEventsOfDay(get<_i9.CalendarRepository>()));
  gh.lazySingleton<_i14.GetEventsOfMonth>(
      () => _i14.GetEventsOfMonth(get<_i9.CalendarRepository>()));
  gh.lazySingleton<_i15.UpdateEvent>(
      () => _i15.UpdateEvent(repository: get<_i9.CalendarRepository>()));
  gh.lazySingleton<_i16.AddEvent>(
      () => _i16.AddEvent(repository: get<_i9.CalendarRepository>()));
  gh.factory<_i17.CalendarBloc>(() => _i17.CalendarBloc(
      getCalendarEntry: get<_i12.GetEvents>(),
      addEvent: get<_i16.AddEvent>(),
      deleteEvent: get<_i11.DeleteEvent>(),
      updateEvent: get<_i15.UpdateEvent>()));
  gh.singleton<_i8.GoogleSignIn>(registerModule.gCalSignIn);
  return get;
}

class _$RegisterModule extends _i18.RegisterModule {}
