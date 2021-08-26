// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i21;
import 'package:hive_flutter/hive_flutter.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i8;

import 'core/injectable_module.dart' as _i40;
import 'core/network/network_info.dart' as _i9;
import 'core/presentation/bloc/today_bloc.dart' as _i32;
import 'core/presentation/text_stream.dart' as _i13;
import 'core/presentation/widgets/page_stream.dart' as _i39;
import 'features/calendar/data/datasources/gcal_local_data_source.dart' as _i7;
import 'features/calendar/data/datasources/gcal_remote_data_source.dart'
    as _i20;
import 'features/calendar/data/repositories/calendar_repository_impl.dart'
    as _i27;
import 'features/calendar/domain/entities/calendar_entry.dart' as _i5;
import 'features/calendar/domain/entities/calendar_event_entry.dart' as _i6;
import 'features/calendar/domain/repositories/calendar_repository.dart' as _i26;
import 'features/calendar/domain/usecases/add_event.dart' as _i35;
import 'features/calendar/domain/usecases/delete_event.dart' as _i28;
import 'features/calendar/domain/usecases/get_calendar_list.dart' as _i29;
import 'features/calendar/domain/usecases/get_events.dart' as _i30;
import 'features/calendar/domain/usecases/get_events_between.dart' as _i31;
import 'features/calendar/domain/usecases/update_calendar_list.dart' as _i33;
import 'features/calendar/domain/usecases/update_event.dart' as _i34;
import 'features/calendar/presentation/bloc/calendar/calendar_bloc.dart'
    as _i36;
import 'features/calendar/presentation/bloc/calendar/datetime_stream.dart'
    as _i38;
import 'features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart'
    as _i37;
import 'features/task/data/datasources/aws_data_source.dart' as _i10;
import 'features/task/data/datasources/aws_stream.dart' as _i3;
import 'features/task/data/repositories/task_repository_impl.dart' as _i12;
import 'features/task/domain/repositories/task_repository.dart' as _i11;
import 'features/task/domain/usecases/project/create_project.dart' as _i16;
import 'features/task/domain/usecases/project/delete_project.dart' as _i18;
import 'features/task/domain/usecases/project/get_projects.dart' as _i22;
import 'features/task/domain/usecases/project/update_project.dart' as _i14;
import 'features/task/domain/usecases/task/create_tasks.dart' as _i17;
import 'features/task/domain/usecases/task/delete_task.dart' as _i19;
import 'features/task/domain/usecases/task/get_task.dart' as _i23;
import 'features/task/domain/usecases/task/update_task.dart' as _i15;
import 'features/task/presentation/bloc/project_bloc.dart' as _i24;
import 'features/task/presentation/bloc/task_bloc.dart'
    as _i25; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i10.TaskRemoteDataSource>(
      () => _i10.AWSTaskRemoteDataSource());
  gh.lazySingleton<_i11.TaskRepository>(() => _i12.TaskRepositoryImpl(
      remoteDataSource: get<_i10.TaskRemoteDataSource>()));
  gh.lazySingleton<_i13.TextStream>(() => _i13.TextStream());
  gh.lazySingleton<_i14.UpdateProject>(
      () => _i14.UpdateProject(get<_i11.TaskRepository>()));
  gh.lazySingleton<_i15.UpdateTask>(
      () => _i15.UpdateTask(get<_i11.TaskRepository>()));
  gh.lazySingleton<_i16.CreateProject>(
      () => _i16.CreateProject(get<_i11.TaskRepository>()));
  gh.lazySingleton<_i17.CreateTasks>(
      () => _i17.CreateTasks(get<_i11.TaskRepository>()));
  gh.lazySingleton<_i18.DeleteProject>(
      () => _i18.DeleteProject(get<_i11.TaskRepository>()));
  gh.lazySingleton<_i19.DeleteTask>(
      () => _i19.DeleteTask(get<_i11.TaskRepository>()));
  gh.lazySingleton<_i20.GCalRemoteDataSource>(() =>
      _i20.GoogleAPIGCalRemoteDataSoure(gCalSignIn: get<_i21.GoogleSignIn>()));
  gh.lazySingleton<_i22.GetProjects>(
      () => _i22.GetProjects(get<_i11.TaskRepository>()));
  gh.lazySingleton<_i23.GetTasks>(
      () => _i23.GetTasks(get<_i11.TaskRepository>()));
  gh.factory<_i24.ProjectBloc>(() => _i24.ProjectBloc(
      getProjects: get<_i22.GetProjects>(),
      updateProject: get<_i14.UpdateProject>(),
      deleteProject: get<_i18.DeleteProject>(),
      createProject: get<_i16.CreateProject>()));
  gh.factory<_i25.TaskBloc>(() => _i25.TaskBloc(
      getTasks: get<_i23.GetTasks>(),
      updateTask: get<_i15.UpdateTask>(),
      deleteTask: get<_i19.DeleteTask>(),
      createTasks: get<_i17.CreateTasks>()));
  gh.lazySingleton<_i26.CalendarRepository>(() => _i27.CalendarRepositoryImpl(
      remoteCalDataSource: get<_i20.GCalRemoteDataSource>(),
      localCalDataSource: get<_i7.GCalLocalDataSource>(),
      networkInfo: get<_i9.NetworkInfo>()));
  gh.lazySingleton<_i28.DeleteEvent>(
      () => _i28.DeleteEvent(repository: get<_i26.CalendarRepository>()));
  gh.lazySingleton<_i29.GetCalendarList>(
      () => _i29.GetCalendarList(repository: get<_i26.CalendarRepository>()));
  gh.lazySingleton<_i30.GetEvents>(
      () => _i30.GetEvents(get<_i26.CalendarRepository>()));
  gh.lazySingleton<_i31.GetEventsBetween>(
      () => _i31.GetEventsBetween(get<_i26.CalendarRepository>()));
  gh.factory<_i32.TodayBloc>(() => _i32.TodayBloc(
      getEventEntry: get<_i31.GetEventsBetween>(),
      getTasks: get<_i23.GetTasks>()));
  gh.lazySingleton<_i33.UpdateCalendarList>(() =>
      _i33.UpdateCalendarList(repository: get<_i26.CalendarRepository>()));
  gh.lazySingleton<_i34.UpdateEvent>(
      () => _i34.UpdateEvent(repository: get<_i26.CalendarRepository>()));
  gh.lazySingleton<_i35.AddEvent>(
      () => _i35.AddEvent(repository: get<_i26.CalendarRepository>()));
  gh.factory<_i36.CalendarBloc>(() => _i36.CalendarBloc(
      getCalendarEntry: get<_i30.GetEvents>(),
      addEvent: get<_i35.AddEvent>(),
      deleteEvent: get<_i28.DeleteEvent>(),
      updateEvent: get<_i34.UpdateEvent>(),
      getCalendarList: get<_i29.GetCalendarList>()));
  gh.factory<_i37.CalendarListBloc>(() => _i37.CalendarListBloc(
      getCalendarList: get<_i29.GetCalendarList>(),
      updateCalendarList: get<_i33.UpdateCalendarList>()));
  gh.singleton<_i38.DateTimeStream>(_i38.DateTimeStream());
  gh.singleton<_i21.GoogleSignIn>(registerModule.gCalSignIn);
  gh.singleton<_i39.PageStream>(_i39.PageStream());
  return get;
}

class _$RegisterModule extends _i40.RegisterModule {}
