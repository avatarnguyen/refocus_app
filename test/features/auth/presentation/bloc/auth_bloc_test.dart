import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/features/auth/domain/entities/user_entry.dart';
import 'package:refocus_app/features/auth/domain/usecases/auth_params.dart';
import 'package:refocus_app/features/auth/domain/usecases/login.dart';
import 'package:refocus_app/features/auth/domain/usecases/signout.dart';
import 'package:refocus_app/features/auth/domain/usecases/signup.dart';
import 'package:refocus_app/features/auth/presentation/bloc/auth_bloc.dart';

class MockLogin extends Mock implements Login {}

class MockSignUp extends Mock implements SignUp {}

class MockSignOut extends Mock implements SignOut {}

void main() {
  late AuthBloc bloc;
  late MockLogin mockLogin;
  late MockSignUp mockSignUp;
  late MockSignOut mockSignOut;

  setUp(() {
    mockLogin = MockLogin();
    mockSignUp = MockSignUp();
    mockSignOut = MockSignOut();
    bloc = AuthBloc(
      login: mockLogin,
      signUp: mockSignUp,
      signOut: mockSignOut,
    );
  });

  group('Auth bloc', () {
    const tUsername = 'test_user';
    const tEmail = 'test_user@gmail.com';
    const tPassword = 'password';
    final tUser = UserEntry(
      id: 'testID',
      username: tUsername,
      email: tEmail,
    );
    test(
      'initial state is Loading State',
      () {
        expect(bloc.state, const AuthState.unknown());
      },
    );
    blocTest<AuthBloc, AuthState>(
      'emit success after login event',
      build: () => bloc,
      setUp: () {
        when(() => mockLogin.call(const AuthParams(
              username: tUsername,
              password: tPassword,
            ))).thenAnswer(
          (_) async => Right<Failure, UserEntry>(tUser),
        );
      },
      act: (_bloc) {
        _bloc.add(const AuthEvent.login(tUsername, tPassword));
      },
      expect: () => <AuthState>[
        AuthState.authenticated(tUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emit error after login failed',
      build: () => bloc,
      setUp: () {
        when(() => mockLogin.call(
              const AuthParams(
                username: tUsername,
                password: tPassword,
              ),
            )).thenAnswer((_) async => Left(ServerFailure()));
      },
      act: (_bloc) {
        _bloc.add(const AuthEvent.login(tUsername, tPassword));
      },
      expect: () => const <AuthState>[
        AuthState.unknown(),
      ],
    );
  });
}
