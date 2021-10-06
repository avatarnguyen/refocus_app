// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i11;
import 'package:hive_flutter/hive_flutter.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i12;

import 'core/injectable_module.dart' as _i47;
import 'core/network/network_info.dart' as _i13;
import 'core/presentation/bloc/today_bloc.dart' as _i41;
import 'core/presentation/helper/action_stream.dart' as _i3;
import 'core/presentation/helper/edit_task_stream.dart' as _i9;
import 'core/presentation/helper/notes_stream.dart' as _i14;
import 'core/presentation/helper/page_stream.dart' as _i15;
import 'core/presentation/helper/setting_option.dart' as _i16;
import 'core/presentation/helper/sliding_body_stream.dart' as _i17;
import 'core/presentation/helper/subtask_stream.dart' as _i18;
import 'core/presentation/helper/text_stream.dart' as _i23;
import 'features/calendar/data/datasources/gcal_local_data_source.dart' as _i10;
import 'features/calendar/data/datasources/gcal_remote_data_source.dart'
    as _i30;
import 'features/calendar/data/repositories/calendar_repository_impl.dart'
    as _i36;
import 'features/calendar/domain/entities/calendar_entry.dart' as _i7;
import 'features/calendar/domain/entities/calendar_event_entry.dart' as _i6;
import 'features/calendar/domain/repositories/calendar_repository.dart' as _i35;
import 'features/calendar/domain/usecases/add_event.dart' as _i44;
import 'features/calendar/domain/usecases/delete_event.dart' as _i37;
import 'features/calendar/domain/usecases/get_calendar_list.dart' as _i38;
import 'features/calendar/domain/usecases/get_events.dart' as _i39;
import 'features/calendar/domain/usecases/get_events_between.dart' as _i40;
import 'features/calendar/domain/usecases/update_calendar_list.dart' as _i42;
import 'features/calendar/domain/usecases/update_event.dart' as _i43;
import 'features/calendar/presentation/bloc/calendar/calendar_bloc.dart'
    as _i45;
import 'features/calendar/presentation/bloc/calendar/datetime_stream.dart'
    as _i8;
import 'features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart'
    as _i46;
import 'features/task/data/datasources/aws_data_source.dart' as _i20;
import 'features/task/data/datasources/aws_stream.dart' as _i4;
import 'features/task/data/datasources/task_local_data_source.dart' as _i19;
import 'features/task/data/repositories/task_repository_impl.dart' as _i22;
import 'features/task/domain/repositories/task_repository.dart' as _i21;
import 'features/task/domain/usecases/project/create_project.dart' as _i26;
import 'features/task/domain/usecases/project/delete_project.dart' as _i28;
import 'features/task/domain/usecases/project/get_projects.dart' as _i31;
import 'features/task/domain/usecases/project/update_project.dart' as _i24;
import 'features/task/domain/usecases/task/create_tasks.dart' as _i27;
import 'features/task/domain/usecases/task/delete_task.dart' as _i29;
import 'features/task/domain/usecases/task/get_task.dart' as _i32;
import 'features/task/domain/usecases/task/update_task.dart' as _i25;
import 'features/task/presentation/bloc/project_bloc.dart' as _i33;
import 'features/task/presentation/bloc/task_bloc.dart'
    as _i34; // ignore_for_file: unnecessary_lambdas

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
  await gh.factoryAsync<_i5.Box<String>>(() => registerModule.projectColorBox,
      preResolve: true);
  gh.singleton<_i8.DateTimeStream>(_i8.DateTimeStream());
  gh.singleton<_i9.EditTaskStream>(_i9.EditTaskStream());
  gh.lazySingleton<_i10.GCalLocalDataSource>(() => _i10.HiveGCalLocalDataSource(
      calendarBox: get<_i5.Box<_i7.CalendarEntry>>(),
      gcalEventsBox: get<_i5.Box<_i6.CalendarEventEntry>>()));
  gh.singleton<_i11.GoogleSignIn>(registerModule.gCalSignIn);
  gh.lazySingleton<_i12.InternetConnectionChecker>(
      () => registerModule.internetChecker);
  gh.lazySingleton<_i13.NetworkInfo>(
      () => _i13.NetworkInfoImpl(get<_i12.InternetConnectionChecker>()));
  gh.lazySingleton<_i14.NotesStream>(() => _i14.NotesStream());
  gh.singleton<_i15.PageStream>(_i15.PageStream());
  gh.lazySingleton<_i16.SettingOption>(() => _i16.SettingOption());
  gh.singleton<_i17.SlidingBodyStream>(_i17.SlidingBodyStream());
  gh.lazySingleton<_i18.SubTaskStream>(() => _i18.SubTaskStream());
  gh.lazySingleton<_i19.TaskLocalDataSource>(() =>
      _i19.HiveTaskLocalDataSource(projectColorBox: get<_i5.Box<String>>()));
  gh.lazySingleton<_i20.TaskRemoteDataSource>(
      () => _i20.AWSTaskRemoteDataSource());
  gh.lazySingleton<_i21.TaskRepository>(() => _i22.TaskRepositoryImpl(
      remoteDataSource: get<_i20.TaskRemoteDataSource>(),
      localDataSource: get<_i19.TaskLocalDataSource>()));
  gh.lazySingleton<_i23.TextStream>(() => _i23.TextStream());
  gh.lazySingleton<_i24.UpdateProject>(
      () => _i24.UpdateProject(get<_i21.TaskRepository>()));
  gh.lazySingleton<_i25.UpdateTask>(
      () => _i25.UpdateTask(get<_i21.TaskRepository>()));
  gh.lazySingleton<_i26.CreateProject>(
      () => _i26.CreateProject(get<_i21.TaskRepository>()));
  gh.lazySingleton<_i27.CreateTasks>(
      () => _i27.CreateTasks(get<_i21.TaskRepository>()));
  gh.lazySingleton<_i28.DeleteProject>(
      () => _i28.DeleteProject(get<_i21.TaskRepository>()));
  gh.lazySingleton<_i29.DeleteTask>(
      () => _i29.DeleteTask(get<_i21.TaskRepository>()));
  gh.lazySingleton<_i30.GCalRemoteDataSource>(() =>
      _i30.GoogleAPIGCalRemoteDataSoure(gCalSignIn: get<_i11.GoogleSignIn>()));
  gh.lazySingleton<_i31.GetProjects>(
      () => _i31.GetProjects(get<_i21.TaskRepository>()));
  gh.lazySingleton<_i32.GetTasks>(
      () => _i32.GetTasks(get<_i21.TaskRepository>()));
  gh.factory<_i33.ProjectBloc>(() => _i33.ProjectBloc(
      getProjects: get<_i31.GetProjects>(),
      updateProject: get<_i24.UpdateProject>(),
      deleteProject: get<_i28.DeleteProject>(),
      createProject: get<_i26.CreateProject>()));
  gh.factory<_i34.TaskBloc>(() => _i34.TaskBloc(
      getTasks: get<_i32.GetTasks>(),
      updateTask: get<_i25.UpdateTask>(),
      deleteTask: get<_i29.DeleteTask>(),
      createTasks: get<_i27.CreateTasks>()));
  gh.lazySingleton<_i35.CalendarRepository>(() => _i36.CalendarRepositoryImpl(
      remoteCalDataSource: get<_i30.GCalRemoteDataSource>(),
      localCalDataSource: get<_i10.GCalLocalDataSource>(),
      networkInfo: get<_i13.NetworkInfo>()));
  gh.lazySingleton<_i37.DeleteEvent>(
      () => _i37.DeleteEvent(repository: get<_i35.CalendarRepository>()));
  gh.lazySingleton<_i38.GetCalendarList>(
      () => _i38.GetCalendarList(repository: get<_i35.CalendarRepository>()));
  gh.lazySingleton<_i39.GetEvents>(
      () => _i39.GetEvents(get<_i35.CalendarRepository>()));
  gh.lazySingleton<_i40.GetEventsBetween>(
      () => _i40.GetEventsBetween(get<_i35.CalendarRepository>()));
  gh.factory<_i41.TodayBloc>(() => _i41.TodayBloc(
      getEventEntry: get<_i40.GetEventsBetween>(),
      getTasks: get<_i32.GetTasks>()));
  gh.lazySingleton<_i42.UpdateCalendarList>(() =>
      _i42.UpdateCalendarList(repository: get<_i35.CalendarRepository>()));
  gh.lazySingleton<_i43.UpdateEvent>(
      () => _i43.UpdateEvent(repository: get<_i35.CalendarRepository>()));
  gh.lazySingleton<_i44.AddEvent>(
      () => _i44.AddEvent(repository: get<_i35.CalendarRepository>()));
  gh.factory<_i45.CalendarBloc>(() => _i45.CalendarBloc(
      getCalendarEntry: get<_i39.GetEvents>(),
      addEvent: get<_i44.AddEvent>(),
      deleteEvent: get<_i37.DeleteEvent>(),
      updateEvent: get<_i43.UpdateEvent>(),
      getCalendarList: get<_i38.GetCalendarList>()));
  gh.factory<_i46.CalendarListBloc>(() => _i46.CalendarListBloc(
      getCalendarList: get<_i38.GetCalendarList>(),
      updateCalendarList: get<_i42.UpdateCalendarList>()));
  return get;
}

class _$RegisterModule extends _i47.RegisterModule {}
