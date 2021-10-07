import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/constants/failure_message.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/subtask_params.dart';
import 'package:refocus_app/features/task/domain/usecases/subtask/create_subtask.dart';
import 'package:refocus_app/features/task/domain/usecases/subtask/delete_subtask.dart';
import 'package:refocus_app/features/task/domain/usecases/subtask/get_subtasks.dart';
import 'package:refocus_app/features/task/domain/usecases/subtask/update_subtask.dart';

part 'subtask_state.dart';
part 'subtask_cubit.freezed.dart';

@injectable
class SubtaskCubit extends Cubit<SubtaskState> {
  SubtaskCubit({
    required this.getSubTasks,
    required this.updateSubTask,
    required this.createSubTask,
    required this.deleteSubTask,
  }) : super(const SubtaskState.initial());

  final GetSubTasks getSubTasks;
  final UpdateSubTask updateSubTask;
  final CreateSubTask createSubTask;
  final DeleteSubTask deleteSubTask;

  final log = logger(SubtaskCubit);

  Future<void> getSubTasksFromTask(String taskID) async {
    try {
      emit(const SubtaskState.initial());

      final _fetchedSubTasks = await getSubTasks(SubTaskParams(taskID: taskID));
      _fetchedSubTasks.fold(
        (failure) => emit(SubtaskState.error(_mapFailureToMessage(failure))),
        (entries) => emit(SubtaskState.loaded(entries)),
      );
    } catch (e) {
      log.e(e);
      emit(SubtaskState.error(e.toString()));
    }
  }

  Future<void> createNewSubtask(SubTaskEntry subTaskEntry) async {
    try {
      emit(const SubtaskState.initial());

      await createSubTask(
        SubTaskParams(subTaskEntry: subTaskEntry),
      );

      final _fetchedSubTasks =
          await getSubTasks(SubTaskParams(taskID: subTaskEntry.taskID));
      _fetchedSubTasks.fold(
        (failure) => emit(SubtaskState.error(_mapFailureToMessage(failure))),
        (entries) => emit(SubtaskState.loaded(entries)),
      );
    } catch (e) {
      log.e(e);
      emit(SubtaskState.error(e.toString()));
    }
  }

  Future<void> updateSubtask(SubTaskEntry subTaskEntry) async {
    try {
      emit(const SubtaskState.initial());

      await updateSubTask(
        SubTaskParams(subTaskEntry: subTaskEntry),
      );

      final _fetchedSubTasks =
          await getSubTasks(SubTaskParams(taskID: subTaskEntry.taskID));
      _fetchedSubTasks.fold(
        (failure) => emit(SubtaskState.error(_mapFailureToMessage(failure))),
        (entries) => emit(SubtaskState.loaded(entries)),
      );
    } catch (e) {
      log.e(e);
      emit(SubtaskState.error(e.toString()));
    }
  }

  Future<void> deleteSubtask(SubTaskEntry subTaskEntry) async {
    try {
      emit(const SubtaskState.initial());

      await deleteSubTask(
        SubTaskParams(subTaskEntry: subTaskEntry),
      );

      final _fetchedSubTasks =
          await getSubTasks(SubTaskParams(taskID: subTaskEntry.taskID));
      _fetchedSubTasks.fold(
        (failure) => emit(SubtaskState.error(_mapFailureToMessage(failure))),
        (entries) => emit(SubtaskState.loaded(entries)),
      );
    } catch (e) {
      log.e(e);
      emit(SubtaskState.error(e.toString()));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      case ArgumentError:
        return argumentFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
}
