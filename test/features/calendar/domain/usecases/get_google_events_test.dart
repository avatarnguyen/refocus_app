import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_datasource.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:refocus_app/features/calendar/domain/usecases/calendar_event/get_events.dart';

class MockGoogleCalendarRepository extends Mock implements CalendarRepository {}

void main() {
  late GetEvents usecase;
  late MockGoogleCalendarRepository mockGoogleCalendarRepository;

  setUp(() {
    mockGoogleCalendarRepository = MockGoogleCalendarRepository();

    usecase = GetEvents(mockGoogleCalendarRepository);
  });

  final tGoogleCalendarEntry = CalendarEventEntry(
    subject: 'Event Refocus App',
    id: '4okqcu9vna2ak7jt7545ndlp9n',
    startDateTime: DateTime.parse('2021-07-19T16:45:00+02:00'),
    endDateTime: DateTime.parse('2021-07-19T18:30:00+02:00'),
    organizer: 'Test Dev',
  );

  test(
    'should get calendar data entry from the repository',
    () async {
      // arrange
      when(() => mockGoogleCalendarRepository.getEventsData()).thenAnswer(
          (_) async => Right<Failure, CalendarData>(
              CalendarData(events: [tGoogleCalendarEntry])));
      // act
      final result = await usecase(NoParams());
      // assert
      //! Can only compare Type bc CalendarData is not Equatable
      expect(result, isA<Right<Failure, CalendarData>>());
      verify(mockGoogleCalendarRepository.getEventsData);
      verifyNoMoreInteractions(mockGoogleCalendarRepository);
    },
  );
}
