import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/calendar/domain/entities/gcal_event_entry.dart';
import 'package:refocus_app/features/calendar/domain/usecases/get_google_events.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/gcal_bloc.dart';
import 'package:googleapis/calendar/v3.dart' as google_api;

import '../../../fixtures/fixture_reader.dart';

class MockGetAllCalendarEntry extends Mock implements GetGoogleEvents {}

void main() {
  late GcalBloc bloc;
  late MockGetAllCalendarEntry mockGetAllCalendarEntry;

  setUp(() {
    mockGetAllCalendarEntry = MockGetAllCalendarEntry();

    bloc = GcalBloc(getAllCalendarEntry: mockGetAllCalendarEntry);
  });

  group('GetAllGCalEntries', () {
    final event = google_api.Event.fromJson(
        json.decode(fixture('google_calendar_entry.json')));
    final tGoogleCalendarEntry = GCalEventEntry(appointment: event);

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
