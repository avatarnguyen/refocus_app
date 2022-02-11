import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/project_params.dart';
import 'package:refocus_app/features/task/domain/usecases/project/create_project.dart';
import 'package:refocus_app/features/task/domain/usecases/project/delete_project.dart';
import 'package:refocus_app/features/task/domain/usecases/project/get_projects.dart';
import 'package:refocus_app/features/task/domain/usecases/project/update_project.dart';

part 'project_bloc.freezed.dart';
part 'project_event.dart';
part 'project_state.dart';

@injectable
class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc({
    required GetProjects getProjects,
    required UpdateProject updateProject,
    required DeleteProject deleteProject,
    required CreateProject createProject,
  })  : _getProjects = getProjects,
        _updateProject = updateProject,
        _deleteProject = deleteProject,
        _createProject = createProject,
        super(const ProjectState.initial()) {
    on<_ProjectGetEvent>(_onProjectGetEvent);
    on<_ProjectCreateEvent>(_onProjectCreateEvent);
    on<_ProjectUpdateEvent>(_onProjectUpdateEvent);
    on<_ProjectDeleteEvent>(_onProjectDeleteEvent);
  }

  final GetProjects _getProjects;
  final UpdateProject _updateProject;
  final DeleteProject _deleteProject;
  final CreateProject _createProject;

  Future<void> _onProjectCreateEvent(_ProjectCreateEvent event, Emitter<ProjectState> emit) async {}

  Future<void> _onProjectDeleteEvent(_ProjectDeleteEvent event, Emitter<ProjectState> emit) async {}
  Future<void> _onProjectGetEvent(_ProjectGetEvent event, Emitter<ProjectState> emit) async {
    emit(const ProjectState.loading());
    final _result = await _getProjects(NoParams());
    _result.fold(
      (failure) => emit(
        ProjectState.error(failure.toString()),
      ),
      (projects) => emit(
        ProjectState.loaded(project: projects),
      ),
    );
  }

  Future<void> _onProjectUpdateEvent(_ProjectUpdateEvent event, Emitter<ProjectState> emit) async {}
}
