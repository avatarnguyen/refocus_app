import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/enum/action_selection_type.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:refocus_app/features/task/domain/usecases/task/create_tasks.dart';

part 'create_event.dart';
part 'create_state.dart';
part 'create_bloc.freezed.dart';

@injectable
class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc({required CreateTasks createTasks})
      : _createTasks = createTasks,
        super(const _CreateStateCurrent(id: '')) {
    on<_CreateTitleChanged>(_onTitleChanged);
    on<_CreateIdChanged>(_onIdChanged);
    on<_CreateDueDateChanged>(_onDueDateChanged);
    on<_CreateStartDateTimeChanged>(_onStartDateTimeChanged);
    on<_CreateEndDateTimeChanged>(_onEndDateTimeChanged);
    on<_CreateTypeEntryChanged>(_onTypeEntryChanged);
    on<_CreateActionTypeChanged>(_onActionTypeChanged);
    on<_CreateProjectChanged>(_onProjectChanged);
    on<_CreateCalendarChanged>(_onCalendarChanged);
    on<_CreateSubTaskListChanged>(_onSubTaskListChanged);
    on<_CreateSubmission>(_onSubmission);
  }

  final CreateTasks _createTasks;

  void _onIdChanged(_CreateIdChanged event, Emitter<CreateState> emit) {
    emit(state.copyWith(id: event.id));
  }

  void _onTitleChanged(_CreateTitleChanged event, Emitter<CreateState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _onDueDateChanged(
      _CreateDueDateChanged event, Emitter<CreateState> emit) {
    emit(state.copyWith(dueDate: event.dateTime));
  }

  void _onStartDateTimeChanged(
      _CreateStartDateTimeChanged event, Emitter<CreateState> emit) {
    emit(state.copyWith(start: event.dateTime));
  }

  void _onEndDateTimeChanged(
      _CreateEndDateTimeChanged event, Emitter<CreateState> emit) {
    emit(state.copyWith(end: event.dateTime));
  }

  void _onTypeEntryChanged(
      _CreateTypeEntryChanged event, Emitter<CreateState> emit) {
    emit(state.copyWith(todayEntryType: event.todayEntryType));
  }

  void _onActionTypeChanged(
      _CreateActionTypeChanged event, Emitter<CreateState> emit) {
    emit(state.copyWith(actionType: event.actionType));
  }

  void _onProjectChanged(
      _CreateProjectChanged event, Emitter<CreateState> emit) {
    emit(state.copyWith(project: event.project));
  }

  void _onCalendarChanged(
      _CreateCalendarChanged event, Emitter<CreateState> emit) {
    emit(state.copyWith(calendar: event.calendar));
  }

  void _onSubTaskListChanged(
      _CreateSubTaskListChanged event, Emitter<CreateState> emit) {
    emit(state.copyWith(subTasks: event.subTasks));
  }

  void _onSubmission(_CreateSubmission event, Emitter<CreateState> emit) {
    //TODO:
  }
}
