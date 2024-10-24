part of 'project_bloc.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();
}

//* GET
class GetProjectEntriesEvent extends ProjectEvent {
  @override
  List<Object?> get props => [];
}

class CreateProjectEntriesEvent extends ProjectEvent {
  const CreateProjectEntriesEvent(this.params);

  final ProjectParams params;

  @override
  List<Object?> get props => [params];
}

class UpdateProjectEntriesEvent extends ProjectEvent {
  const UpdateProjectEntriesEvent(this.params);

  final ProjectParams params;

  @override
  List<Object?> get props => [params];
}

class DeleteProjectEntriesEvent extends ProjectEvent {
  const DeleteProjectEntriesEvent(this.params);

  final ProjectParams params;

  @override
  List<Object?> get props => [params];
}
