import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/features/auth/domain/entities/user_entry.dart';
import 'package:refocus_app/features/auth/domain/usecases/auth_params.dart';
import 'package:refocus_app/features/auth/domain/usecases/auth_status.dart';
import 'package:refocus_app/features/auth/domain/usecases/get_user.dart';
import 'package:refocus_app/features/auth/domain/usecases/login.dart';
import 'package:refocus_app/features/auth/domain/usecases/signout.dart';
import 'package:refocus_app/features/auth/presentation/authentication/bloc/auth_bloc.dart';

class MockLogin extends Mock implements Login {}

class MockAuthStatus extends Mock implements AuthStatus {}

class MockSignOut extends Mock implements SignOut {}

class MockGetUser extends Mock implements GetUser {}

void main() {
  late AuthBloc bloc;
  late MockLogin mockLogin;
  late MockAuthStatus mockAuthStatus;
  late MockSignOut mockSignOut;
  late MockGetUser mockGetUser;

  setUp(() {
    mockLogin = MockLogin();
    mockAuthStatus = MockAuthStatus();
    mockSignOut = MockSignOut();
    mockGetUser = MockGetUser();
    bloc = AuthBloc(
      login: mockLogin,
      authStatus: mockAuthStatus,
      signOut: mockSignOut,
      getUser: mockGetUser,
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
        expect(bloc.state, const AuthState.loading());
      },
    );

    // blocTest<AuthBloc, AuthState>(
    //   'emit auth status when check authstatus changed',
    //     build: () => bloc,
    //     setUp: () {
    //       when
    //     },
    //     act: (_bloc) {},
    //   expect: () => <AuthState>[],
    // );
    blocTest<AuthBloc, AuthState>(
      'emit success after auto login event',
      build: () => bloc,
      setUp: () {
        when(() => mockLogin.call(const AuthParams(
              username: tUsername,
              password: tPassword,
            ))).thenAnswer(
          (_) async => const Right<Failure, Unit>(unit),
        );
      },
      act: (_bloc) {
        _bloc.add(const AuthEvent.autoSignInAttempt());
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
        _bloc.add(const AuthEvent.autoSignInAttempt());
      },
      expect: () => const <AuthState>[
        AuthState.unknown(),
      ],
    );
  });
}
