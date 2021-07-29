import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/calendar/domain/entities/gcal_event_entry.dart';
import 'package:refocus_app/features/calendar/domain/repositories/gcal_repository.dart';
import 'package:refocus_app/features/calendar/domain/usecases/get_google_events.dart';
import 'package:googleapis/calendar/v3.dart' as google_api;

import '../../../../fixtures/fixture_reader.dart';

class MockGoogleCalendarRepository extends Mock implements GCalRepository {}

void main() {
  late GetGoogleEvents usecase;
  late MockGoogleCalendarRepository mockGoogleCalendarRepository;

  setUp(() {
    mockGoogleCalendarRepository = MockGoogleCalendarRepository();

    usecase = GetGoogleEvents(mockGoogleCalendarRepository);
  });

  final tGoogleCalendarEntry = GCalEventEntry(
    subject: 'Event Refocus App',
    id: '4okqcu9vna2ak7jt7545ndlp9n',
    start: {'dateTime': '2021-07-19T16:45:00+02:00'},
    end: {'dateTime': '2021-07-19T18:30:00+02:00'},
  );

  test(
    'should get google calendar data entry from the repository',
    () async {
      // arrange
      when(() => mockGoogleCalendarRepository.getGoogleEventsData())
          .thenAnswer((_) async => Right(tGoogleCalendarEntry));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tGoogleCalendarEntry));
      verify(mockGoogleCalendarRepository.getGoogleEventsData);
      verifyNoMoreInteractions(mockGoogleCalendarRepository);
    },
  );
}
