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

import 'core/injectable_module.dart' as _i44;
import 'core/network/network_info.dart' as _i11;
import 'core/presentation/bloc/today_bloc.dart' as _i38;
import 'core/presentation/helper/notes_stream.dart' as _i12;
import 'core/presentation/helper/page_stream.dart' as _i13;
import 'core/presentation/helper/setting_option.dart' as _i14;
import 'core/presentation/helper/sliding_body_stream.dart' as _i15;
import 'core/presentation/helper/subtask_stream.dart' as _i16;
import 'core/presentation/helper/text_stream.dart' as _i20;
import 'features/calendar/data/datasources/gcal_local_data_source.dart' as _i8;
import 'features/calendar/data/datasources/gcal_remote_data_source.dart'
    as _i27;
import 'features/calendar/data/repositories/calendar_repository_impl.dart'
    as _i33;
import 'features/calendar/domain/entities/calendar_entry.dart' as _i6;
import 'features/calendar/domain/entities/calendar_event_entry.dart' as _i5;
import 'features/calendar/domain/repositories/calendar_repository.dart' as _i32;
import 'features/calendar/domain/usecases/add_event.dart' as _i41;
import 'features/calendar/domain/usecases/delete_event.dart' as _i34;
import 'features/calendar/domain/usecases/get_calendar_list.dart' as _i35;
import 'features/calendar/domain/usecases/get_events.dart' as _i36;
import 'features/calendar/domain/usecases/get_events_between.dart' as _i37;
import 'features/calendar/domain/usecases/update_calendar_list.dart' as _i39;
import 'features/calendar/domain/usecases/update_event.dart' as _i40;
import 'features/calendar/presentation/bloc/calendar/calendar_bloc.dart'
    as _i42;
import 'features/calendar/presentation/bloc/calendar/datetime_stream.dart'
    as _i7;
import 'features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart'
    as _i43;
import 'features/task/data/datasources/aws_data_source.dart' as _i17;
import 'features/task/data/datasources/aws_stream.dart' as _i3;
import 'features/task/data/repositories/task_repository_impl.dart' as _i19;
import 'features/task/domain/repositories/task_repository.dart' as _i18;
import 'features/task/domain/usecases/project/create_project.dart' as _i23;
import 'features/task/domain/usecases/project/delete_project.dart' as _i25;
import 'features/task/domain/usecases/project/get_projects.dart' as _i28;
import 'features/task/domain/usecases/project/update_project.dart' as _i21;
import 'features/task/domain/usecases/task/create_tasks.dart' as _i24;
import 'features/task/domain/usecases/task/delete_task.dart' as _i26;
import 'features/task/domain/usecases/task/get_task.dart' as _i29;
import 'features/task/domain/usecases/task/update_task.dart' as _i22;
import 'features/task/presentation/bloc/project_bloc.dart' as _i30;
import 'features/task/presentation/bloc/task_bloc.dart'
    as _i31; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i12.NotesStream>(() => _i12.NotesStream());
  gh.singleton<_i13.PageStream>(_i13.PageStream());
  gh.lazySingleton<_i14.SettingOption>(() => _i14.SettingOption());
  gh.singleton<_i15.SlidingBodyStream>(_i15.SlidingBodyStream());
  gh.lazySingleton<_i16.SubTaskStream>(() => _i16.SubTaskStream());
  gh.lazySingleton<_i17.TaskRemoteDataSource>(
      () => _i17.AWSTaskRemoteDataSource());
  gh.lazySingleton<_i18.TaskRepository>(() => _i19.TaskRepositoryImpl(
      remoteDataSource: get<_i17.TaskRemoteDataSource>()));
  gh.lazySingleton<_i20.TextStream>(() => _i20.TextStream());
  gh.lazySingleton<_i21.UpdateProject>(
      () => _i21.UpdateProject(get<_i18.TaskRepository>()));
  gh.lazySingleton<_i22.UpdateTask>(
      () => _i22.UpdateTask(get<_i18.TaskRepository>()));
  gh.lazySingleton<_i23.CreateProject>(
      () => _i23.CreateProject(get<_i18.TaskRepository>()));
  gh.lazySingleton<_i24.CreateTasks>(
      () => _i24.CreateTasks(get<_i18.TaskRepository>()));
  gh.lazySingleton<_i25.DeleteProject>(
      () => _i25.DeleteProject(get<_i18.TaskRepository>()));
  gh.lazySingleton<_i26.DeleteTask>(
      () => _i26.DeleteTask(get<_i18.TaskRepository>()));
  gh.lazySingleton<_i27.GCalRemoteDataSource>(() =>
      _i27.GoogleAPIGCalRemoteDataSoure(gCalSignIn: get<_i9.GoogleSignIn>()));
  gh.lazySingleton<_i28.GetProjects>(
      () => _i28.GetProjects(get<_i18.TaskRepository>()));
  gh.lazySingleton<_i29.GetTasks>(
      () => _i29.GetTasks(get<_i18.TaskRepository>()));
  gh.factory<_i30.ProjectBloc>(() => _i30.ProjectBloc(
      getProjects: get<_i28.GetProjects>(),
      updateProject: get<_i21.UpdateProject>(),
      deleteProject: get<_i25.DeleteProject>(),
      createProject: get<_i23.CreateProject>()));
  gh.factory<_i31.TaskBloc>(() => _i31.TaskBloc(
      getTasks: get<_i29.GetTasks>(),
      updateTask: get<_i22.UpdateTask>(),
      deleteTask: get<_i26.DeleteTask>(),
      createTasks: get<_i24.CreateTasks>()));
  gh.lazySingleton<_i32.CalendarRepository>(() => _i33.CalendarRepositoryImpl(
      remoteCalDataSource: get<_i27.GCalRemoteDataSource>(),
      localCalDataSource: get<_i8.GCalLocalDataSource>(),
      networkInfo: get<_i11.NetworkInfo>()));
  gh.lazySingleton<_i34.DeleteEvent>(
      () => _i34.DeleteEvent(repository: get<_i32.CalendarRepository>()));
  gh.lazySingleton<_i35.GetCalendarList>(
      () => _i35.GetCalendarList(repository: get<_i32.CalendarRepository>()));
  gh.lazySingleton<_i36.GetEvents>(
      () => _i36.GetEvents(get<_i32.CalendarRepository>()));
  gh.lazySingleton<_i37.GetEventsBetween>(
      () => _i37.GetEventsBetween(get<_i32.CalendarRepository>()));
  gh.factory<_i38.TodayBloc>(() => _i38.TodayBloc(
      getEventEntry: get<_i37.GetEventsBetween>(),
      getTasks: get<_i29.GetTasks>()));
  gh.lazySingleton<_i39.UpdateCalendarList>(() =>
      _i39.UpdateCalendarList(repository: get<_i32.CalendarRepository>()));
  gh.lazySingleton<_i40.UpdateEvent>(
      () => _i40.UpdateEvent(repository: get<_i32.CalendarRepository>()));
  gh.lazySingleton<_i41.AddEvent>(
      () => _i41.AddEvent(repository: get<_i32.CalendarRepository>()));
  gh.factory<_i42.CalendarBloc>(() => _i42.CalendarBloc(
      getCalendarEntry: get<_i36.GetEvents>(),
      addEvent: get<_i41.AddEvent>(),
      deleteEvent: get<_i34.DeleteEvent>(),
      updateEvent: get<_i40.UpdateEvent>(),
      getCalendarList: get<_i35.GetCalendarList>()));
  gh.factory<_i43.CalendarListBloc>(() => _i43.CalendarListBloc(
      getCalendarList: get<_i35.GetCalendarList>(),
      updateCalendarList: get<_i39.UpdateCalendarList>()));
  return get;
}

class _$RegisterModule extends _i44.RegisterModule {}
