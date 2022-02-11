part of 'project_bloc.dart';

@freezed
class ProjectState with _$ProjectState {
  const factory ProjectState.initial() = _ProjectInitial;
  const factory ProjectState.loading() = _ProjectLoading;
  const factory ProjectState.error(String message) = _ProjectError;
  const factory ProjectState.loaded({List<ProjectEntry>? project}) = _ProjectLoaded;
}
