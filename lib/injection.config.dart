// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i22;
import 'package:hive_flutter/hive_flutter.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i8;

import 'core/injectable_module.dart' as _i41;
import 'core/network/network_info.dart' as _i9;
import 'core/presentation/bloc/today_bloc.dart' as _i33;
import 'core/presentation/helper/page_stream.dart' as _i40;
import 'core/presentation/helper/setting_option.dart' as _i10;
import 'core/presentation/helper/text_stream.dart' as _i14;
import 'features/calendar/data/datasources/gcal_local_data_source.dart' as _i7;
import 'features/calendar/data/datasources/gcal_remote_data_source.dart'
    as _i21;
import 'features/calendar/data/repositories/calendar_repository_impl.dart'
    as _i28;
import 'features/calendar/domain/entities/calendar_entry.dart' as _i5;
import 'features/calendar/domain/entities/calendar_event_entry.dart' as _i6;
import 'features/calendar/domain/repositories/calendar_repository.dart' as _i27;
import 'features/calendar/domain/usecases/add_event.dart' as _i36;
import 'features/calendar/domain/usecases/delete_event.dart' as _i29;
import 'features/calendar/domain/usecases/get_calendar_list.dart' as _i30;
import 'features/calendar/domain/usecases/get_events.dart' as _i31;
import 'features/calendar/domain/usecases/get_events_between.dart' as _i32;
import 'features/calendar/domain/usecases/update_calendar_list.dart' as _i34;
import 'features/calendar/domain/usecases/update_event.dart' as _i35;
import 'features/calendar/presentation/bloc/calendar/calendar_bloc.dart'
    as _i37;
import 'features/calendar/presentation/bloc/calendar/datetime_stream.dart'
    as _i39;
import 'features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart'
    as _i38;
import 'features/task/data/datasources/aws_data_source.dart' as _i11;
import 'features/task/data/datasources/aws_stream.dart' as _i3;
import 'features/task/data/repositories/task_repository_impl.dart' as _i13;
import 'features/task/domain/repositories/task_repository.dart' as _i12;
import 'features/task/domain/usecases/project/create_project.dart' as _i17;
import 'features/task/domain/usecases/project/delete_project.dart' as _i19;
import 'features/task/domain/usecases/project/get_projects.dart' as _i23;
import 'features/task/domain/usecases/project/update_project.dart' as _i15;
import 'features/task/domain/usecases/task/create_tasks.dart' as _i18;
import 'features/task/domain/usecases/task/delete_task.dart' as _i20;
import 'features/task/domain/usecases/task/get_task.dart' as _i24;
import 'features/task/domain/usecases/task/update_task.dart' as _i16;
import 'features/task/presentation/bloc/project_bloc.dart' as _i25;
import 'features/task/presentation/bloc/task_bloc.dart'
    as _i26; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.AwsStream>(() => _i3.AwsStream());
  await gh.factoryAsync<_i4.Box<_i5.CalendarEntry>>(
      () => registerModule.calendarBox,
      preResolve: true);
  await gh.factoryAsync<_i4.Box<_i6.CalendarEventEntry>>(
      () => registerModule.gcalEventsBox,
      preResolve: true);
  gh.lazySingleton<_i7.GCalLocalDataSource>(() => _i7.HiveGCalLocalDataSource(
      calendarBox: get<_i4.Box<_i5.CalendarEntry>>(),
      gcalEventsBox: get<_i4.Box<_i6.CalendarEventEntry>>()));
  gh.lazySingleton<_i8.InternetConnectionChecker>(
      () => registerModule.internetChecker);
  gh.lazySingleton<_i9.NetworkInfo>(
      () => _i9.NetworkInfoImpl(get<_i8.InternetConnectionChecker>()));
  gh.lazySingleton<_i10.SettingOption>(() => _i10.SettingOption());
  gh.lazySingleton<_i11.TaskRemoteDataSource>(
      () => _i11.AWSTaskRemoteDataSource());
  gh.lazySingleton<_i12.TaskRepository>(() => _i13.TaskRepositoryImpl(
      remoteDataSource: get<_i11.TaskRemoteDataSource>()));
  gh.lazySingleton<_i14.TextStream>(() => _i14.TextStream());
  gh.lazySingleton<_i15.UpdateProject>(
      () => _i15.UpdateProject(get<_i12.TaskRepository>()));
  gh.lazySingleton<_i16.UpdateTask>(
      () => _i16.UpdateTask(get<_i12.TaskRepository>()));
  gh.lazySingleton<_i17.CreateProject>(
      () => _i17.CreateProject(get<_i12.TaskRepository>()));
  gh.lazySingleton<_i18.CreateTasks>(
      () => _i18.CreateTasks(get<_i12.TaskRepository>()));
  gh.lazySingleton<_i19.DeleteProject>(
      () => _i19.DeleteProject(get<_i12.TaskRepository>()));
  gh.lazySingleton<_i20.DeleteTask>(
      () => _i20.DeleteTask(get<_i12.TaskRepository>()));
  gh.lazySingleton<_i21.GCalRemoteDataSource>(() =>
      _i21.GoogleAPIGCalRemoteDataSoure(gCalSignIn: get<_i22.GoogleSignIn>()));
  gh.lazySingleton<_i23.GetProjects>(
      () => _i23.GetProjects(get<_i12.TaskRepository>()));
  gh.lazySingleton<_i24.GetTasks>(
      () => _i24.GetTasks(get<_i12.TaskRepository>()));
  gh.factory<_i25.ProjectBloc>(() => _i25.ProjectBloc(
      getProjects: get<_i23.GetProjects>(),
      updateProject: get<_i15.UpdateProject>(),
      deleteProject: get<_i19.DeleteProject>(),
      createProject: get<_i17.CreateProject>()));
  gh.factory<_i26.TaskBloc>(() => _i26.TaskBloc(
      getTasks: get<_i24.GetTasks>(),
      updateTask: get<_i16.UpdateTask>(),
      deleteTask: get<_i20.DeleteTask>(),
      createTasks: get<_i18.CreateTasks>()));
  gh.lazySingleton<_i27.CalendarRepository>(() => _i28.CalendarRepositoryImpl(
      remoteCalDataSource: get<_i21.GCalRemoteDataSource>(),
      localCalDataSource: get<_i7.GCalLocalDataSource>(),
      networkInfo: get<_i9.NetworkInfo>()));
  gh.lazySingleton<_i29.DeleteEvent>(
      () => _i29.DeleteEvent(repository: get<_i27.CalendarRepository>()));
  gh.lazySingleton<_i30.GetCalendarList>(
      () => _i30.GetCalendarList(repository: get<_i27.CalendarRepository>()));
  gh.lazySingleton<_i31.GetEvents>(
      () => _i31.GetEvents(get<_i27.CalendarRepository>()));
  gh.lazySingleton<_i32.GetEventsBetween>(
      () => _i32.GetEventsBetween(get<_i27.CalendarRepository>()));
  gh.factory<_i33.TodayBloc>(() => _i33.TodayBloc(
      getEventEntry: get<_i32.GetEventsBetween>(),
      getTasks: get<_i24.GetTasks>()));
  gh.lazySingleton<_i34.UpdateCalendarList>(() =>
      _i34.UpdateCalendarList(repository: get<_i27.CalendarRepository>()));
  gh.lazySingleton<_i35.UpdateEvent>(
      () => _i35.UpdateEvent(repository: get<_i27.CalendarRepository>()));
  gh.lazySingleton<_i36.AddEvent>(
      () => _i36.AddEvent(repository: get<_i27.CalendarRepository>()));
  gh.factory<_i37.CalendarBloc>(() => _i37.CalendarBloc(
      getCalendarEntry: get<_i31.GetEvents>(),
      addEvent: get<_i36.AddEvent>(),
      deleteEvent: get<_i29.DeleteEvent>(),
      updateEvent: get<_i35.UpdateEvent>(),
      getCalendarList: get<_i30.GetCalendarList>()));
  gh.factory<_i38.CalendarListBloc>(() => _i38.CalendarListBloc(
      getCalendarList: get<_i30.GetCalendarList>(),
      updateCalendarList: get<_i34.UpdateCalendarList>()));
  gh.singleton<_i39.DateTimeStream>(_i39.DateTimeStream());
  gh.singleton<_i22.GoogleSignIn>(registerModule.gCalSignIn);
  gh.singleton<_i40.PageStream>(_i40.PageStream());
  return get;
}

class _$RegisterModule extends _i41.RegisterModule {}
