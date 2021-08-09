import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_datasource.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/calendar/domain/usecases/add_event.dart';
import 'package:refocus_app/features/calendar/domain/usecases/delete_event.dart';
import 'package:refocus_app/features/calendar/domain/usecases/get_calendar_list.dart';
import 'package:refocus_app/features/calendar/domain/usecases/get_events.dart';
import 'package:refocus_app/features/calendar/domain/usecases/update_event.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/calendar_bloc.dart';

class MockGetAllCalendar extends Mock implements GetCalendarList {}

class MockGetAllCalendarEntry extends Mock implements GetEvents {}

class MockAddEvent extends Mock implements AddEvent {}

class MockUpdateEvent extends Mock implements UpdateEvent {}

class MockDeleteEvent extends Mock implements DeleteEvent {}

void main() {
  late CalendarBloc bloc;
  late MockGetAllCalendar mockGetAllCalendar;
  late MockGetAllCalendarEntry mockGetAllCalendarEntry;
  late MockAddEvent mockAddEvent;
  late MockUpdateEvent mockUpdateEvent;
  late MockDeleteEvent mockDeleteEvent;

  setUp(() {
    mockGetAllCalendar = MockGetAllCalendar();
    mockGetAllCalendarEntry = MockGetAllCalendarEntry();
    mockAddEvent = MockAddEvent();
    mockUpdateEvent = MockUpdateEvent();
    mockDeleteEvent = MockDeleteEvent();
    bloc = CalendarBloc(
      getCalendarEntry: mockGetAllCalendarEntry,
      addEvent: mockAddEvent,
      deleteEvent: mockDeleteEvent,
      updateEvent: mockUpdateEvent,
      getCalendarList: mockGetAllCalendar,
    );
  });

  group('GetAllGCalEntries', () {
    final tGoogleCalendarEntry = CalendarEventEntry(
      subject: 'Event Refocus App',
      id: '4okqcu9vna2ak7jt7545ndlp9n',
      startDateTime: DateTime.parse('2021-07-19T16:45:00+02:00'),
      endDateTime: DateTime.parse('2021-07-19T18:30:00+02:00'),
      organizer: 'Test Dev',
    );
    test(
      'should get data from getAllCalendarEntry usecase',
      () async {
        // arrange
        when(() => mockGetAllCalendarEntry(NoParams())).thenAnswer(
            (_) async => Right(CalendarData(events: [tGoogleCalendarEntry])));
        // act
        bloc.add(GetCalendarEntries());
        await untilCalled(() => mockGetAllCalendarEntry(NoParams()));
        // assert
        verify(() => mockGetAllCalendarEntry(NoParams()));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successful',
      () {
        // arrange
        when(() => mockGetAllCalendarEntry(NoParams())).thenAnswer(
            (_) async => Right(CalendarData(events: [tGoogleCalendarEntry])));
        // assert later
        final expected = [
          Loading(),
          Loaded(calendarData: CalendarData(events: [tGoogleCalendarEntry])),
        ];
        expectLater(bloc.stream.asBroadcastStream(), emitsThrough(Loading()));
        expectLater(bloc.stream.asBroadcastStream(), emitsInOrder(expected));
        // act
        bloc.add(GetCalendarEntries());
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () {
        // arrange
        when(() => mockGetAllCalendarEntry(NoParams()))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Loading(),
          const Error(message: serverFailureMessage),
        ];
        expectLater(bloc.stream.asBroadcastStream(), emitsInOrder(expected));
        // act
        bloc.add(GetCalendarEntries());
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      () {
        // arrange
        when(() => mockGetAllCalendarEntry(NoParams()))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          Loading(),
          const Error(message: cacheFailureMessage),
        ];
        expectLater(bloc.stream.asBroadcastStream(), emitsInOrder(expected));
        // act
        bloc.add(GetCalendarEntries());
      },
    );
  });
}
