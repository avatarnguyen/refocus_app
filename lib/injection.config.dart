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

import 'core/injectable_module.dart' as _i52;
import 'core/network/network_info.dart' as _i13;
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
    as _i33;
import 'features/calendar/data/repositories/calendar_repository_impl.dart'
    as _i41;
import 'features/calendar/domain/entities/calendar_entry.dart' as _i7;
import 'features/calendar/domain/entities/calendar_event_entry.dart' as _i6;
import 'features/calendar/domain/repositories/calendar_repository.dart' as _i40;
import 'features/calendar/domain/usecases/add_event.dart' as _i49;
import 'features/calendar/domain/usecases/delete_event.dart' as _i42;
import 'features/calendar/domain/usecases/get_calendar_list.dart' as _i43;
import 'features/calendar/domain/usecases/get_events.dart' as _i44;
import 'features/calendar/domain/usecases/get_events_between.dart' as _i45;
import 'features/calendar/domain/usecases/update_calendar_list.dart' as _i47;
import 'features/calendar/domain/usecases/update_event.dart' as _i48;
import 'features/calendar/presentation/bloc/calendar/calendar_bloc.dart'
    as _i50;
import 'features/calendar/presentation/bloc/calendar/datetime_stream.dart'
    as _i8;
import 'features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart'
    as _i51;
import 'features/task/data/datasources/aws_data_source.dart' as _i20;
import 'features/task/data/datasources/aws_stream.dart' as _i4;
import 'features/task/data/datasources/task_local_data_source.dart' as _i19;
import 'features/task/data/repositories/task_repository_impl.dart' as _i22;
import 'features/task/domain/repositories/task_repository.dart' as _i21;
import 'features/task/domain/usecases/project/create_project.dart' as _i27;
import 'features/task/domain/usecases/project/delete_project.dart' as _i30;
import 'features/task/domain/usecases/project/get_projects.dart' as _i34;
import 'features/task/domain/usecases/project/update_project.dart' as _i24;
import 'features/task/domain/usecases/subtask/create_subtask.dart' as _i28;
import 'features/task/domain/usecases/subtask/delete_subtask.dart' as _i31;
import 'features/task/domain/usecases/subtask/get_subtasks.dart' as _i35;
import 'features/task/domain/usecases/subtask/update_subtask.dart' as _i25;
import 'features/task/domain/usecases/task/create_tasks.dart' as _i29;
import 'features/task/domain/usecases/task/delete_task.dart' as _i32;
import 'features/task/domain/usecases/task/get_task.dart' as _i36;
import 'features/task/domain/usecases/task/update_task.dart' as _i26;
import 'features/task/presentation/bloc/cubit/subtask_cubit.dart' as _i38;
import 'features/task/presentation/bloc/project_bloc.dart' as _i37;
import 'features/task/presentation/bloc/task_bloc.dart' as _i39;
import 'features/today/presentation/bloc/today_bloc.dart'
    as _i46; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i25.UpdateSubTask>(
      () => _i25.UpdateSubTask(get<_i21.TaskRepository>()));
  gh.lazySingleton<_i26.UpdateTask>(
      () => _i26.UpdateTask(get<_i21.TaskRepository>()));
  gh.lazySingleton<_i27.CreateProject>(
      () => _i27.CreateProject(get<_i21.TaskRepository>()));
  gh.lazySingleton<_i28.CreateSubTask>(
      () => _i28.CreateSubTask(get<_i21.TaskRepository>()));
  gh.lazySingleton<_i29.CreateTasks>(
      () => _i29.CreateTasks(get<_i21.TaskRepository>()));
  gh.lazySingleton<_i30.DeleteProject>(
      () => _i30.DeleteProject(get<_i21.TaskRepository>()));
  gh.lazySingleton<_i31.DeleteSubTask>(
      () => _i31.DeleteSubTask(get<_i21.TaskRepository>()));
  gh.lazySingleton<_i32.DeleteTask>(
      () => _i32.DeleteTask(get<_i21.TaskRepository>()));
  gh.lazySingleton<_i33.GCalRemoteDataSource>(() =>
      _i33.GoogleAPIGCalRemoteDataSoure(gCalSignIn: get<_i11.GoogleSignIn>()));
  gh.lazySingleton<_i34.GetProjects>(
      () => _i34.GetProjects(get<_i21.TaskRepository>()));
  gh.lazySingleton<_i35.GetSubTasks>(
      () => _i35.GetSubTasks(get<_i21.TaskRepository>()));
  gh.lazySingleton<_i36.GetTasks>(
      () => _i36.GetTasks(get<_i21.TaskRepository>()));
  gh.factory<_i37.ProjectBloc>(() => _i37.ProjectBloc(
      getProjects: get<_i34.GetProjects>(),
      updateProject: get<_i24.UpdateProject>(),
      deleteProject: get<_i30.DeleteProject>(),
      createProject: get<_i27.CreateProject>()));
  gh.factory<_i38.SubtaskCubit>(() => _i38.SubtaskCubit(
      getSubTasks: get<_i35.GetSubTasks>(),
      updateSubTask: get<_i25.UpdateSubTask>(),
      createSubTask: get<_i28.CreateSubTask>(),
      deleteSubTask: get<_i31.DeleteSubTask>()));
  gh.factory<_i39.TaskBloc>(() => _i39.TaskBloc(
      getTasks: get<_i36.GetTasks>(),
      updateTask: get<_i26.UpdateTask>(),
      deleteTask: get<_i32.DeleteTask>(),
      createTasks: get<_i29.CreateTasks>()));
  gh.lazySingleton<_i40.CalendarRepository>(() => _i41.CalendarRepositoryImpl(
      remoteCalDataSource: get<_i33.GCalRemoteDataSource>(),
      localCalDataSource: get<_i10.GCalLocalDataSource>(),
      networkInfo: get<_i13.NetworkInfo>()));
  gh.lazySingleton<_i42.DeleteEvent>(
      () => _i42.DeleteEvent(repository: get<_i40.CalendarRepository>()));
  gh.lazySingleton<_i43.GetCalendarList>(
      () => _i43.GetCalendarList(repository: get<_i40.CalendarRepository>()));
  gh.lazySingleton<_i44.GetEvents>(
      () => _i44.GetEvents(get<_i40.CalendarRepository>()));
  gh.lazySingleton<_i45.GetEventsBetween>(
      () => _i45.GetEventsBetween(get<_i40.CalendarRepository>()));
  gh.factory<_i46.TodayBloc>(() => _i46.TodayBloc(
      getEventEntry: get<_i45.GetEventsBetween>(),
      getTasks: get<_i36.GetTasks>()));
  gh.lazySingleton<_i47.UpdateCalendarList>(() =>
      _i47.UpdateCalendarList(repository: get<_i40.CalendarRepository>()));
  gh.lazySingleton<_i48.UpdateEvent>(
      () => _i48.UpdateEvent(repository: get<_i40.CalendarRepository>()));
  gh.lazySingleton<_i49.AddEvent>(
      () => _i49.AddEvent(repository: get<_i40.CalendarRepository>()));
  gh.factory<_i50.CalendarBloc>(() => _i50.CalendarBloc(
      getCalendarEntry: get<_i44.GetEvents>(),
      addEvent: get<_i49.AddEvent>(),
      deleteEvent: get<_i42.DeleteEvent>(),
      updateEvent: get<_i48.UpdateEvent>(),
      getCalendarList: get<_i43.GetCalendarList>()));
  gh.factory<_i51.CalendarListBloc>(() => _i51.CalendarListBloc(
      getCalendarList: get<_i43.GetCalendarList>(),
      updateCalendarList: get<_i47.UpdateCalendarList>()));
  return get;
}

class _$RegisterModule extends _i52.RegisterModule {}
