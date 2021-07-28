import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/google_calendar/domain/entities/google_calendar_entry.dart';
import 'package:refocus_app/features/google_calendar/domain/usecases/get_all_calendar_entry.dart';
import 'package:refocus_app/features/google_calendar/presentation/bloc/gcal_bloc.dart';

class MockGetAllCalendarEntry extends Mock implements GetAllCalendarEntry {}

void main() {
  late GcalBloc bloc;
  late MockGetAllCalendarEntry mockGetAllCalendarEntry;

  setUp(() {
    mockGetAllCalendarEntry = MockGetAllCalendarEntry();

    bloc = GcalBloc(getAllCalendarEntry: mockGetAllCalendarEntry);
  });

  group('GetAllGCalEntries', () {
    final tGoogleCalendarEntry = GoogleCalendarEntry(summary: 'Test Dev');

    test(
      'should get data from getAllCalendarEntry usecase',
      () async {
        // arrange
        when(() => mockGetAllCalendarEntry(NoParams()))
            .thenAnswer((_) async => Right(tGoogleCalendarEntry));
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
        when(() => mockGetAllCalendarEntry(NoParams()))
            .thenAnswer((_) async => Right(tGoogleCalendarEntry));
        // assert later
        final expected = [
          // GcalInitial(),
          Loading(),
          Loaded(gCalEntry: tGoogleCalendarEntry),
        ];
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
