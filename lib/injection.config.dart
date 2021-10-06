// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i12;
import 'package:hive_flutter/hive_flutter.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i13;

import 'core/injectable_module.dart' as _i48;
import 'core/network/network_info.dart' as _i14;
import 'core/presentation/bloc/today_bloc.dart' as _i42;
import 'core/presentation/helper/action_stream.dart' as _i3;
import 'core/presentation/helper/edit_task_stream.dart' as _i10;
import 'core/presentation/helper/notes_stream.dart' as _i15;
import 'core/presentation/helper/page_stream.dart' as _i16;
import 'core/presentation/helper/setting_option.dart' as _i17;
import 'core/presentation/helper/sliding_body_stream.dart' as _i18;
import 'core/presentation/helper/subtask_stream.dart' as _i19;
import 'core/presentation/helper/text_stream.dart' as _i24;
import 'features/calendar/data/datasources/gcal_local_data_source.dart' as _i11;
import 'features/calendar/data/datasources/gcal_remote_data_source.dart'
    as _i31;
import 'features/calendar/data/repositories/calendar_repository_impl.dart'
    as _i37;
import 'features/calendar/domain/entities/calendar_entry.dart' as _i7;
import 'features/calendar/domain/entities/calendar_event_entry.dart' as _i6;
import 'features/calendar/domain/repositories/calendar_repository.dart' as _i36;
import 'features/calendar/domain/usecases/add_event.dart' as _i45;
import 'features/calendar/domain/usecases/delete_event.dart' as _i38;
import 'features/calendar/domain/usecases/get_calendar_list.dart' as _i39;
import 'features/calendar/domain/usecases/get_events.dart' as _i40;
import 'features/calendar/domain/usecases/get_events_between.dart' as _i41;
import 'features/calendar/domain/usecases/update_calendar_list.dart' as _i43;
import 'features/calendar/domain/usecases/update_event.dart' as _i44;
import 'features/calendar/presentation/bloc/calendar/calendar_bloc.dart'
    as _i46;
import 'features/calendar/presentation/bloc/calendar/datetime_stream.dart'
    as _i9;
import 'features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart'
    as _i47;
import 'features/task/data/datasources/aws_data_source.dart' as _i21;
import 'features/task/data/datasources/aws_stream.dart' as _i4;
import 'features/task/data/datasources/task_local_data_source.dart' as _i20;
import 'features/task/data/repositories/task_repository_impl.dart' as _i23;
import 'features/task/domain/repositories/task_repository.dart' as _i22;
import 'features/task/domain/usecases/project/create_project.dart' as _i27;
import 'features/task/domain/usecases/project/delete_project.dart' as _i29;
import 'features/task/domain/usecases/project/get_projects.dart' as _i32;
import 'features/task/domain/usecases/project/update_project.dart' as _i25;
import 'features/task/domain/usecases/task/create_tasks.dart' as _i28;
import 'features/task/domain/usecases/task/delete_task.dart' as _i30;
import 'features/task/domain/usecases/task/get_task.dart' as _i33;
import 'features/task/domain/usecases/task/update_task.dart' as _i26;
import 'features/task/presentation/bloc/project_bloc.dart' as _i34;
import 'features/task/presentation/bloc/task_bloc.dart' as _i35;
import 'models/ModelProvider.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

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
  await gh.factoryAsync<_i5.Box<_i8.Project>>(() => registerModule.projectsBox,
      preResolve: true);
  gh.singleton<_i9.DateTimeStream>(_i9.DateTimeStream());
  gh.singleton<_i10.EditTaskStream>(_i10.EditTaskStream());
  gh.lazySingleton<_i11.GCalLocalDataSource>(() => _i11.HiveGCalLocalDataSource(
      calendarBox: get<_i5.Box<_i7.CalendarEntry>>(),
      gcalEventsBox: get<_i5.Box<_i6.CalendarEventEntry>>()));
  gh.singleton<_i12.GoogleSignIn>(registerModule.gCalSignIn);
  gh.lazySingleton<_i13.InternetConnectionChecker>(
      () => registerModule.internetChecker);
  gh.lazySingleton<_i14.NetworkInfo>(
      () => _i14.NetworkInfoImpl(get<_i13.InternetConnectionChecker>()));
  gh.lazySingleton<_i15.NotesStream>(() => _i15.NotesStream());
  gh.singleton<_i16.PageStream>(_i16.PageStream());
  gh.lazySingleton<_i17.SettingOption>(() => _i17.SettingOption());
  gh.singleton<_i18.SlidingBodyStream>(_i18.SlidingBodyStream());
  gh.lazySingleton<_i19.SubTaskStream>(() => _i19.SubTaskStream());
  gh.lazySingleton<_i20.TaskLocalDataSource>(() =>
      _i20.HiveTaskLocalDataSource(projectsBox: get<_i5.Box<_i8.Project>>()));
  gh.lazySingleton<_i21.TaskRemoteDataSource>(
      () => _i21.AWSTaskRemoteDataSource());
  gh.lazySingleton<_i22.TaskRepository>(() => _i23.TaskRepositoryImpl(
      remoteDataSource: get<_i21.TaskRemoteDataSource>(),
      localDataSource: get<_i20.TaskLocalDataSource>()));
  gh.lazySingleton<_i24.TextStream>(() => _i24.TextStream());
  gh.lazySingleton<_i25.UpdateProject>(
      () => _i25.UpdateProject(get<_i22.TaskRepository>()));
  gh.lazySingleton<_i26.UpdateTask>(
      () => _i26.UpdateTask(get<_i22.TaskRepository>()));
  gh.lazySingleton<_i27.CreateProject>(
      () => _i27.CreateProject(get<_i22.TaskRepository>()));
  gh.lazySingleton<_i28.CreateTasks>(
      () => _i28.CreateTasks(get<_i22.TaskRepository>()));
  gh.lazySingleton<_i29.DeleteProject>(
      () => _i29.DeleteProject(get<_i22.TaskRepository>()));
  gh.lazySingleton<_i30.DeleteTask>(
      () => _i30.DeleteTask(get<_i22.TaskRepository>()));
  gh.lazySingleton<_i31.GCalRemoteDataSource>(() =>
      _i31.GoogleAPIGCalRemoteDataSoure(gCalSignIn: get<_i12.GoogleSignIn>()));
  gh.lazySingleton<_i32.GetProjects>(
      () => _i32.GetProjects(get<_i22.TaskRepository>()));
  gh.lazySingleton<_i33.GetTasks>(
      () => _i33.GetTasks(get<_i22.TaskRepository>()));
  gh.factory<_i34.ProjectBloc>(() => _i34.ProjectBloc(
      getProjects: get<_i32.GetProjects>(),
      updateProject: get<_i25.UpdateProject>(),
      deleteProject: get<_i29.DeleteProject>(),
      createProject: get<_i27.CreateProject>()));
  gh.factory<_i35.TaskBloc>(() => _i35.TaskBloc(
      getTasks: get<_i33.GetTasks>(),
      updateTask: get<_i26.UpdateTask>(),
      deleteTask: get<_i30.DeleteTask>(),
      createTasks: get<_i28.CreateTasks>()));
  gh.lazySingleton<_i36.CalendarRepository>(() => _i37.CalendarRepositoryImpl(
      remoteCalDataSource: get<_i31.GCalRemoteDataSource>(),
      localCalDataSource: get<_i11.GCalLocalDataSource>(),
      networkInfo: get<_i14.NetworkInfo>()));
  gh.lazySingleton<_i38.DeleteEvent>(
      () => _i38.DeleteEvent(repository: get<_i36.CalendarRepository>()));
  gh.lazySingleton<_i39.GetCalendarList>(
      () => _i39.GetCalendarList(repository: get<_i36.CalendarRepository>()));
  gh.lazySingleton<_i40.GetEvents>(
      () => _i40.GetEvents(get<_i36.CalendarRepository>()));
  gh.lazySingleton<_i41.GetEventsBetween>(
      () => _i41.GetEventsBetween(get<_i36.CalendarRepository>()));
  gh.factory<_i42.TodayBloc>(() => _i42.TodayBloc(
      getEventEntry: get<_i41.GetEventsBetween>(),
      getTasks: get<_i33.GetTasks>()));
  gh.lazySingleton<_i43.UpdateCalendarList>(() =>
      _i43.UpdateCalendarList(repository: get<_i36.CalendarRepository>()));
  gh.lazySingleton<_i44.UpdateEvent>(
      () => _i44.UpdateEvent(repository: get<_i36.CalendarRepository>()));
  gh.lazySingleton<_i45.AddEvent>(
      () => _i45.AddEvent(repository: get<_i36.CalendarRepository>()));
  gh.factory<_i46.CalendarBloc>(() => _i46.CalendarBloc(
      getCalendarEntry: get<_i40.GetEvents>(),
      addEvent: get<_i45.AddEvent>(),
      deleteEvent: get<_i38.DeleteEvent>(),
      updateEvent: get<_i44.UpdateEvent>(),
      getCalendarList: get<_i39.GetCalendarList>()));
  gh.factory<_i47.CalendarListBloc>(() => _i47.CalendarListBloc(
      getCalendarList: get<_i39.GetCalendarList>(),
      updateCalendarList: get<_i43.UpdateCalendarList>()));
  return get;
}

class _$RegisterModule extends _i48.RegisterModule {}
