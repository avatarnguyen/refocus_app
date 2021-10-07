part of 'subtask_cubit.dart';

@freezed
abstract class SubtaskState with _$SubtaskState {
  const factory SubtaskState.initial() = _Initial;
  const factory SubtaskState.loaded(List<SubTaskEntry> subtasks) =
      _SubTaskLoaded;
  const factory SubtaskState.error(String errorMessage) = _SubTaskError;
}
