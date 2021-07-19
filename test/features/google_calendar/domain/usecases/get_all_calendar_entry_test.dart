import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/google_calendar/domain/entities/google_calendar_entry.dart';
import 'package:refocus_app/features/google_calendar/domain/repositories/google_calendar_repository.dart';
import 'package:refocus_app/features/google_calendar/domain/usecases/get_all_calendar_entry.dart';

class MockGoogleCalendarRepository extends Mock
    implements GoogleCalendarRepository {}

void main() {
  late GetAllCalendarEntry usecase;
  late MockGoogleCalendarRepository mockGoogleCalendarRepository;

  setUp(() {
    mockGoogleCalendarRepository = MockGoogleCalendarRepository();

    usecase = GetAllCalendarEntry(mockGoogleCalendarRepository);
  });

  // final tEntry = 'Test';
  final tGoogleCalendarEntry = GoogleCalendarEntry(summary: 'Test');

  test(
    'should get all google calendar entry from the repository',
    () async {
      // arrange
      when(() => mockGoogleCalendarRepository.getAllCalendarEntries())
          .thenAnswer((_) async => Right(tGoogleCalendarEntry));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tGoogleCalendarEntry));
      verify(mockGoogleCalendarRepository.getAllCalendarEntries);
      verifyNoMoreInteractions(mockGoogleCalendarRepository);
    },
  );
}
