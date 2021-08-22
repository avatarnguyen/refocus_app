// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i20;
import 'package:hive_flutter/hive_flutter.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i7;

import 'core/injectable_module.dart' as _i36;
import 'core/network/network_info.dart' as _i8;
import 'core/presentation/text_stream.dart' as _i12;
import 'features/calendar/data/datasources/gcal_local_data_source.dart' as _i6;
import 'features/calendar/data/datasources/gcal_remote_data_source.dart'
    as _i19;
import 'features/calendar/data/repositories/calendar_repository_impl.dart'
    as _i25;
import 'features/calendar/domain/entities/calendar_entry.dart' as _i5;
import 'features/calendar/domain/entities/calendar_event_entry.dart' as _i4;
import 'features/calendar/domain/repositories/calendar_repository.dart' as _i24;
import 'features/calendar/domain/usecases/add_event.dart' as _i32;
import 'features/calendar/domain/usecases/delete_event.dart' as _i26;
import 'features/calendar/domain/usecases/get_calendar_list.dart' as _i27;
import 'features/calendar/domain/usecases/get_events.dart' as _i28;
import 'features/calendar/domain/usecases/get_events_between.dart' as _i29;
import 'features/calendar/domain/usecases/update_calendar_list.dart' as _i30;
import 'features/calendar/domain/usecases/update_event.dart' as _i31;
import 'features/calendar/presentation/bloc/calendar/calendar_bloc.dart'
    as _i33;
import 'features/calendar/presentation/bloc/calendar/datetime_stream.dart'
    as _i35;
import 'features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart'
    as _i34;
import 'features/task/data/datasources/aws_data_source.dart' as _i9;
import 'features/task/data/repositories/task_repository_impl.dart' as _i11;
import 'features/task/domain/repositories/task_repository.dart' as _i10;
import 'features/task/domain/usecases/project/create_project.dart' as _i15;
import 'features/task/domain/usecases/project/delete_project.dart' as _i17;
import 'features/task/domain/usecases/project/get_projects.dart' as _i21;
import 'features/task/domain/usecases/project/update_project.dart' as _i13;
import 'features/task/domain/usecases/task/create_tasks.dart' as _i16;
import 'features/task/domain/usecases/task/delete_task.dart' as _i18;
import 'features/task/domain/usecases/task/get_task.dart' as _i22;
import 'features/task/domain/usecases/task/update_task.dart' as _i14;
import 'features/task/presentation/bloc/task_bloc.dart'
    as _i23; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i9.TaskRemoteDataSource>(
      () => _i9.AWSTaskRemoteDataSource());
  gh.lazySingleton<_i10.TaskRepository>(() => _i11.TaskRepositoryImpl(
      remoteDataSource: get<_i9.TaskRemoteDataSource>()));
  gh.lazySingleton<_i12.TextStream>(() => _i12.TextStream());
  gh.lazySingleton<_i13.UpdateProject>(
      () => _i13.UpdateProject(get<_i10.TaskRepository>()));
  gh.lazySingleton<_i14.UpdateTask>(
      () => _i14.UpdateTask(get<_i10.TaskRepository>()));
  gh.lazySingleton<_i15.CreateProject>(
      () => _i15.CreateProject(get<_i10.TaskRepository>()));
  gh.lazySingleton<_i16.CreateTasks>(
      () => _i16.CreateTasks(get<_i10.TaskRepository>()));
  gh.lazySingleton<_i17.DeleteProject>(
      () => _i17.DeleteProject(get<_i10.TaskRepository>()));
  gh.lazySingleton<_i18.DeleteTask>(
      () => _i18.DeleteTask(get<_i10.TaskRepository>()));
  gh.lazySingleton<_i19.GCalRemoteDataSource>(() =>
      _i19.GoogleAPIGCalRemoteDataSoure(gCalSignIn: get<_i20.GoogleSignIn>()));
  gh.lazySingleton<_i21.GetProjects>(
      () => _i21.GetProjects(get<_i10.TaskRepository>()));
  gh.lazySingleton<_i22.GetTasks>(
      () => _i22.GetTasks(get<_i10.TaskRepository>()));
  gh.factory<_i23.TaskBloc>(() => _i23.TaskBloc(
      getProjects: get<_i21.GetProjects>(),
      updateProject: get<_i13.UpdateProject>(),
      deleteProject: get<_i17.DeleteProject>(),
      createProject: get<_i15.CreateProject>()));
  gh.lazySingleton<_i24.CalendarRepository>(() => _i25.CalendarRepositoryImpl(
      remoteCalDataSource: get<_i19.GCalRemoteDataSource>(),
      localCalDataSource: get<_i6.GCalLocalDataSource>(),
      networkInfo: get<_i8.NetworkInfo>()));
  gh.lazySingleton<_i26.DeleteEvent>(
      () => _i26.DeleteEvent(repository: get<_i24.CalendarRepository>()));
  gh.lazySingleton<_i27.GetCalendarList>(
      () => _i27.GetCalendarList(repository: get<_i24.CalendarRepository>()));
  gh.lazySingleton<_i28.GetEvents>(
      () => _i28.GetEvents(get<_i24.CalendarRepository>()));
  gh.lazySingleton<_i29.GetEventsBetween>(
      () => _i29.GetEventsBetween(get<_i24.CalendarRepository>()));
  gh.lazySingleton<_i30.UpdateCalendarList>(() =>
      _i30.UpdateCalendarList(repository: get<_i24.CalendarRepository>()));
  gh.lazySingleton<_i31.UpdateEvent>(
      () => _i31.UpdateEvent(repository: get<_i24.CalendarRepository>()));
  gh.lazySingleton<_i32.AddEvent>(
      () => _i32.AddEvent(repository: get<_i24.CalendarRepository>()));
  gh.factory<_i33.CalendarBloc>(() => _i33.CalendarBloc(
      getCalendarEntry: get<_i28.GetEvents>(),
      addEvent: get<_i32.AddEvent>(),
      deleteEvent: get<_i26.DeleteEvent>(),
      updateEvent: get<_i31.UpdateEvent>(),
      getCalendarList: get<_i27.GetCalendarList>()));
  gh.factory<_i34.CalendarListBloc>(() => _i34.CalendarListBloc(
      getCalendarList: get<_i27.GetCalendarList>(),
      updateCalendarList: get<_i30.UpdateCalendarList>()));
  gh.singleton<_i35.DateTimeStream>(_i35.DateTimeStream());
  gh.singleton<_i20.GoogleSignIn>(registerModule.gCalSignIn);
  return get;
}

class _$RegisterModule extends _i36.RegisterModule {}
