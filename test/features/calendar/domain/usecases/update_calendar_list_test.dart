import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:refocus_app/features/calendar/data/models/gcal_entry_model.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:refocus_app/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/calendar_params.dart';
import 'package:refocus_app/features/calendar/domain/usecases/update_calendar_list.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockGoogleCalendarRepository extends Mock implements CalendarRepository {}

void main() {
  late UpdateCalendarList usecase;
  late MockGoogleCalendarRepository mockGoogleCalendarRepository;

  setUp(() {
    mockGoogleCalendarRepository = MockGoogleCalendarRepository();
    usecase = UpdateCalendarList(repository: mockGoogleCalendarRepository);
  });

  final jsonMap =
      json.decode(fixture('calendar_list_entry.json')) as Map<String, dynamic>;
  final tCalendar = GCalEntryModel.fromJson(jsonMap);
  final tExpectedCalendar = tCalendar.copyWith(selected: false);

  test(
    'should change local calendar data',
    () async {
      // arrange
      when(() => mockGoogleCalendarRepository.updateCalendarList(tCalendar))
          .thenAnswer((_) async => Right(tExpectedCalendar));

      // act
      final result = await usecase(CalendarParams(calendar: tCalendar));
      print(jsonMap);
      print(tCalendar);
      print(tExpectedCalendar);

      // assert
      verify(() => mockGoogleCalendarRepository.updateCalendarList(tCalendar));
      expect(result, Right<dynamic, CalendarEntry>(tExpectedCalendar));
    },
  );
}
