import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../constants/failure_message.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/calendar_entry.dart';
import '../../../../domain/usecases/get_calendar_list.dart';

part 'calendar_list_event.dart';
part 'calendar_list_state.dart';

@injectable
class CalendarListBloc extends Bloc<CalendarListEvent, CalendarListState> {
  CalendarListBloc({
    required this.getCalendarList,
  }) : super(CalendarListInitial());

  final GetCalendarList getCalendarList;

  @override
  Stream<CalendarListState> mapEventToState(
    CalendarListEvent event,
  ) async* {
    if (event is GetCalendarListEvent) {
      log('Get Calendar List');
      yield Loading();
      final failureOrEntry = await getCalendarList(NoParams());
      yield failureOrEntry.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (entries) => Loaded(calendarList: entries),
      );
    }
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
