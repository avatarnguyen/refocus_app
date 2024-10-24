import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/constants/failure_message.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_datasource.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/calendar/domain/usecases/calendar_event/add_event.dart';
import 'package:refocus_app/features/calendar/domain/usecases/calendar_event/delete_event.dart';
import 'package:refocus_app/features/calendar/domain/usecases/calendar_event/get_events.dart';
import 'package:refocus_app/features/calendar/domain/usecases/calendar_event/update_event.dart';
import 'package:refocus_app/features/calendar/domain/usecases/calendar_list/get_calendar_list.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/event_params.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

@injectable
class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc({
    required GetEvents getCalendarEntry,
    required AddEvent addEvent,
    required DeleteEvent deleteEvent,
    required UpdateEvent updateEvent,
    required GetCalendarList getCalendarList,
  })  : _getCalendarEntry = getCalendarEntry,
        _addEvent = addEvent,
        _deleteEvent = deleteEvent,
        _updateEvent = updateEvent,
        _getCalendarList = getCalendarList,
        super(CalendarInitial()) {
    on<GetCalendarEntries>(_onGetCalendarEntries);
    on<AddCalendarEvent>(_onAddCalendarEvent);
    on<UpdateCalendarEvent>(_onUpdateCalendarEvent);
    on<DeleteCalendarEvent>(_onDeleteCalendarEvent);
  }

  final GetEvents _getCalendarEntry;
  final AddEvent _addEvent;
  final DeleteEvent _deleteEvent;
  final UpdateEvent _updateEvent;
  final GetCalendarList _getCalendarList;

  Future<void> _onGetCalendarEntries(
      GetCalendarEntries event, Emitter<CalendarState> emit) async {
    await _getCalendarList(NoParams());
    await _handleGetEvent(emit);
  }

  Future<void> _onAddCalendarEvent(
      AddCalendarEvent event, Emitter<CalendarState> emit) async {
    emit(CalendarLoading());
    final failureOrSuccess = await _addEvent(event.params);

    await failureOrSuccess.fold(
      (failure) async {
        emit(CalendarError(message: _mapFailureToMessage(failure)));
      },
      (_) async => _handleGetEvent(emit),
    );
  }

  Future<void> _onUpdateCalendarEvent(
      UpdateCalendarEvent event, Emitter<CalendarState> emit) async {
    emit(CalendarLoading());
    final failureOrSuccess = await _updateEvent(event.params);
    await failureOrSuccess.fold(
      (failure) async {
        emit(CalendarError(message: _mapFailureToMessage(failure)));
      },
      (_) async => _handleGetEvent(emit),
    );
  }

  Future<void> _onDeleteCalendarEvent(
      DeleteCalendarEvent event, Emitter<CalendarState> emit) async {
    emit(CalendarLoading());
    final failureOrSuccess = await _deleteEvent(event.params);
    await failureOrSuccess.fold(
      (failure) {
        emit(CalendarError(message: _mapFailureToMessage(failure)));
      },
      (_) async => _handleGetEvent(emit),
    );
  }

  Future<void> _handleGetEvent(Emitter<CalendarState> emit) async {
    final _calendarResult = await _getCalendarEntry(NoParams());
    _handleResult(_calendarResult, emit);
  }

  void _handleResult(Either<Failure, List<CalendarEventEntry>> data,
      Emitter<CalendarState> emit) {
    emit(data.fold(
      (failure) => CalendarError(message: _mapFailureToMessage(failure)),
      (entries) => CalendarLoaded(calendarData: CalendarData(events: entries)),
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
