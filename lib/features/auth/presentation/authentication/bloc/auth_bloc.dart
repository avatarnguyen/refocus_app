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
    required GetUser getUser,
  })  : _login = login,
        _signOut = signOut,
        _authStatus = authStatus,
        _getUser = getUser,
        super(const AuthState.loading()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<_AuthSignOutRequested>(_onSignOutRequested);
    on<_AuthAutoSignInAttempt>(_onAuthAutoSignInAttempt);
    _configureAmplify();
  }
  final Login _login;
  final SignOut _signOut;
  final AuthStatus _authStatus;
  final GetUser _getUser;

  final log = logger(AuthBloc);

  late StreamSubscription<Either<Failure, AuthenticationStatus>>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onAuthAutoSignInAttempt(
      _AuthAutoSignInAttempt event, Emitter<AuthState> emit) async {
    if (Amplify.isConfigured) {
      log.i('Perform Auto Login');
      await _login(const AuthParams());
    }
  }

  Future<void> _onAuthenticationStatusChanged(
      _AuthenticationStatusChanged event, Emitter<AuthState> emit) async {
    log.d('Current Auth Status: ${event.status}');
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _getUser(NoParams());
        return emit(user.fold(
          (failure) => const AuthState.unauthenticated(),
          (user) => AuthState.authenticated(user),
        ));
      default:
        return emit(const AuthState.unknown());
    }
  }

  Future<void> _onSignOutRequested(
      _AuthSignOutRequested event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    final _result = await _signOut(NoParams());
    _result.fold(
      (failure) => emit(const AuthState.unknown()),
      (entry) => emit(const AuthState.unauthenticated()),
    );
  }

  Future _configureAmplify() async {
    try {
      await Amplify.addPlugins([
        AmplifyAPI(),
        AmplifyDataStore(modelProvider: ModelProvider.instance),
        AmplifyAuthCognito(),
      ]);

      // Once Plugins are added, configure Amplify
      await Amplify.configure(amplifyconfig);

      // Listen to Auth Hubchannel for changes
      _authenticationStatusSubscription = _authStatus().listen((status) {
        status.fold(log.e, (_status) {
          add(AuthEvent.authenticationChanged(_status));
        });
      });
    } catch (e) {
      log.e(e);
    }
  }
}
