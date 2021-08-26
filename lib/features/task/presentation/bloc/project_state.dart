part of 'project_bloc.dart';

abstract class ProjectState extends Equatable {
  const ProjectState();
}

// class TaskInitial extends TaskState {
//   @override
//   List<Object> get props => [];
// }

class ProjectLoading extends ProjectState {
  @override
  List<Object?> get props => [];
}

class ProjectError extends ProjectState {
  const ProjectError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class ProjectLoaded extends ProjectState {
  const ProjectLoaded({required this.project});

  final List<ProjectEntry> project;

  @override
  List<Object?> get props => project;
}
