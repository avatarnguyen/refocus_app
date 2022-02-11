
part of 'project_bloc.dart';

@freezed
class ProjectEvent with _$ProjectEvent {
  const factory ProjectEvent.get() = _ProjectGetEvent;
  const factory ProjectEvent.create({required ProjectParams project}) = _ProjectCreateEvent;
  const factory ProjectEvent.update({required ProjectParams project}) = _ProjectUpdateEvent;
  const factory ProjectEvent.delete({required ProjectParams project}) = _ProjectDeleteEvent;
}
