// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i9;
import 'package:hive_flutter/hive_flutter.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i10;

import 'core/injectable_module.dart' as _i42;
import 'core/network/network_info.dart' as _i11;
import 'core/presentation/bloc/today_bloc.dart' as _i36;
import 'core/presentation/helper/page_stream.dart' as _i12;
import 'core/presentation/helper/setting_option.dart' as _i13;
import 'core/presentation/helper/sliding_body_stream.dart' as _i14;
import 'core/presentation/helper/text_stream.dart' as _i18;
import 'features/calendar/data/datasources/gcal_local_data_source.dart' as _i8;
import 'features/calendar/data/datasources/gcal_remote_data_source.dart'
    as _i25;
import 'features/calendar/data/repositories/calendar_repository_impl.dart'
    as _i31;
import 'features/calendar/domain/entities/calendar_entry.dart' as _i6;
import 'features/calendar/domain/entities/calendar_event_entry.dart' as _i5;
import 'features/calendar/domain/repositories/calendar_repository.dart' as _i30;
import 'features/calendar/domain/usecases/add_event.dart' as _i39;
import 'features/calendar/domain/usecases/delete_event.dart' as _i32;
import 'features/calendar/domain/usecases/get_calendar_list.dart' as _i33;
import 'features/calendar/domain/usecases/get_events.dart' as _i34;
import 'features/calendar/domain/usecases/get_events_between.dart' as _i35;
import 'features/calendar/domain/usecases/update_calendar_list.dart' as _i37;
import 'features/calendar/domain/usecases/update_event.dart' as _i38;
import 'features/calendar/presentation/bloc/calendar/calendar_bloc.dart'
    as _i40;
import 'features/calendar/presentation/bloc/calendar/datetime_stream.dart'
    as _i7;
import 'features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart'
    as _i41;
import 'features/task/data/datasources/aws_data_source.dart' as _i15;
import 'features/task/data/datasources/aws_stream.dart' as _i3;
import 'features/task/data/repositories/task_repository_impl.dart' as _i17;
import 'features/task/domain/repositories/task_repository.dart' as _i16;
import 'features/task/domain/usecases/project/create_project.dart' as _i21;
import 'features/task/domain/usecases/project/delete_project.dart' as _i23;
import 'features/task/domain/usecases/project/get_projects.dart' as _i26;
import 'features/task/domain/usecases/project/update_project.dart' as _i19;
import 'features/task/domain/usecases/task/create_tasks.dart' as _i22;
import 'features/task/domain/usecases/task/delete_task.dart' as _i24;
import 'features/task/domain/usecases/task/get_task.dart' as _i27;
import 'features/task/domain/usecases/task/update_task.dart' as _i20;
import 'features/task/presentation/bloc/project_bloc.dart' as _i28;
import 'features/task/presentation/bloc/task_bloc.dart'
    as _i29; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.AwsStream>(() => _i3.AwsStream());
  await gh.factoryAsync<_i4.Box<_i5.CalendarEventEntry>>(
      () => registerModule.gcalEventsBox,
      preResolve: true);
  await gh.factoryAsync<_i4.Box<_i6.CalendarEntry>>(
      () => registerModule.calendarBox,
      preResolve: true);
  gh.singleton<_i7.DateTimeStream>(_i7.DateTimeStream());
  gh.lazySingleton<_i8.GCalLocalDataSource>(() => _i8.HiveGCalLocalDataSource(
      calendarBox: get<_i4.Box<_i6.CalendarEntry>>(),
      gcalEventsBox: get<_i4.Box<_i5.CalendarEventEntry>>()));
  gh.singleton<_i9.GoogleSignIn>(registerModule.gCalSignIn);
  gh.lazySingleton<_i10.InternetConnectionChecker>(
      () => registerModule.internetChecker);
  gh.lazySingleton<_i11.NetworkInfo>(
      () => _i11.NetworkInfoImpl(get<_i10.InternetConnectionChecker>()));
  gh.singleton<_i12.PageStream>(_i12.PageStream());
  gh.lazySingleton<_i13.SettingOption>(() => _i13.SettingOption());
  gh.singleton<_i14.SlidingBodyStream>(_i14.SlidingBodyStream());
  gh.lazySingleton<_i15.TaskRemoteDataSource>(
      () => _i15.AWSTaskRemoteDataSource());
  gh.lazySingleton<_i16.TaskRepository>(() => _i17.TaskRepositoryImpl(
      remoteDataSource: get<_i15.TaskRemoteDataSource>()));
  gh.lazySingleton<_i18.TextStream>(() => _i18.TextStream());
  gh.lazySingleton<_i19.UpdateProject>(
      () => _i19.UpdateProject(get<_i16.TaskRepository>()));
  gh.lazySingleton<_i20.UpdateTask>(
      () => _i20.UpdateTask(get<_i16.TaskRepository>()));
  gh.lazySingleton<_i21.CreateProject>(
      () => _i21.CreateProject(get<_i16.TaskRepository>()));
  gh.lazySingleton<_i22.CreateTasks>(
      () => _i22.CreateTasks(get<_i16.TaskRepository>()));
  gh.lazySingleton<_i23.DeleteProject>(
      () => _i23.DeleteProject(get<_i16.TaskRepository>()));
  gh.lazySingleton<_i24.DeleteTask>(
      () => _i24.DeleteTask(get<_i16.TaskRepository>()));
  gh.lazySingleton<_i25.GCalRemoteDataSource>(() =>
      _i25.GoogleAPIGCalRemoteDataSoure(gCalSignIn: get<_i9.GoogleSignIn>()));
  gh.lazySingleton<_i26.GetProjects>(
      () => _i26.GetProjects(get<_i16.TaskRepository>()));
  gh.lazySingleton<_i27.GetTasks>(
      () => _i27.GetTasks(get<_i16.TaskRepository>()));
  gh.factory<_i28.ProjectBloc>(() => _i28.ProjectBloc(
      getProjects: get<_i26.GetProjects>(),
      updateProject: get<_i19.UpdateProject>(),
      deleteProject: get<_i23.DeleteProject>(),
      createProject: get<_i21.CreateProject>()));
  gh.factory<_i29.TaskBloc>(() => _i29.TaskBloc(
      getTasks: get<_i27.GetTasks>(),
      updateTask: get<_i20.UpdateTask>(),
      deleteTask: get<_i24.DeleteTask>(),
      createTasks: get<_i22.CreateTasks>()));
  gh.lazySingleton<_i30.CalendarRepository>(() => _i31.CalendarRepositoryImpl(
      remoteCalDataSource: get<_i25.GCalRemoteDataSource>(),
      localCalDataSource: get<_i8.GCalLocalDataSource>(),
      networkInfo: get<_i11.NetworkInfo>()));
  gh.lazySingleton<_i32.DeleteEvent>(
      () => _i32.DeleteEvent(repository: get<_i30.CalendarRepository>()));
  gh.lazySingleton<_i33.GetCalendarList>(
      () => _i33.GetCalendarList(repository: get<_i30.CalendarRepository>()));
  gh.lazySingleton<_i34.GetEvents>(
      () => _i34.GetEvents(get<_i30.CalendarRepository>()));
  gh.lazySingleton<_i35.GetEventsBetween>(
      () => _i35.GetEventsBetween(get<_i30.CalendarRepository>()));
  gh.factory<_i36.TodayBloc>(() => _i36.TodayBloc(
      getEventEntry: get<_i35.GetEventsBetween>(),
      getTasks: get<_i27.GetTasks>()));
  gh.lazySingleton<_i37.UpdateCalendarList>(() =>
      _i37.UpdateCalendarList(repository: get<_i30.CalendarRepository>()));
  gh.lazySingleton<_i38.UpdateEvent>(
      () => _i38.UpdateEvent(repository: get<_i30.CalendarRepository>()));
  gh.lazySingleton<_i39.AddEvent>(
      () => _i39.AddEvent(repository: get<_i30.CalendarRepository>()));
  gh.factory<_i40.CalendarBloc>(() => _i40.CalendarBloc(
      getCalendarEntry: get<_i34.GetEvents>(),
      addEvent: get<_i39.AddEvent>(),
      deleteEvent: get<_i32.DeleteEvent>(),
      updateEvent: get<_i38.UpdateEvent>(),
      getCalendarList: get<_i33.GetCalendarList>()));
  gh.factory<_i41.CalendarListBloc>(() => _i41.CalendarListBloc(
      getCalendarList: get<_i33.GetCalendarList>(),
      updateCalendarList: get<_i37.UpdateCalendarList>()));
  return get;
}

class _$RegisterModule extends _i42.RegisterModule {}
