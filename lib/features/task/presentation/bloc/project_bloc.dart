import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:refocus_app/constants/failure_message.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/core/aws_stream.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/project_params.dart';
import 'package:refocus_app/features/task/domain/usecases/project/create_project.dart';
import 'package:refocus_app/features/task/domain/usecases/project/delete_project.dart';
import 'package:refocus_app/features/task/domain/usecases/project/get_projects.dart';
import 'package:refocus_app/features/task/domain/usecases/project/update_project.dart';
import 'package:refocus_app/injection.dart';

part 'project_event.dart';
part 'project_state.dart';

@injectable
class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc({
    required this.getProjects,
    required this.updateProject,
    required this.deleteProject,
    required this.createProject,
  }) : super(ProjectLoading());

  final GetProjects getProjects;
  final UpdateProject updateProject;
  final DeleteProject deleteProject;
  final CreateProject createProject;

  StreamSubscription? _awsSubscription;

  @override
  Stream<ProjectState> mapEventToState(
    ProjectEvent event,
  ) async* {
    log('Current TaskState: $state');

    if (event is GetProjectEntriesEvent) {
      log('Get Project Event');

      if (state is! ProjectLoaded) {
        yield ProjectLoading();
      }
      final failureOrEntry = await getProjects(NoParams());
      yield* _eitherPrejectLoadedOrErrorState(failureOrEntry);

      await _awsSubscription?.cancel();
      _awsSubscription = getIt<AwsStream>()
          .getProjectStream
          .listen((dynamic _) => add(GetProjectEntriesEvent()));
    } else if (event is CreateProjectEntriesEvent) {
      log('Create New Project');

      yield* _mapProjectCreatedToState(event);
    }
  }

  Stream<ProjectState> _mapProjectCreatedToState(
      CreateProjectEntriesEvent event) async* {
    if (state is ProjectLoaded) {
      final failureOrSuccess = await createProject(event.params);
      yield* failureOrSuccess.fold((failure) async* {
        yield ProjectError(_mapFailureToMessage(failure));
      }, (entry) async* {
        final updatedProjects =
            List<ProjectEntry>.from((state as ProjectLoaded).project)
              ..add(entry);
        yield ProjectLoaded(project: updatedProjects);
      });
    }
  }

  Stream<ProjectState> _eitherPrejectLoadedOrErrorState(
      Either<Failure, List<ProjectEntry>> failureOrEntry) async* {
    yield failureOrEntry.fold(
      (failure) => ProjectError(_mapFailureToMessage(failure)),
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
