import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/constants/failure_message.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/task/data/datasources/aws_stream.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/project_params.dart';
import 'package:refocus_app/features/task/domain/usecases/project/create_project.dart';
import 'package:refocus_app/features/task/domain/usecases/project/delete_project.dart';
import 'package:refocus_app/features/task/domain/usecases/project/get_projects.dart';
import 'package:refocus_app/features/task/domain/usecases/project/update_project.dart';
import 'package:refocus_app/injection.dart';
part 'task_event.dart';
part 'task_state.dart';

@injectable
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc({
    required this.getProjects,
    required this.updateProject,
    required this.deleteProject,
    required this.createProject,
  }) : super(TaskLoading());

  final GetProjects getProjects;
  final UpdateProject updateProject;
  final DeleteProject deleteProject;
  final CreateProject createProject;

  StreamSubscription? _awsSubscription;

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    print('Current TaskState: $state');

    if (event is GetProjectEntriesEvent) {
      print('Get Project Event');

      yield TaskLoading();
      final failureOrEntry = await getProjects(NoParams());
      yield* _eitherPrejectLoadedOrErrorState(failureOrEntry);

      await _awsSubscription?.cancel();
      _awsSubscription = getIt<AwsStream>()
          .getProjectStream
          .listen((_) => add(GetProjectEntriesEvent()));
    } else if (event is CreateProjectEntriesEvent) {
      print('Create New Project');

      yield* _mapProjectCreatedToState(event);
    }
  }

  Stream<TaskState> _mapProjectCreatedToState(
      CreateProjectEntriesEvent event) async* {
    if (state is ProjectLoaded) {
      final failureOrSuccess = await createProject(event.params);
      yield* failureOrSuccess.fold((failure) async* {
        yield TaskError(_mapFailureToMessage(failure));
      }, (entry) async* {
        final updatedProjects =
            List<ProjectEntry>.from((state as ProjectLoaded).project)
              ..add(entry);
        yield ProjectLoaded(project: updatedProjects);
      });
    }
  }

  Stream<TaskState> _eitherPrejectLoadedOrErrorState(
      Either<Failure, List<ProjectEntry>> failureOrEntry) async* {
    yield failureOrEntry.fold(
      (failure) => TaskError(_mapFailureToMessage(failure)),
      (entry) => ProjectLoaded(project: entry),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected error';
    }
  }

  @override
  Future<void> close() {
    _awsSubscription?.cancel();
    return super.close();
  }
}
