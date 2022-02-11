import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/amplifyconfiguration.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/enum/authetication_status.dart';
import 'package:refocus_app/features/auth/domain/entities/user_entry.dart';
import 'package:refocus_app/features/auth/domain/usecases/auth_params.dart';
import 'package:refocus_app/features/auth/domain/usecases/auth_status.dart';
import 'package:refocus_app/features/auth/domain/usecases/confirmation.dart';
import 'package:refocus_app/features/auth/domain/usecases/get_user.dart';
import 'package:refocus_app/features/auth/domain/usecases/login.dart';
import 'package:refocus_app/features/auth/domain/usecases/signout.dart';
import 'package:refocus_app/models/ModelProvider.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required Login login,
    required SignOut signOut,
    required AuthStatus authStatus,
    required Confirmation confirmation,
    required GetUser getUser,
  })  : _login = login,
        _signOut = signOut,
        _authStatus = authStatus,
        _confirmation = confirmation,
        _getUser = getUser,
        super(const AuthState.loading()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<_AuthSignOutRequested>(_onSignOutRequested);
    on<_AuthAutoSignInAttempt>(_onAuthAutoSignInAttempt);
    on<_AuthConfirmAccount>(_onAuthConfirmAccount);
    //  _configureAmplify();
  }
  final Login _login;
  final SignOut _signOut;
  final Confirmation _confirmation;
  final AuthStatus _authStatus;
  final GetUser _getUser;

  final log = logger(AuthBloc);

  late StreamSubscription<Either<Failure, AuthenticationStatus>> _authenticationStatusSubscription;
  late StreamSubscription _amplifyHubSub;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _amplifyHubSub.cancel();
    return super.close();
  }

  Future<void> _onAuthConfirmAccount(_AuthConfirmAccount event, Emitter<AuthState> emit) async {
    final result = await _confirmation(AuthParams(
      username: event.username,
      confirmationCode: event.confirmCode,
    ));
    return result.fold(
      (failure) {
        return emit(const AuthState.unauthenticated());
      },
      (isConfirmed) async {
        if (isConfirmed) {
          final _loginResult = await _login(AuthParams(
            username: event.username,
            password: event.password,
          ));
          if (_loginResult is Right) {
            final user = await _getUser(NoParams());

            return emit(user.fold(
              (failure) => const AuthState.unauthenticated(),
              (user) => AuthState.authenticated(user),
            ));
          } else {
            return emit(const AuthState.unauthenticated());
          }
        } else {
          return emit(const AuthState.unauthenticated());
        }
      },
    );
  }

  Future<void> _onAuthAutoSignInAttempt(_AuthAutoSignInAttempt event, Emitter<AuthState> emit) async {
    log.d('Auto Login');
    if (Amplify.isConfigured) {
      // final _amplifyConfigured =  await _configureAmplifyHub();
      final result = await _login(const AuthParams());
      return result.fold(
        (failure) {
          log.e(failure.toString());
          return emit(const AuthState.unauthenticated());
        },
        (_isSignIn) async {
          log.i('User is logged in: $_isSignIn');
          if (_isSignIn) {
            final user = await _getUser(NoParams());

            log.v('Current User: $user');
            return emit(user.fold(
              (failure) => const AuthState.unauthenticated(),
              (user) => AuthState.authenticated(user),
            ));
          } else {
            emit(const AuthState.unauthenticated());
          }
        },
      );
    }
  }

  Future<void> _onAuthenticationStatusChanged(_AuthenticationStatusChanged event, Emitter<AuthState> emit) async {
    log.d('Current Auth Status: ${event.status}');
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _getUser(NoParams());
        log.i('$user is authenticated');
        return emit(user.fold(
          (failure) => const AuthState.unauthenticated(),
          (user) => AuthState.authenticated(user),
        ));
      case AuthenticationStatus.confirmationRequired:
        return emit(const AuthState.confirmationRequired());
      default:
        return emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onSignOutRequested(_AuthSignOutRequested event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    await _signOut(NoParams());
    emit(const AuthState.unauthenticated());
  }

  Future<bool> _configureAmplifyHub() async {
    try {
      /* await Amplify.addPlugins([
        AmplifyAPI(),
        AmplifyDataStore(modelProvider: ModelProvider.instance),
        AmplifyAuthCognito(),
      ]);

      // Once Plugins are added, configure Amplify
      await Amplify.configure(amplifyconfig); */

      // Listen to Auth Hubchannel for changes

      _authenticationStatusSubscription = _authStatus.call().listen((status) {
        status.fold(log.e, (_status) {
          add(AuthEvent.authenticationChanged(_status));
        });
      });
      return true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }
}
