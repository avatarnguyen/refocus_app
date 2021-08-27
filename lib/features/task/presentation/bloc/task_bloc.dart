import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/constants/failure_message.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/entities/task_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/helpers/task_params.dart';
import 'package:refocus_app/features/task/domain/usecases/task/create_tasks.dart';
import 'package:refocus_app/features/task/domain/usecases/task/delete_task.dart';
import 'package:refocus_app/features/task/domain/usecases/task/get_task.dart';
import 'package:refocus_app/features/task/domain/usecases/task/update_task.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';

part 'task_event.dart';
part 'task_state.dart';

@injectable
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc({
    required this.getTasks,
    required this.updateTask,
    required this.deleteTask,
    required this.createTasks,
  }) : super(TaskInitial());

  final GetTasks getTasks;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;
  final CreateTasks createTasks;

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if (event is GetTaskEntriesEvent) {
      log('Get Tasks Event');

      yield TaskLoading();
      final failureOrEntry = await getTasks(
        TaskParams(project: event.project),
      );
      yield* _eitherTaskLoadedOrErrorState(failureOrEntry);
      //TODO: What Stream here
    } else if (event is CreateTaskEntriesEvent) {
      log('Create New Task');

      yield* _mapTaskCreatedToState(event);
    }
  }

  Stream<TaskState> _mapTaskCreatedToState(
      CreateTaskEntriesEvent event) async* {
    if (state is TasksLoaded) {
      final failureOrSuccess = await createTasks(event.params);
      yield* failureOrSuccess.fold((failure) async* {
        yield TaskError(_mapFailureToMessage(failure));
      }, (entry) async* {
        print(entry);
      });
    }
  }

  Stream<TaskState> _eitherTaskLoadedOrErrorState(
      Either<Failure, List<TaskEntry>> failureOrEntry) async* {
    yield failureOrEntry.fold(
      (failure) => TaskError(_mapFailureToMessage(failure)),
      (entry) => TasksLoaded(tasks: entry),
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
}
