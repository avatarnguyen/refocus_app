import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/constants/failure_message.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/calendar/domain/usecases/get_calendar_list.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/calendar_params.dart';
import 'package:refocus_app/features/calendar/domain/usecases/update_calendar_list.dart';

part 'calendar_list_event.dart';
part 'calendar_list_state.dart';

@injectable
class CalendarListBloc extends Bloc<CalendarListEvent, CalendarListState> {
  CalendarListBloc({
    required this.getCalendarList,
    required this.updateCalendarList,
  }) : super(CalendarListInitial()) {
    on<GetCalendarListEvent>(_onGetCalendarListEvent);
    on<UpdateCalendarListEvent>(_onUpdateCalendarListEvent);
  }

  final GetCalendarList getCalendarList;
  final UpdateCalendarList updateCalendarList;

  Future<void> _onGetCalendarListEvent(
      GetCalendarListEvent event, Emitter<CalendarListState> emit) async {
    emit(CalendarListLoading());
    final _result = await getCalendarList(NoParams());
    _handleResult(_result, emit);
  }

  Future<void> _onUpdateCalendarListEvent(
      UpdateCalendarListEvent event, Emitter<CalendarListState> emit) async {
    emit(CalendarListLoading());
    await updateCalendarList(event.params);
    // Reload Calendar List
    final _result = await getCalendarList(NoParams());
    _handleResult(_result, emit);
  }

  void _handleResult(Either<Failure, List<CalendarEntry>> data,
      Emitter<CalendarListState> emit) {
    emit(data.fold(
      (failure) => CalendarListError(message: _mapFailureToMessage(failure)),
      (entry) => CalendarListLoaded(calendarList: entry),
    ));
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
