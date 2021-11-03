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
import 'package:shared_preferences/shared_preferences.dart' as _i17;

import 'core/aws_stream.dart' as _i4;
import 'core/injectable_module.dart' as _i54;
import 'core/network/network_info.dart' as _i13;
import 'core/presentation/helper/action_stream.dart' as _i3;
import 'core/presentation/helper/edit_task_stream.dart' as _i9;
import 'core/presentation/helper/notes_stream.dart' as _i14;
import 'core/presentation/helper/page_stream.dart' as _i15;
import 'core/presentation/helper/setting_option.dart' as _i16;
import 'core/presentation/helper/sliding_body_stream.dart' as _i18;
import 'core/presentation/helper/subtask_stream.dart' as _i19;
import 'core/presentation/helper/text_stream.dart' as _i24;
import 'features/calendar/data/datasources/gcal_local_data_source.dart' as _i10;
import 'features/calendar/data/datasources/gcal_remote_data_source.dart'
    as _i34;
import 'features/calendar/data/repositories/calendar_repository_impl.dart'
    as _i43;
import 'features/calendar/domain/entities/calendar_entry.dart' as _i7;
import 'features/calendar/domain/entities/calendar_event_entry.dart' as _i6;
import 'features/calendar/domain/repositories/calendar_repository.dart' as _i42;
import 'features/calendar/domain/usecases/add_event.dart' as _i51;
import 'features/calendar/domain/usecases/delete_event.dart' as _i44;
import 'features/calendar/domain/usecases/get_calendar_list.dart' as _i45;
import 'features/calendar/domain/usecases/get_events.dart' as _i46;
import 'features/calendar/domain/usecases/get_events_between.dart' as _i47;
import 'features/calendar/domain/usecases/update_calendar_list.dart' as _i49;
import 'features/calendar/domain/usecases/update_event.dart' as _i50;
import 'features/calendar/presentation/bloc/calendar/calendar_bloc.dart'
    as _i52;
import 'features/calendar/presentation/bloc/calendar/datetime_stream.dart'
    as _i8;
import 'features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart'
    as _i53;
import 'features/setting/data/datasources/setting_local_data_source.dart'
    as _i39;
import 'features/task/data/datasources/aws_data_source.dart' as _i21;
import 'features/task/data/datasources/task_local_data_source.dart' as _i20;
import 'features/task/data/repositories/task_repository_impl.dart' as _i23;
import 'features/task/domain/repositories/task_repository.dart' as _i22;
import 'features/task/domain/usecases/project/create_project.dart' as _i28;
import 'features/task/domain/usecases/project/delete_project.dart' as _i31;
import 'features/task/domain/usecases/project/get_projects.dart' as _i35;
import 'features/task/domain/usecases/project/update_project.dart' as _i25;
import 'features/task/domain/usecases/subtask/create_subtask.dart' as _i29;
import 'features/task/domain/usecases/subtask/delete_subtask.dart' as _i32;
import 'features/task/domain/usecases/subtask/get_subtasks.dart' as _i36;
import 'features/task/domain/usecases/subtask/update_subtask.dart' as _i26;
import 'features/task/domain/usecases/task/create_tasks.dart' as _i30;
import 'features/task/domain/usecases/task/delete_task.dart' as _i33;
import 'features/task/domain/usecases/task/get_task.dart' as _i37;
import 'features/task/domain/usecases/task/update_task.dart' as _i27;
import 'features/task/presentation/bloc/cubit/subtask_cubit.dart' as _i40;
import 'features/task/presentation/bloc/project_bloc.dart' as _i38;
import 'features/task/presentation/bloc/task_bloc.dart' as _i41;
import 'features/today/presentation/bloc/today_bloc.dart'
    as _i48; // ignore_for_file: unnecessary_lambdas

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
  await gh.factoryAsync<_i17.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.singleton<_i18.SlidingBodyStream>(_i18.SlidingBodyStream());
  gh.lazySingleton<_i19.SubTaskStream>(() => _i19.SubTaskStream());
  gh.lazySingleton<_i20.TaskLocalDataSource>(() =>
      _i20.HiveTaskLocalDataSource(projectColorBox: get<_i5.Box<String>>()));
  gh.lazySingleton<_i21.TaskRemoteDataSource>(
      () => _i21.AWSTaskRemoteDataSource());
  gh.lazySingleton<_i22.TaskRepository>(() => _i23.TaskRepositoryImpl(
      remoteDataSource: get<_i21.TaskRemoteDataSource>(),
      localDataSource: get<_i20.TaskLocalDataSource>()));
  gh.lazySingleton<_i24.TextStream>(() => _i24.TextStream());
  gh.lazySingleton<_i25.UpdateProject>(
      () => _i25.UpdateProject(get<_i22.TaskRepository>()));
  gh.lazySingleton<_i26.UpdateSubTask>(
      () => _i26.UpdateSubTask(get<_i22.TaskRepository>()));
  gh.lazySingleton<_i27.UpdateTask>(
      () => _i27.UpdateTask(get<_i22.TaskRepository>()));
  gh.lazySingleton<_i28.CreateProject>(
      () => _i28.CreateProject(get<_i22.TaskRepository>()));
  gh.lazySingleton<_i29.CreateSubTask>(
      () => _i29.CreateSubTask(get<_i22.TaskRepository>()));
  gh.lazySingleton<_i30.CreateTasks>(
      () => _i30.CreateTasks(get<_i22.TaskRepository>()));
  gh.lazySingleton<_i31.DeleteProject>(
      () => _i31.DeleteProject(get<_i22.TaskRepository>()));
  gh.lazySingleton<_i32.DeleteSubTask>(
      () => _i32.DeleteSubTask(get<_i22.TaskRepository>()));
  gh.lazySingleton<_i33.DeleteTask>(
      () => _i33.DeleteTask(get<_i22.TaskRepository>()));
  gh.lazySingleton<_i34.GCalRemoteDataSource>(() =>
      _i34.GoogleAPIGCalRemoteDataSoure(gCalSignIn: get<_i11.GoogleSignIn>()));
  gh.lazySingleton<_i35.GetProjects>(
      () => _i35.GetProjects(get<_i22.TaskRepository>()));
  gh.lazySingleton<_i36.GetSubTasks>(
      () => _i36.GetSubTasks(get<_i22.TaskRepository>()));
  gh.lazySingleton<_i37.GetTasks>(
      () => _i37.GetTasks(get<_i22.TaskRepository>()));
  gh.factory<_i38.ProjectBloc>(() => _i38.ProjectBloc(
      getProjects: get<_i35.GetProjects>(),
      updateProject: get<_i25.UpdateProject>(),
      deleteProject: get<_i31.DeleteProject>(),
      createProject: get<_i28.CreateProject>()));
  gh.lazySingleton<_i39.SettingLocalDataSource>(() =>
      _i39.SharedPrefSettingLocalDataSource(get<_i17.SharedPreferences>()));
  gh.factory<_i40.SubtaskCubit>(() => _i40.SubtaskCubit(
      getSubTasks: get<_i36.GetSubTasks>(),
      updateSubTask: get<_i26.UpdateSubTask>(),
      createSubTask: get<_i29.CreateSubTask>(),
      deleteSubTask: get<_i32.DeleteSubTask>()));
  gh.factory<_i41.TaskBloc>(() => _i41.TaskBloc(
      getTasks: get<_i37.GetTasks>(),
      updateTask: get<_i27.UpdateTask>(),
      deleteTask: get<_i33.DeleteTask>(),
      createTasks: get<_i30.CreateTasks>()));
  gh.lazySingleton<_i42.CalendarRepository>(() => _i43.CalendarRepositoryImpl(
      remoteCalDataSource: get<_i34.GCalRemoteDataSource>(),
      localCalDataSource: get<_i10.GCalLocalDataSource>(),
      networkInfo: get<_i13.NetworkInfo>()));
  gh.lazySingleton<_i44.DeleteEvent>(
      () => _i44.DeleteEvent(repository: get<_i42.CalendarRepository>()));
  gh.lazySingleton<_i45.GetCalendarList>(
      () => _i45.GetCalendarList(repository: get<_i42.CalendarRepository>()));
  gh.lazySingleton<_i46.GetEvents>(
      () => _i46.GetEvents(get<_i42.CalendarRepository>()));
  gh.lazySingleton<_i47.GetEventsBetween>(
      () => _i47.GetEventsBetween(get<_i42.CalendarRepository>()));
  gh.factory<_i48.TodayBloc>(() => _i48.TodayBloc(
      dataStream: get<_i4.AwsStream>(),
      getEventEntry: get<_i47.GetEventsBetween>(),
      getTasks: get<_i37.GetTasks>(),
      getSubTasks: get<_i36.GetSubTasks>()));
  gh.lazySingleton<_i49.UpdateCalendarList>(() =>
      _i49.UpdateCalendarList(repository: get<_i42.CalendarRepository>()));
  gh.lazySingleton<_i50.UpdateEvent>(
      () => _i50.UpdateEvent(repository: get<_i42.CalendarRepository>()));
  gh.lazySingleton<_i51.AddEvent>(
      () => _i51.AddEvent(repository: get<_i42.CalendarRepository>()));
  gh.factory<_i52.CalendarBloc>(() => _i52.CalendarBloc(
      getCalendarEntry: get<_i46.GetEvents>(),
      addEvent: get<_i51.AddEvent>(),
      deleteEvent: get<_i44.DeleteEvent>(),
      updateEvent: get<_i50.UpdateEvent>(),
      getCalendarList: get<_i45.GetCalendarList>()));
  gh.factory<_i53.CalendarListBloc>(() => _i53.CalendarListBloc(
      getCalendarList: get<_i45.GetCalendarList>(),
      updateCalendarList: get<_i49.UpdateCalendarList>()));
  return get;
}

class _$RegisterModule extends _i54.RegisterModule {}
