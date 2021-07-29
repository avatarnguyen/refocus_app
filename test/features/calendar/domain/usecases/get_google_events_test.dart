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

  // final tEntry = 'Test';
  final event = google_api.Event.fromJson(
      json.decode(fixture('google_calendar_entry.json')));
  final tGoogleCalendarEntry = GCalEventEntry(appointment: event);

  test(
    'should get all google calendar entry from the repository',
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
