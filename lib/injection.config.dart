// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i17;
import 'package:hive_flutter/hive_flutter.dart' as _i9;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i18;
import 'package:shared_preferences/shared_preferences.dart' as _i25;

import 'core/aws_stream.dart' as _i8;
import 'core/injectable_module.dart' as _i66;
import 'core/network/network_info.dart' as _i21;
import 'core/presentation/helper/action_stream.dart' as _i3;
import 'core/presentation/helper/edit_task_stream.dart' as _i14;
import 'core/presentation/helper/notes_stream.dart' as _i22;
import 'core/presentation/helper/page_stream.dart' as _i23;
import 'core/presentation/helper/setting_option.dart' as _i24;
import 'core/presentation/helper/sliding_body_stream.dart' as _i29;
import 'core/presentation/helper/subtask_stream.dart' as _i30;
import 'core/presentation/helper/text_stream.dart' as _i35;
import 'features/auth/data/datasources/aws_auth_data_source.dart' as _i4;
import 'features/auth/data/repositories/auth_repository_impl.dart' as _i6;
import 'features/auth/domain/repositories/auth_repository.dart' as _i5;
import 'features/auth/domain/usecases/auth_status.dart' as _i7;
import 'features/auth/domain/usecases/confirmation.dart' as _i12;
import 'features/auth/domain/usecases/get_user.dart' as _i16;
import 'features/auth/domain/usecases/login.dart' as _i19;
import 'features/auth/domain/usecases/signout.dart' as _i26;
import 'features/auth/domain/usecases/signup.dart' as _i27;
import 'features/auth/presentation/authentication/bloc/auth_bloc.dart' as _i39;
import 'features/auth/presentation/login/bloc/login_bloc.dart' as _i20;
import 'features/auth/presentation/signup/bloc/signup_bloc.dart' as _i28;
import 'features/calendar/data/datasources/gcal_local_data_source.dart' as _i15;
import 'features/calendar/data/datasources/gcal_remote_data_source.dart'
    as _i46;
import 'features/calendar/data/repositories/calendar_repository_impl.dart'
    as _i55;
import 'features/calendar/domain/entities/calendar_entry.dart' as _i11;
import 'features/calendar/domain/entities/calendar_event_entry.dart' as _i10;
import 'features/calendar/domain/repositories/calendar_repository.dart' as _i54;
import 'features/calendar/domain/usecases/add_event.dart' as _i63;
import 'features/calendar/domain/usecases/delete_event.dart' as _i56;
import 'features/calendar/domain/usecases/get_calendar_list.dart' as _i57;
import 'features/calendar/domain/usecases/get_events.dart' as _i58;
import 'features/calendar/domain/usecases/get_events_between.dart' as _i59;
import 'features/calendar/domain/usecases/update_calendar_list.dart' as _i61;
import 'features/calendar/domain/usecases/update_event.dart' as _i62;
import 'features/calendar/presentation/bloc/calendar/calendar_bloc.dart'
    as _i64;
import 'features/calendar/presentation/bloc/calendar/datetime_stream.dart'
    as _i13;
import 'features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart'
    as _i65;
import 'features/setting/data/datasources/setting_local_data_source.dart'
    as _i51;
import 'features/task/data/datasources/aws_data_source.dart' as _i32;
import 'features/task/data/datasources/task_local_data_source.dart' as _i31;
import 'features/task/data/repositories/task_repository_impl.dart' as _i34;
import 'features/task/domain/repositories/task_repository.dart' as _i33;
import 'features/task/domain/usecases/project/create_project.dart' as _i40;
import 'features/task/domain/usecases/project/delete_project.dart' as _i43;
import 'features/task/domain/usecases/project/get_projects.dart' as _i47;
import 'features/task/domain/usecases/project/update_project.dart' as _i36;
import 'features/task/domain/usecases/subtask/create_subtask.dart' as _i41;
import 'features/task/domain/usecases/subtask/delete_subtask.dart' as _i44;
import 'features/task/domain/usecases/subtask/get_subtasks.dart' as _i48;
import 'features/task/domain/usecases/subtask/update_subtask.dart' as _i37;
import 'features/task/domain/usecases/task/create_tasks.dart' as _i42;
import 'features/task/domain/usecases/task/delete_task.dart' as _i45;
import 'features/task/domain/usecases/task/get_task.dart' as _i49;
import 'features/task/domain/usecases/task/update_task.dart' as _i38;
import 'features/task/presentation/bloc/cubit/subtask_cubit.dart' as _i52;
import 'features/task/presentation/bloc/project_bloc.dart' as _i50;
import 'features/task/presentation/bloc/task_bloc.dart' as _i53;
import 'features/today/presentation/bloc/today_bloc.dart'
    as _i60; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i7.AuthStatus>(
      () => _i7.AuthStatus(repository: get<_i5.AuthRepository>()));
  gh.lazySingleton<_i8.AwsStream>(() => _i8.AwsStream());
  await gh.factoryAsync<_i9.Box<_i10.CalendarEventEntry>>(
      () => registerModule.gcalEventsBox,
      preResolve: true);
  await gh.factoryAsync<_i9.Box<_i11.CalendarEntry>>(
      () => registerModule.calendarBox,
      preResolve: true);
  await gh.factoryAsync<_i9.Box<String>>(() => registerModule.projectColorBox,
      preResolve: true);
  gh.lazySingleton<_i12.Confirmation>(
      () => _i12.Confirmation(repository: get<_i5.AuthRepository>()));
  gh.singleton<_i13.DateTimeStream>(_i13.DateTimeStream());
  gh.singleton<_i14.EditTaskStream>(_i14.EditTaskStream());
  gh.lazySingleton<_i15.GCalLocalDataSource>(() => _i15.HiveGCalLocalDataSource(
      calendarBox: get<_i9.Box<_i11.CalendarEntry>>(),
      gcalEventsBox: get<_i9.Box<_i10.CalendarEventEntry>>()));
  gh.lazySingleton<_i16.GetUser>(
      () => _i16.GetUser(repository: get<_i5.AuthRepository>()));
  gh.singleton<_i17.GoogleSignIn>(registerModule.gCalSignIn);
  gh.lazySingleton<_i18.InternetConnectionChecker>(
      () => registerModule.internetChecker);
  gh.lazySingleton<_i19.Login>(
      () => _i19.Login(repository: get<_i5.AuthRepository>()));
  gh.factory<_i20.LoginBloc>(() => _i20.LoginBloc(login: get<_i19.Login>()));
  gh.lazySingleton<_i21.NetworkInfo>(
      () => _i21.NetworkInfoImpl(get<_i18.InternetConnectionChecker>()));
  gh.lazySingleton<_i22.NotesStream>(() => _i22.NotesStream());
  gh.singleton<_i23.PageStream>(_i23.PageStream());
  gh.lazySingleton<_i24.SettingOption>(() => _i24.SettingOption());
  await gh.factoryAsync<_i25.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.lazySingleton<_i26.SignOut>(
      () => _i26.SignOut(repository: get<_i5.AuthRepository>()));
  gh.lazySingleton<_i27.SignUp>(
      () => _i27.SignUp(repository: get<_i5.AuthRepository>()));
  gh.factory<_i28.SignupBloc>(() => _i28.SignupBloc(
      signUp: get<_i27.SignUp>(), confirmation: get<_i12.Confirmation>()));
  gh.singleton<_i29.SlidingBodyStream>(_i29.SlidingBodyStream());
  gh.lazySingleton<_i30.SubTaskStream>(() => _i30.SubTaskStream());
  gh.lazySingleton<_i31.TaskLocalDataSource>(() =>
      _i31.HiveTaskLocalDataSource(projectColorBox: get<_i9.Box<String>>()));
  gh.lazySingleton<_i32.TaskRemoteDataSource>(
      () => _i32.AWSTaskRemoteDataSource());
  gh.lazySingleton<_i33.TaskRepository>(() => _i34.TaskRepositoryImpl(
      remoteDataSource: get<_i32.TaskRemoteDataSource>(),
      localDataSource: get<_i31.TaskLocalDataSource>()));
  gh.lazySingleton<_i35.TextStream>(() => _i35.TextStream());
  gh.lazySingleton<_i36.UpdateProject>(
      () => _i36.UpdateProject(get<_i33.TaskRepository>()));
  gh.lazySingleton<_i37.UpdateSubTask>(
      () => _i37.UpdateSubTask(get<_i33.TaskRepository>()));
  gh.lazySingleton<_i38.UpdateTask>(
      () => _i38.UpdateTask(get<_i33.TaskRepository>()));
  gh.factory<_i39.AuthBloc>(() => _i39.AuthBloc(
      login: get<_i19.Login>(),
      signOut: get<_i26.SignOut>(),
      authStatus: get<_i7.AuthStatus>(),
      getUser: get<_i16.GetUser>()));
  gh.lazySingleton<_i40.CreateProject>(
      () => _i40.CreateProject(get<_i33.TaskRepository>()));
  gh.lazySingleton<_i41.CreateSubTask>(
      () => _i41.CreateSubTask(get<_i33.TaskRepository>()));
  gh.lazySingleton<_i42.CreateTasks>(
      () => _i42.CreateTasks(get<_i33.TaskRepository>()));
  gh.lazySingleton<_i43.DeleteProject>(
      () => _i43.DeleteProject(get<_i33.TaskRepository>()));
  gh.lazySingleton<_i44.DeleteSubTask>(
      () => _i44.DeleteSubTask(get<_i33.TaskRepository>()));
  gh.lazySingleton<_i45.DeleteTask>(
      () => _i45.DeleteTask(get<_i33.TaskRepository>()));
  gh.lazySingleton<_i46.GCalRemoteDataSource>(() =>
      _i46.GoogleAPIGCalRemoteDataSoure(gCalSignIn: get<_i17.GoogleSignIn>()));
  gh.lazySingleton<_i47.GetProjects>(
      () => _i47.GetProjects(get<_i33.TaskRepository>()));
  gh.lazySingleton<_i48.GetSubTasks>(
      () => _i48.GetSubTasks(get<_i33.TaskRepository>()));
  gh.lazySingleton<_i49.GetTasks>(
      () => _i49.GetTasks(get<_i33.TaskRepository>()));
  gh.factory<_i50.ProjectBloc>(() => _i50.ProjectBloc(
      getProjects: get<_i47.GetProjects>(),
      updateProject: get<_i36.UpdateProject>(),
      deleteProject: get<_i43.DeleteProject>(),
      createProject: get<_i40.CreateProject>()));
  gh.lazySingleton<_i51.SettingLocalDataSource>(() =>
      _i51.SharedPrefSettingLocalDataSource(get<_i25.SharedPreferences>()));
  gh.factory<_i52.SubtaskCubit>(() => _i52.SubtaskCubit(
      getSubTasks: get<_i48.GetSubTasks>(),
      updateSubTask: get<_i37.UpdateSubTask>(),
      createSubTask: get<_i41.CreateSubTask>(),
      deleteSubTask: get<_i44.DeleteSubTask>()));
  gh.factory<_i53.TaskBloc>(() => _i53.TaskBloc(
      getTasks: get<_i49.GetTasks>(),
      updateTask: get<_i38.UpdateTask>(),
      deleteTask: get<_i45.DeleteTask>(),
      createTasks: get<_i42.CreateTasks>()));
  gh.lazySingleton<_i54.CalendarRepository>(() => _i55.CalendarRepositoryImpl(
      remoteCalDataSource: get<_i46.GCalRemoteDataSource>(),
      localCalDataSource: get<_i15.GCalLocalDataSource>(),
      networkInfo: get<_i21.NetworkInfo>()));
  gh.lazySingleton<_i56.DeleteEvent>(
      () => _i56.DeleteEvent(repository: get<_i54.CalendarRepository>()));
  gh.lazySingleton<_i57.GetCalendarList>(
      () => _i57.GetCalendarList(repository: get<_i54.CalendarRepository>()));
  gh.lazySingleton<_i58.GetEvents>(
      () => _i58.GetEvents(get<_i54.CalendarRepository>()));
  gh.lazySingleton<_i59.GetEventsBetween>(
      () => _i59.GetEventsBetween(get<_i54.CalendarRepository>()));
  gh.factory<_i60.TodayBloc>(() => _i60.TodayBloc(
      dataStream: get<_i8.AwsStream>(),
      getEventEntry: get<_i59.GetEventsBetween>(),
      getTasks: get<_i49.GetTasks>(),
      getSubTasks: get<_i48.GetSubTasks>()));
  gh.lazySingleton<_i61.UpdateCalendarList>(() =>
      _i61.UpdateCalendarList(repository: get<_i54.CalendarRepository>()));
  gh.lazySingleton<_i62.UpdateEvent>(
      () => _i62.UpdateEvent(repository: get<_i54.CalendarRepository>()));
  gh.lazySingleton<_i63.AddEvent>(
      () => _i63.AddEvent(repository: get<_i54.CalendarRepository>()));
  gh.factory<_i64.CalendarBloc>(() => _i64.CalendarBloc(
      getCalendarEntry: get<_i58.GetEvents>(),
      addEvent: get<_i63.AddEvent>(),
      deleteEvent: get<_i56.DeleteEvent>(),
      updateEvent: get<_i62.UpdateEvent>(),
      getCalendarList: get<_i57.GetCalendarList>()));
  gh.factory<_i65.CalendarListBloc>(() => _i65.CalendarListBloc(
      getCalendarList: get<_i57.GetCalendarList>(),
      updateCalendarList: get<_i61.UpdateCalendarList>()));
  return get;
}

class _$RegisterModule extends _i66.RegisterModule {}
