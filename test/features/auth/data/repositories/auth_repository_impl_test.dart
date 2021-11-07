import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/features/auth/data/datasources/aws_auth_data_source.dart';
import 'package:refocus_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:refocus_app/features/auth/domain/entities/auth_credential.dart';
import 'package:refocus_app/features/auth/domain/entities/user_entry.dart';
import 'package:refocus_app/models/ModelProvider.dart' as aws_model;

class MockAuthDataSource extends Mock implements AuthDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthDataSource mockAuthDataSource;

  setUp(() {
    mockAuthDataSource = MockAuthDataSource();
    repository = AuthRepositoryImpl(authDataSource: mockAuthDataSource);
  });

  group('Auth with Credentials', () {
    const tUserName = 'Avatar';
    const tEmail = 'avatar@gmail.com';
    const tPassword = 'avatar1234';
    final tUser = aws_model.User(
      id: '123456789',
      email: tEmail,
      username: tUserName,
    );
    final _tUserEntry = UserEntry.fromJson(tUser.toJson());

    // Sign Up Tests
    test(
      'should sign up successfully',
      () async {
        // arrange
        when(() => mockAuthDataSource.signUp(
              username: any(named: 'username'),
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => tUser);
        // act
        final result = await repository.signUpAndGetUserEntry(
          const AuthCredential(
            username: tUserName,
            email: tEmail,
            password: tPassword,
          ),
        );
        // assert
        verify(
          () => mockAuthDataSource.signUp(
            username: tUserName,
            email: tEmail,
            password: tPassword,
          ),
        );
        expect(result, isA<Right<Failure, UserEntry>>());
        expect(result, Right<dynamic, UserEntry>(_tUserEntry));
      },
    );

    test(
      'should sign up and return failure',
      () async {
        // arrange
        when(() => mockAuthDataSource.signUp(
              username: any(named: 'username'),
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => null);
        // act
        final result = await repository.signUpAndGetUserEntry(
          const AuthCredential(
            username: tUserName,
            email: tEmail,
            password: tPassword,
          ),
        );

        // assert
        verify(
          () => mockAuthDataSource.signUp(
            username: tUserName,
            email: tEmail,
            password: tPassword,
          ),
        );
        final tServerFailure = ServerFailure();
        expect(result, isA<Left<Failure, UserEntry>>());
        expect(result, Left<dynamic, UserEntry>(tServerFailure));
      },
    );

    // Login Tests
    test(
      'should login and return successfully',
      () async {
        // arrange
        when(() => mockAuthDataSource.login(
              username: any(named: 'username'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => tUser);
        // act
        final result = await repository.loginAndGetUserEntry(
          const AuthCredential(
            username: tUserName,
            email: tEmail,
            password: tPassword,
          ),
        );
        // assert
        verify(
          () => mockAuthDataSource.login(
            username: tUserName,
            password: tPassword,
          ),
        );
        expect(result, isA<Right<Failure, UserEntry>>());
        expect(result, Right<dynamic, UserEntry>(_tUserEntry));
      },
    );

    test(
      'should login and return failure',
      () async {
        // arrange
        when(() => mockAuthDataSource.login(
              username: any(named: 'username'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => null);
        // act
        final result = await repository.loginAndGetUserEntry(
          const AuthCredential(
            username: tUserName,
            email: tEmail,
            password: tPassword,
          ),
        );

        // assert
        verify(
          () => mockAuthDataSource.login(
            username: tUserName,
            password: tPassword,
          ),
        );
        final tServerFailure = ServerFailure();
        expect(result, isA<Left<Failure, UserEntry>>());
        expect(result, Left<dynamic, UserEntry>(tServerFailure));
      },
    );

    test(
      'should attempt to login automatically',
      () async {
        // arrange
        when(() => mockAuthDataSource.attemptAutoLogin())
            .thenAnswer((_) async => tUser);
        // act
        final result = await repository.autoLoginAndGetUserEntry();
        // assert
        verify(
          () => mockAuthDataSource.attemptAutoLogin(),
        );
        expect(result, isA<Right<Failure, UserEntry>>());
        expect(result, Right<dynamic, UserEntry>(_tUserEntry));
      },
    );
  });
}
