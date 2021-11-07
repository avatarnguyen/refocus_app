// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i14;
import 'package:hive_flutter/hive_flutter.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i15;
import 'package:shared_preferences/shared_preferences.dart' as _i21;

import 'core/aws_stream.dart' as _i7;
import 'core/injectable_module.dart' as _i60;
import 'core/network/network_info.dart' as _i17;
import 'core/presentation/helper/action_stream.dart' as _i3;
import 'core/presentation/helper/edit_task_stream.dart' as _i12;
import 'core/presentation/helper/notes_stream.dart' as _i18;
import 'core/presentation/helper/page_stream.dart' as _i19;
import 'core/presentation/helper/setting_option.dart' as _i20;
import 'core/presentation/helper/sliding_body_stream.dart' as _i24;
import 'core/presentation/helper/subtask_stream.dart' as _i25;
import 'core/presentation/helper/text_stream.dart' as _i30;
import 'features/auth/data/datasources/aws_auth_data_source.dart' as _i4;
import 'features/auth/data/repositories/auth_repository_impl.dart' as _i6;
import 'features/auth/domain/repositories/auth_repository.dart' as _i5;
import 'features/auth/domain/usecases/login.dart' as _i16;
import 'features/auth/domain/usecases/signout.dart' as _i22;
import 'features/auth/domain/usecases/signup.dart' as _i23;
import 'features/calendar/data/datasources/gcal_local_data_source.dart' as _i13;
import 'features/calendar/data/datasources/gcal_remote_data_source.dart'
    as _i40;
import 'features/calendar/data/repositories/calendar_repository_impl.dart'
    as _i49;
import 'features/calendar/domain/entities/calendar_entry.dart' as _i10;
import 'features/calendar/domain/entities/calendar_event_entry.dart' as _i9;
import 'features/calendar/domain/repositories/calendar_repository.dart' as _i48;
import 'features/calendar/domain/usecases/add_event.dart' as _i57;
import 'features/calendar/domain/usecases/delete_event.dart' as _i50;
import 'features/calendar/domain/usecases/get_calendar_list.dart' as _i51;
import 'features/calendar/domain/usecases/get_events.dart' as _i52;
import 'features/calendar/domain/usecases/get_events_between.dart' as _i53;
import 'features/calendar/domain/usecases/update_calendar_list.dart' as _i55;
import 'features/calendar/domain/usecases/update_event.dart' as _i56;
import 'features/calendar/presentation/bloc/calendar/calendar_bloc.dart'
    as _i58;
import 'features/calendar/presentation/bloc/calendar/datetime_stream.dart'
    as _i11;
import 'features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart'
    as _i59;
import 'features/setting/data/datasources/setting_local_data_source.dart'
    as _i45;
import 'features/task/data/datasources/aws_data_source.dart' as _i27;
import 'features/task/data/datasources/task_local_data_source.dart' as _i26;
import 'features/task/data/repositories/task_repository_impl.dart' as _i29;
import 'features/task/domain/repositories/task_repository.dart' as _i28;
import 'features/task/domain/usecases/project/create_project.dart' as _i34;
import 'features/task/domain/usecases/project/delete_project.dart' as _i37;
import 'features/task/domain/usecases/project/get_projects.dart' as _i41;
import 'features/task/domain/usecases/project/update_project.dart' as _i31;
import 'features/task/domain/usecases/subtask/create_subtask.dart' as _i35;
import 'features/task/domain/usecases/subtask/delete_subtask.dart' as _i38;
import 'features/task/domain/usecases/subtask/get_subtasks.dart' as _i42;
import 'features/task/domain/usecases/subtask/update_subtask.dart' as _i32;
import 'features/task/domain/usecases/task/create_tasks.dart' as _i36;
import 'features/task/domain/usecases/task/delete_task.dart' as _i39;
import 'features/task/domain/usecases/task/get_task.dart' as _i43;
import 'features/task/domain/usecases/task/update_task.dart' as _i33;
import 'features/task/presentation/bloc/cubit/subtask_cubit.dart' as _i46;
import 'features/task/presentation/bloc/project_bloc.dart' as _i44;
import 'features/task/presentation/bloc/task_bloc.dart' as _i47;
import 'features/today/presentation/bloc/today_bloc.dart'
    as _i54; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.ActionStream>(() => _i3.ActionStream());
  gh.lazySingleton<_i4.AuthDataSource>(() => _i4.AWSAuthDataSource());
  gh.lazySingleton<_i5.AuthRepository>(
      () => _i6.AuthRepositoryImpl(authDataSource: get<_i4.AuthDataSource>()));
  gh.lazySingleton<_i7.AwsStream>(() => _i7.AwsStream());
  await gh.factoryAsync<_i8.Box<_i9.CalendarEventEntry>>(
      () => registerModule.gcalEventsBox,
      preResolve: true);
  await gh.factoryAsync<_i8.Box<_i10.CalendarEntry>>(
      () => registerModule.calendarBox,
      preResolve: true);
  await gh.factoryAsync<_i8.Box<String>>(() => registerModule.projectColorBox,
      preResolve: true);
  gh.singleton<_i11.DateTimeStream>(_i11.DateTimeStream());
  gh.singleton<_i12.EditTaskStream>(_i12.EditTaskStream());
  gh.lazySingleton<_i13.GCalLocalDataSource>(() => _i13.HiveGCalLocalDataSource(
      calendarBox: get<_i8.Box<_i10.CalendarEntry>>(),
      gcalEventsBox: get<_i8.Box<_i9.CalendarEventEntry>>()));
  gh.singleton<_i14.GoogleSignIn>(registerModule.gCalSignIn);
  gh.lazySingleton<_i15.InternetConnectionChecker>(
      () => registerModule.internetChecker);
  gh.lazySingleton<_i16.Login>(
      () => _i16.Login(repository: get<_i5.AuthRepository>()));
  gh.lazySingleton<_i17.NetworkInfo>(
      () => _i17.NetworkInfoImpl(get<_i15.InternetConnectionChecker>()));
  gh.lazySingleton<_i18.NotesStream>(() => _i18.NotesStream());
  gh.singleton<_i19.PageStream>(_i19.PageStream());
  gh.lazySingleton<_i20.SettingOption>(() => _i20.SettingOption());
  await gh.factoryAsync<_i21.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.lazySingleton<_i22.SignOut>(
      () => _i22.SignOut(repository: get<_i5.AuthRepository>()));
  gh.lazySingleton<_i23.SignUp>(
      () => _i23.SignUp(repository: get<_i5.AuthRepository>()));
  gh.singleton<_i24.SlidingBodyStream>(_i24.SlidingBodyStream());
  gh.lazySingleton<_i25.SubTaskStream>(() => _i25.SubTaskStream());
  gh.lazySingleton<_i26.TaskLocalDataSource>(() =>
      _i26.HiveTaskLocalDataSource(projectColorBox: get<_i8.Box<String>>()));
  gh.lazySingleton<_i27.TaskRemoteDataSource>(
      () => _i27.AWSTaskRemoteDataSource());
  gh.lazySingleton<_i28.TaskRepository>(() => _i29.TaskRepositoryImpl(
      remoteDataSource: get<_i27.TaskRemoteDataSource>(),
      localDataSource: get<_i26.TaskLocalDataSource>()));
  gh.lazySingleton<_i30.TextStream>(() => _i30.TextStream());
  gh.lazySingleton<_i31.UpdateProject>(
      () => _i31.UpdateProject(get<_i28.TaskRepository>()));
  gh.lazySingleton<_i32.UpdateSubTask>(
      () => _i32.UpdateSubTask(get<_i28.TaskRepository>()));
  gh.lazySingleton<_i33.UpdateTask>(
      () => _i33.UpdateTask(get<_i28.TaskRepository>()));
  gh.lazySingleton<_i34.CreateProject>(
      () => _i34.CreateProject(get<_i28.TaskRepository>()));
  gh.lazySingleton<_i35.CreateSubTask>(
      () => _i35.CreateSubTask(get<_i28.TaskRepository>()));
  gh.lazySingleton<_i36.CreateTasks>(
      () => _i36.CreateTasks(get<_i28.TaskRepository>()));
  gh.lazySingleton<_i37.DeleteProject>(
      () => _i37.DeleteProject(get<_i28.TaskRepository>()));
  gh.lazySingleton<_i38.DeleteSubTask>(
      () => _i38.DeleteSubTask(get<_i28.TaskRepository>()));
  gh.lazySingleton<_i39.DeleteTask>(
      () => _i39.DeleteTask(get<_i28.TaskRepository>()));
  gh.lazySingleton<_i40.GCalRemoteDataSource>(() =>
      _i40.GoogleAPIGCalRemoteDataSoure(gCalSignIn: get<_i14.GoogleSignIn>()));
  gh.lazySingleton<_i41.GetProjects>(
      () => _i41.GetProjects(get<_i28.TaskRepository>()));
  gh.lazySingleton<_i42.GetSubTasks>(
      () => _i42.GetSubTasks(get<_i28.TaskRepository>()));
  gh.lazySingleton<_i43.GetTasks>(
      () => _i43.GetTasks(get<_i28.TaskRepository>()));
  gh.factory<_i44.ProjectBloc>(() => _i44.ProjectBloc(
      getProjects: get<_i41.GetProjects>(),
      updateProject: get<_i31.UpdateProject>(),
      deleteProject: get<_i37.DeleteProject>(),
      createProject: get<_i34.CreateProject>()));
  gh.lazySingleton<_i45.SettingLocalDataSource>(() =>
      _i45.SharedPrefSettingLocalDataSource(get<_i21.SharedPreferences>()));
  gh.factory<_i46.SubtaskCubit>(() => _i46.SubtaskCubit(
      getSubTasks: get<_i42.GetSubTasks>(),
      updateSubTask: get<_i32.UpdateSubTask>(),
      createSubTask: get<_i35.CreateSubTask>(),
      deleteSubTask: get<_i38.DeleteSubTask>()));
  gh.factory<_i47.TaskBloc>(() => _i47.TaskBloc(
      getTasks: get<_i43.GetTasks>(),
      updateTask: get<_i33.UpdateTask>(),
      deleteTask: get<_i39.DeleteTask>(),
      createTasks: get<_i36.CreateTasks>()));
  gh.lazySingleton<_i48.CalendarRepository>(() => _i49.CalendarRepositoryImpl(
      remoteCalDataSource: get<_i40.GCalRemoteDataSource>(),
      localCalDataSource: get<_i13.GCalLocalDataSource>(),
      networkInfo: get<_i17.NetworkInfo>()));
  gh.lazySingleton<_i50.DeleteEvent>(
      () => _i50.DeleteEvent(repository: get<_i48.CalendarRepository>()));
  gh.lazySingleton<_i51.GetCalendarList>(
      () => _i51.GetCalendarList(repository: get<_i48.CalendarRepository>()));
  gh.lazySingleton<_i52.GetEvents>(
      () => _i52.GetEvents(get<_i48.CalendarRepository>()));
  gh.lazySingleton<_i53.GetEventsBetween>(
      () => _i53.GetEventsBetween(get<_i48.CalendarRepository>()));
  gh.factory<_i54.TodayBloc>(() => _i54.TodayBloc(
      dataStream: get<_i7.AwsStream>(),
      getEventEntry: get<_i53.GetEventsBetween>(),
      getTasks: get<_i43.GetTasks>(),
      getSubTasks: get<_i42.GetSubTasks>()));
  gh.lazySingleton<_i55.UpdateCalendarList>(() =>
      _i55.UpdateCalendarList(repository: get<_i48.CalendarRepository>()));
  gh.lazySingleton<_i56.UpdateEvent>(
      () => _i56.UpdateEvent(repository: get<_i48.CalendarRepository>()));
  gh.lazySingleton<_i57.AddEvent>(
      () => _i57.AddEvent(repository: get<_i48.CalendarRepository>()));
  gh.factory<_i58.CalendarBloc>(() => _i58.CalendarBloc(
      getCalendarEntry: get<_i52.GetEvents>(),
      addEvent: get<_i57.AddEvent>(),
      deleteEvent: get<_i50.DeleteEvent>(),
      updateEvent: get<_i56.UpdateEvent>(),
      getCalendarList: get<_i51.GetCalendarList>()));
  gh.factory<_i59.CalendarListBloc>(() => _i59.CalendarListBloc(
      getCalendarList: get<_i51.GetCalendarList>(),
      updateCalendarList: get<_i55.UpdateCalendarList>()));
  return get;
}

class _$RegisterModule extends _i60.RegisterModule {}
