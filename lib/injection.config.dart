// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i10;
import 'package:hive_flutter/hive_flutter.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i11;

import 'core/injectable_module.dart' as _i45;
import 'core/network/network_info.dart' as _i12;
import 'core/presentation/bloc/today_bloc.dart' as _i39;
import 'core/presentation/helper/action_stream.dart' as _i3;
import 'core/presentation/helper/notes_stream.dart' as _i13;
import 'core/presentation/helper/page_stream.dart' as _i14;
import 'core/presentation/helper/setting_option.dart' as _i15;
import 'core/presentation/helper/sliding_body_stream.dart' as _i16;
import 'core/presentation/helper/subtask_stream.dart' as _i17;
import 'core/presentation/helper/text_stream.dart' as _i21;
import 'features/calendar/data/datasources/gcal_local_data_source.dart' as _i9;
import 'features/calendar/data/datasources/gcal_remote_data_source.dart'
    as _i28;
import 'features/calendar/data/repositories/calendar_repository_impl.dart'
    as _i34;
import 'features/calendar/domain/entities/calendar_entry.dart' as _i7;
import 'features/calendar/domain/entities/calendar_event_entry.dart' as _i6;
import 'features/calendar/domain/repositories/calendar_repository.dart' as _i33;
import 'features/calendar/domain/usecases/add_event.dart' as _i42;
import 'features/calendar/domain/usecases/delete_event.dart' as _i35;
import 'features/calendar/domain/usecases/get_calendar_list.dart' as _i36;
import 'features/calendar/domain/usecases/get_events.dart' as _i37;
import 'features/calendar/domain/usecases/get_events_between.dart' as _i38;
import 'features/calendar/domain/usecases/update_calendar_list.dart' as _i40;
import 'features/calendar/domain/usecases/update_event.dart' as _i41;
import 'features/calendar/presentation/bloc/calendar/calendar_bloc.dart'
    as _i43;
import 'features/calendar/presentation/bloc/calendar/datetime_stream.dart'
    as _i8;
import 'features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart'
    as _i44;
import 'features/task/data/datasources/aws_data_source.dart' as _i18;
import 'features/task/data/datasources/aws_stream.dart' as _i4;
import 'features/task/data/repositories/task_repository_impl.dart' as _i20;
import 'features/task/domain/repositories/task_repository.dart' as _i19;
import 'features/task/domain/usecases/project/create_project.dart' as _i24;
import 'features/task/domain/usecases/project/delete_project.dart' as _i26;
import 'features/task/domain/usecases/project/get_projects.dart' as _i29;
import 'features/task/domain/usecases/project/update_project.dart' as _i22;
import 'features/task/domain/usecases/task/create_tasks.dart' as _i25;
import 'features/task/domain/usecases/task/delete_task.dart' as _i27;
import 'features/task/domain/usecases/task/get_task.dart' as _i30;
import 'features/task/domain/usecases/task/update_task.dart' as _i23;
import 'features/task/presentation/bloc/project_bloc.dart' as _i31;
import 'features/task/presentation/bloc/task_bloc.dart'
    as _i32; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.ActionStream>(() => _i3.ActionStream());
  gh.lazySingleton<_i4.AwsStream>(() => _i4.AwsStream());
  await gh.factoryAsync<_i5.Box<_i6.CalendarEventEntry>>(
      () => registerModule.gcalEventsBox,
      preResolve: true);
  await gh.factoryAsync<_i5.Box<_i7.CalendarEntry>>(
      () => registerModule.calendarBox,
      preResolve: true);
  gh.singleton<_i8.DateTimeStream>(_i8.DateTimeStream());
  gh.lazySingleton<_i9.GCalLocalDataSource>(() => _i9.HiveGCalLocalDataSource(
      calendarBox: get<_i5.Box<_i7.CalendarEntry>>(),
      gcalEventsBox: get<_i5.Box<_i6.CalendarEventEntry>>()));
  gh.singleton<_i10.GoogleSignIn>(registerModule.gCalSignIn);
  gh.lazySingleton<_i11.InternetConnectionChecker>(
      () => registerModule.internetChecker);
  gh.lazySingleton<_i12.NetworkInfo>(
      () => _i12.NetworkInfoImpl(get<_i11.InternetConnectionChecker>()));
  gh.lazySingleton<_i13.NotesStream>(() => _i13.NotesStream());
  gh.singleton<_i14.PageStream>(_i14.PageStream());
  gh.lazySingleton<_i15.SettingOption>(() => _i15.SettingOption());
  gh.singleton<_i16.SlidingBodyStream>(_i16.SlidingBodyStream());
  gh.lazySingleton<_i17.SubTaskStream>(() => _i17.SubTaskStream());
  gh.lazySingleton<_i18.TaskRemoteDataSource>(
      () => _i18.AWSTaskRemoteDataSource());
  gh.lazySingleton<_i19.TaskRepository>(() => _i20.TaskRepositoryImpl(
      remoteDataSource: get<_i18.TaskRemoteDataSource>()));
  gh.lazySingleton<_i21.TextStream>(() => _i21.TextStream());
  gh.lazySingleton<_i22.UpdateProject>(
      () => _i22.UpdateProject(get<_i19.TaskRepository>()));
  gh.lazySingleton<_i23.UpdateTask>(
      () => _i23.UpdateTask(get<_i19.TaskRepository>()));
  gh.lazySingleton<_i24.CreateProject>(
      () => _i24.CreateProject(get<_i19.TaskRepository>()));
  gh.lazySingleton<_i25.CreateTasks>(
      () => _i25.CreateTasks(get<_i19.TaskRepository>()));
  gh.lazySingleton<_i26.DeleteProject>(
      () => _i26.DeleteProject(get<_i19.TaskRepository>()));
  gh.lazySingleton<_i27.DeleteTask>(
      () => _i27.DeleteTask(get<_i19.TaskRepository>()));
  gh.lazySingleton<_i28.GCalRemoteDataSource>(() =>
      _i28.GoogleAPIGCalRemoteDataSoure(gCalSignIn: get<_i10.GoogleSignIn>()));
  gh.lazySingleton<_i29.GetProjects>(
      () => _i29.GetProjects(get<_i19.TaskRepository>()));
  gh.lazySingleton<_i30.GetTasks>(
      () => _i30.GetTasks(get<_i19.TaskRepository>()));
  gh.factory<_i31.ProjectBloc>(() => _i31.ProjectBloc(
      getProjects: get<_i29.GetProjects>(),
      updateProject: get<_i22.UpdateProject>(),
      deleteProject: get<_i26.DeleteProject>(),
      createProject: get<_i24.CreateProject>()));
  gh.factory<_i32.TaskBloc>(() => _i32.TaskBloc(
      getTasks: get<_i30.GetTasks>(),
      updateTask: get<_i23.UpdateTask>(),
      deleteTask: get<_i27.DeleteTask>(),
      createTasks: get<_i25.CreateTasks>()));
  gh.lazySingleton<_i33.CalendarRepository>(() => _i34.CalendarRepositoryImpl(
      remoteCalDataSource: get<_i28.GCalRemoteDataSource>(),
      localCalDataSource: get<_i9.GCalLocalDataSource>(),
      networkInfo: get<_i12.NetworkInfo>()));
  gh.lazySingleton<_i35.DeleteEvent>(
      () => _i35.DeleteEvent(repository: get<_i33.CalendarRepository>()));
  gh.lazySingleton<_i36.GetCalendarList>(
      () => _i36.GetCalendarList(repository: get<_i33.CalendarRepository>()));
  gh.lazySingleton<_i37.GetEvents>(
      () => _i37.GetEvents(get<_i33.CalendarRepository>()));
  gh.lazySingleton<_i38.GetEventsBetween>(
      () => _i38.GetEventsBetween(get<_i33.CalendarRepository>()));
  gh.factory<_i39.TodayBloc>(() => _i39.TodayBloc(
      getEventEntry: get<_i38.GetEventsBetween>(),
      getTasks: get<_i30.GetTasks>()));
  gh.lazySingleton<_i40.UpdateCalendarList>(() =>
      _i40.UpdateCalendarList(repository: get<_i33.CalendarRepository>()));
  gh.lazySingleton<_i41.UpdateEvent>(
      () => _i41.UpdateEvent(repository: get<_i33.CalendarRepository>()));
  gh.lazySingleton<_i42.AddEvent>(
      () => _i42.AddEvent(repository: get<_i33.CalendarRepository>()));
  gh.factory<_i43.CalendarBloc>(() => _i43.CalendarBloc(
      getCalendarEntry: get<_i37.GetEvents>(),
      addEvent: get<_i42.AddEvent>(),
      deleteEvent: get<_i35.DeleteEvent>(),
      updateEvent: get<_i41.UpdateEvent>(),
      getCalendarList: get<_i36.GetCalendarList>()));
  gh.factory<_i44.CalendarListBloc>(() => _i44.CalendarListBloc(
      getCalendarList: get<_i36.GetCalendarList>(),
      updateCalendarList: get<_i40.UpdateCalendarList>()));
  return get;
}

class _$RegisterModule extends _i45.RegisterModule {}
