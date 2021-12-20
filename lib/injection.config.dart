// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i16;
import 'package:hive_flutter/hive_flutter.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i17;
import 'package:shared_preferences/shared_preferences.dart' as _i22;

import 'core/aws_stream.dart' as _i7;
import 'core/injectable_module.dart' as _i64;
import 'core/network/network_info.dart' as _i20;
import 'core/presentation/helper/edit_task_stream.dart' as _i13;
import 'core/presentation/helper/page_stream.dart' as _i21;
import 'core/presentation/helper/sliding_body_stream.dart' as _i26;
import 'features/auth/data/datasources/aws_auth_data_source.dart' as _i3;
import 'features/auth/data/repositories/auth_repository_impl.dart' as _i5;
import 'features/auth/domain/repositories/auth_repository.dart' as _i4;
import 'features/auth/domain/usecases/auth_status.dart' as _i6;
import 'features/auth/domain/usecases/confirmation.dart' as _i11;
import 'features/auth/domain/usecases/get_user.dart' as _i15;
import 'features/auth/domain/usecases/login.dart' as _i18;
import 'features/auth/domain/usecases/signout.dart' as _i23;
import 'features/auth/domain/usecases/signup.dart' as _i24;
import 'features/auth/presentation/authentication/bloc/auth_bloc.dart' as _i36;
import 'features/auth/presentation/login/bloc/login_bloc.dart' as _i19;
import 'features/auth/presentation/signup/bloc/signup_bloc.dart' as _i25;
import 'features/calendar/data/datasources/gcal_local_data_source.dart' as _i14;
import 'features/calendar/data/datasources/gcal_remote_data_source.dart'
    as _i43;
import 'features/calendar/data/repositories/calendar_repository_impl.dart'
    as _i52;
import 'features/calendar/domain/entities/calendar_entry.dart' as _i10;
import 'features/calendar/domain/entities/calendar_event_entry.dart' as _i9;
import 'features/calendar/domain/repositories/calendar_repository.dart' as _i51;
import 'features/calendar/domain/usecases/calendar_event/add_event.dart'
    as _i61;
import 'features/calendar/domain/usecases/calendar_event/delete_event.dart'
    as _i54;
import 'features/calendar/domain/usecases/calendar_event/get_events.dart'
    as _i56;
import 'features/calendar/domain/usecases/calendar_event/get_events_between.dart'
    as _i57;
import 'features/calendar/domain/usecases/calendar_event/update_event.dart'
    as _i60;
import 'features/calendar/domain/usecases/calendar_list/get_calendar_list.dart'
    as _i55;
import 'features/calendar/domain/usecases/calendar_list/update_calendar_list.dart'
    as _i59;
import 'features/calendar/presentation/bloc/calendar/calendar_bloc.dart'
    as _i62;
import 'features/calendar/presentation/bloc/calendar/datetime_stream.dart'
    as _i12;
import 'features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart'
    as _i63;
import 'features/create/presentation/bloc/create_bloc.dart' as _i53;
import 'features/setting/data/datasources/setting_local_data_source.dart'
    as _i48;
import 'features/task/data/datasources/aws_data_source.dart' as _i28;
import 'features/task/data/datasources/task_local_data_source.dart' as _i27;
import 'features/task/data/repositories/task_repository_impl.dart' as _i30;
import 'features/task/domain/repositories/task_repository.dart' as _i29;
import 'features/task/domain/usecases/project/create_project.dart' as _i37;
import 'features/task/domain/usecases/project/delete_project.dart' as _i40;
import 'features/task/domain/usecases/project/get_projects.dart' as _i44;
import 'features/task/domain/usecases/project/update_project.dart' as _i33;
import 'features/task/domain/usecases/subtask/create_subtask.dart' as _i38;
import 'features/task/domain/usecases/subtask/delete_subtask.dart' as _i41;
import 'features/task/domain/usecases/subtask/get_subtasks.dart' as _i45;
import 'features/task/domain/usecases/subtask/update_subtask.dart' as _i34;
import 'features/task/domain/usecases/task/create_tasks.dart' as _i39;
import 'features/task/domain/usecases/task/delete_task.dart' as _i42;
import 'features/task/domain/usecases/task/get_task.dart' as _i46;
import 'features/task/domain/usecases/task/update_task.dart' as _i35;
import 'features/task/presentation/bloc/cubit/subtask_cubit.dart' as _i49;
import 'features/task/presentation/bloc/project_bloc.dart' as _i47;
import 'features/task/presentation/bloc/task_bloc.dart' as _i50;
import 'features/today/presentation/bloc/today/today_bloc.dart' as _i58;
import 'features/today/presentation/bloc/tomorrow/tomorrow_bloc.dart' as _i31;
import 'features/today/presentation/bloc/upcoming/upcoming_cubit.dart'
    as _i32; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.AuthDataSource>(() => _i3.AWSAuthDataSource());
  gh.lazySingleton<_i4.AuthRepository>(
      () => _i5.AuthRepositoryImpl(authDataSource: get<_i3.AuthDataSource>()));
  gh.lazySingleton<_i6.AuthStatus>(
      () => _i6.AuthStatus(repository: get<_i4.AuthRepository>()));
  gh.lazySingleton<_i7.AwsStream>(() => _i7.AwsStream());
  await gh.factoryAsync<_i8.Box<_i9.CalendarEventEntry>>(
      () => registerModule.gcalEventsBox,
      preResolve: true);
  await gh.factoryAsync<_i8.Box<_i10.CalendarEntry>>(
      () => registerModule.calendarBox,
      preResolve: true);
  await gh.factoryAsync<_i8.Box<String>>(() => registerModule.projectColorBox,
      preResolve: true);
  gh.lazySingleton<_i11.Confirmation>(
      () => _i11.Confirmation(repository: get<_i4.AuthRepository>()));
  gh.singleton<_i12.DateTimeStream>(_i12.DateTimeStream());
  gh.singleton<_i13.EditTaskStream>(_i13.EditTaskStream());
  gh.lazySingleton<_i14.GCalLocalDataSource>(() => _i14.HiveGCalLocalDataSource(
      calendarBox: get<_i8.Box<_i10.CalendarEntry>>(),
      gcalEventsBox: get<_i8.Box<_i9.CalendarEventEntry>>()));
  gh.lazySingleton<_i15.GetUser>(
      () => _i15.GetUser(repository: get<_i4.AuthRepository>()));
  gh.singleton<_i16.GoogleSignIn>(registerModule.gCalSignIn);
  gh.lazySingleton<_i17.InternetConnectionChecker>(
      () => registerModule.internetChecker);
  gh.lazySingleton<_i18.Login>(
      () => _i18.Login(repository: get<_i4.AuthRepository>()));
  gh.factory<_i19.LoginBloc>(() => _i19.LoginBloc(login: get<_i18.Login>()));
  gh.lazySingleton<_i20.NetworkInfo>(
      () => _i20.NetworkInfoImpl(get<_i17.InternetConnectionChecker>()));
  gh.singleton<_i21.PageStream>(_i21.PageStream());
  await gh.factoryAsync<_i22.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.lazySingleton<_i23.SignOut>(
      () => _i23.SignOut(repository: get<_i4.AuthRepository>()));
  gh.lazySingleton<_i24.SignUp>(
      () => _i24.SignUp(repository: get<_i4.AuthRepository>()));
  gh.factory<_i25.SignupBloc>(() => _i25.SignupBloc(
      signUp: get<_i24.SignUp>(), confirmation: get<_i11.Confirmation>()));
  gh.singleton<_i26.SlidingBodyStream>(_i26.SlidingBodyStream());
  gh.lazySingleton<_i27.TaskLocalDataSource>(() =>
      _i27.HiveTaskLocalDataSource(projectColorBox: get<_i8.Box<String>>()));
  gh.lazySingleton<_i28.TaskRemoteDataSource>(
      () => _i28.AWSTaskRemoteDataSource());
  gh.lazySingleton<_i29.TaskRepository>(() => _i30.TaskRepositoryImpl(
      remoteDataSource: get<_i28.TaskRemoteDataSource>(),
      localDataSource: get<_i27.TaskLocalDataSource>()));
  gh.factory<_i31.TomorrowBloc>(() => _i31.TomorrowBloc());
  gh.factory<_i32.UpcomingCubit>(() => _i32.UpcomingCubit());
  gh.lazySingleton<_i33.UpdateProject>(
      () => _i33.UpdateProject(get<_i29.TaskRepository>()));
  gh.lazySingleton<_i34.UpdateSubTask>(
      () => _i34.UpdateSubTask(get<_i29.TaskRepository>()));
  gh.lazySingleton<_i35.UpdateTask>(
      () => _i35.UpdateTask(get<_i29.TaskRepository>()));
  gh.factory<_i36.AuthBloc>(() => _i36.AuthBloc(
      login: get<_i18.Login>(),
      signOut: get<_i23.SignOut>(),
      authStatus: get<_i6.AuthStatus>(),
      confirmation: get<_i11.Confirmation>(),
      getUser: get<_i15.GetUser>()));
  gh.lazySingleton<_i37.CreateProject>(
      () => _i37.CreateProject(get<_i29.TaskRepository>()));
  gh.lazySingleton<_i38.CreateSubTask>(
      () => _i38.CreateSubTask(get<_i29.TaskRepository>()));
  gh.lazySingleton<_i39.CreateTasks>(
      () => _i39.CreateTasks(get<_i29.TaskRepository>()));
  gh.lazySingleton<_i40.DeleteProject>(
      () => _i40.DeleteProject(get<_i29.TaskRepository>()));
  gh.lazySingleton<_i41.DeleteSubTask>(
      () => _i41.DeleteSubTask(get<_i29.TaskRepository>()));
  gh.lazySingleton<_i42.DeleteTask>(
      () => _i42.DeleteTask(get<_i29.TaskRepository>()));
  gh.lazySingleton<_i43.GCalRemoteDataSource>(() =>
      _i43.GoogleAPIGCalRemoteDataSoure(gCalSignIn: get<_i16.GoogleSignIn>()));
  gh.lazySingleton<_i44.GetProjects>(
      () => _i44.GetProjects(get<_i29.TaskRepository>()));
  gh.lazySingleton<_i45.GetSubTasks>(
      () => _i45.GetSubTasks(get<_i29.TaskRepository>()));
  gh.lazySingleton<_i46.GetTasks>(
      () => _i46.GetTasks(get<_i29.TaskRepository>()));
  gh.factory<_i47.ProjectBloc>(() => _i47.ProjectBloc(
      getProjects: get<_i44.GetProjects>(),
      updateProject: get<_i33.UpdateProject>(),
      deleteProject: get<_i40.DeleteProject>(),
      createProject: get<_i37.CreateProject>()));
  gh.lazySingleton<_i48.SettingLocalDataSource>(() =>
      _i48.SharedPrefSettingLocalDataSource(get<_i22.SharedPreferences>()));
  gh.factory<_i49.SubtaskCubit>(() => _i49.SubtaskCubit(
      getSubTasks: get<_i45.GetSubTasks>(),
      updateSubTask: get<_i34.UpdateSubTask>(),
      createSubTask: get<_i38.CreateSubTask>(),
      deleteSubTask: get<_i41.DeleteSubTask>()));
  gh.factory<_i50.TaskBloc>(() => _i50.TaskBloc(
      getTasks: get<_i46.GetTasks>(),
      updateTask: get<_i35.UpdateTask>(),
      deleteTask: get<_i42.DeleteTask>(),
      createTasks: get<_i39.CreateTasks>()));
  gh.lazySingleton<_i51.CalendarRepository>(() => _i52.CalendarRepositoryImpl(
      remoteCalDataSource: get<_i43.GCalRemoteDataSource>(),
      localCalDataSource: get<_i14.GCalLocalDataSource>(),
      networkInfo: get<_i20.NetworkInfo>()));
  gh.factory<_i53.CreateBloc>(
      () => _i53.CreateBloc(createTasks: get<_i39.CreateTasks>()));
  gh.lazySingleton<_i54.DeleteEvent>(
      () => _i54.DeleteEvent(repository: get<_i51.CalendarRepository>()));
  gh.lazySingleton<_i55.GetCalendarList>(
      () => _i55.GetCalendarList(repository: get<_i51.CalendarRepository>()));
  gh.lazySingleton<_i56.GetEvents>(
      () => _i56.GetEvents(get<_i51.CalendarRepository>()));
  gh.lazySingleton<_i57.GetEventsBetween>(
      () => _i57.GetEventsBetween(get<_i51.CalendarRepository>()));
  gh.factory<_i58.TodayBloc>(() => _i58.TodayBloc(
      getEventEntry: get<_i57.GetEventsBetween>(),
      getTasks: get<_i46.GetTasks>(),
      getSubTasks: get<_i45.GetSubTasks>(),
      dataStream: get<_i7.AwsStream>()));
  gh.lazySingleton<_i59.UpdateCalendarList>(() =>
      _i59.UpdateCalendarList(repository: get<_i51.CalendarRepository>()));
  gh.lazySingleton<_i60.UpdateEvent>(
      () => _i60.UpdateEvent(repository: get<_i51.CalendarRepository>()));
  gh.lazySingleton<_i61.AddEvent>(
      () => _i61.AddEvent(repository: get<_i51.CalendarRepository>()));
  gh.factory<_i62.CalendarBloc>(() => _i62.CalendarBloc(
      getCalendarEntry: get<_i56.GetEvents>(),
      addEvent: get<_i61.AddEvent>(),
      deleteEvent: get<_i54.DeleteEvent>(),
      updateEvent: get<_i60.UpdateEvent>(),
      getCalendarList: get<_i55.GetCalendarList>()));
  gh.factory<_i63.CalendarListBloc>(() => _i63.CalendarListBloc(
      getCalendarList: get<_i55.GetCalendarList>(),
      updateCalendarList: get<_i59.UpdateCalendarList>()));
  return get;
}

class _$RegisterModule extends _i64.RegisterModule {}
