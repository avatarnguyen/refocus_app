import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/subtask/create_subtask.dart';
import 'package:refocus_app/features/task/domain/usecases/subtask/delete_subtask.dart';
import 'package:refocus_app/features/task/domain/usecases/subtask/get_subtasks.dart';
import 'package:refocus_app/features/task/domain/usecases/subtask/update_subtask.dart';

part 'subtask_state.dart';
part 'subtask_cubit.freezed.dart';

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
}
