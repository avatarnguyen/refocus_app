import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_datasource.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/calendar/domain/usecases/get_events.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/gcal_bloc.dart';

class MockGetAllCalendarEntry extends Mock implements GetEvents {}

void main() {
  late GcalBloc bloc;
  late MockGetAllCalendarEntry mockGetAllCalendarEntry;

  setUp(() {
    mockGetAllCalendarEntry = MockGetAllCalendarEntry();

    bloc = GcalBloc(getAllCalendarEntry: mockGetAllCalendarEntry);
  });

  group('GetAllGCalEntries', () {
    final tGoogleCalendarEntry = GCalEventEntry(
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
        bloc.add(GetAllCalendarEntries());
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
        bloc.add(GetAllCalendarEntries());
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
        bloc.add(GetAllCalendarEntries());
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
        bloc.add(GetAllCalendarEntries());
      },
    );
  });
}
