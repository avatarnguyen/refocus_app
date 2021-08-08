// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i10;
import 'package:hive_flutter/hive_flutter.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i7;

import 'core/injectable_module.dart' as _i20;
import 'core/network/network_info.dart' as _i8;
import 'features/calendar/data/datasources/gcal_local_data_source.dart' as _i6;
import 'features/calendar/data/datasources/gcal_remote_data_source.dart' as _i9;
import 'features/calendar/data/repositories/calendar_repository_impl.dart'
    as _i12;
import 'features/calendar/domain/entities/calendar_entry.dart' as _i5;
import 'features/calendar/domain/entities/calendar_event_entry.dart' as _i4;
import 'features/calendar/domain/repositories/calendar_repository.dart' as _i11;
import 'features/calendar/domain/usecases/add_event.dart' as _i18;
import 'features/calendar/domain/usecases/delete_event.dart' as _i13;
import 'features/calendar/domain/usecases/get_calendar_list.dart' as _i14;
import 'features/calendar/domain/usecases/get_events.dart' as _i15;
import 'features/calendar/domain/usecases/get_events_between.dart' as _i16;
import 'features/calendar/domain/usecases/update_event.dart' as _i17;
import 'features/calendar/presentation/bloc/calendar_bloc.dart'
    as _i19; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  await gh.factoryAsync<_i3.Box<_i4.CalendarEventEntry>>(
      () => registerModule.gcalEventsBox,
      preResolve: true);
  await gh.factoryAsync<_i3.Box<_i5.CalendarEntry>>(
      () => registerModule.calendarBox,
      preResolve: true);
  gh.lazySingleton<_i6.GCalLocalDataSource>(() => _i6.HiveGCalLocalDataSource(
      calendarBox: get<_i3.Box<_i5.CalendarEntry>>(),
      gcalEventsBox: get<_i3.Box<_i4.CalendarEventEntry>>()));
  gh.lazySingleton<_i7.InternetConnectionChecker>(
      () => registerModule.internetChecker);
  gh.lazySingleton<_i8.NetworkInfo>(
      () => _i8.NetworkInfoImpl(get<_i7.InternetConnectionChecker>()));
  gh.lazySingleton<_i9.GCalRemoteDataSource>(() =>
      _i9.GoogleAPIGCalRemoteDataSoure(gCalSignIn: get<_i10.GoogleSignIn>()));
  gh.lazySingleton<_i11.CalendarRepository>(() => _i12.CalendarRepositoryImpl(
      remoteCalDataSource: get<_i9.GCalRemoteDataSource>(),
      localCalDataSource: get<_i6.GCalLocalDataSource>(),
      networkInfo: get<_i8.NetworkInfo>()));
  gh.lazySingleton<_i13.DeleteEvent>(
      () => _i13.DeleteEvent(repository: get<_i11.CalendarRepository>()));
  gh.lazySingleton<_i14.GetCalendarList>(
      () => _i14.GetCalendarList(repository: get<_i11.CalendarRepository>()));
  gh.lazySingleton<_i15.GetEvents>(
      () => _i15.GetEvents(get<_i11.CalendarRepository>()));
  gh.lazySingleton<_i16.GetEventsBetween>(
      () => _i16.GetEventsBetween(get<_i11.CalendarRepository>()));
  gh.lazySingleton<_i17.UpdateEvent>(
      () => _i17.UpdateEvent(repository: get<_i11.CalendarRepository>()));
  gh.lazySingleton<_i18.AddEvent>(
      () => _i18.AddEvent(repository: get<_i11.CalendarRepository>()));
  gh.factory<_i19.CalendarBloc>(() => _i19.CalendarBloc(
      getCalendarEntry: get<_i15.GetEvents>(),
      addEvent: get<_i18.AddEvent>(),
      deleteEvent: get<_i13.DeleteEvent>(),
      updateEvent: get<_i17.UpdateEvent>()));
  gh.singleton<_i10.GoogleSignIn>(registerModule.gCalSignIn);
  return get;
}

class _$RegisterModule extends _i20.RegisterModule {}
