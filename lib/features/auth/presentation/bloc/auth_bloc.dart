import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/auth/domain/entities/user_entry.dart';
import 'package:refocus_app/features/auth/domain/usecases/auth_params.dart';
import 'package:refocus_app/features/auth/domain/usecases/login.dart';
import 'package:refocus_app/features/auth/domain/usecases/signout.dart';
import 'package:refocus_app/features/auth/domain/usecases/signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login _login;
  final SignUp _signUp;
  final SignOut _signOut;

  // ignore: sort_constructors_first
  AuthBloc(
      {required Login login, required SignUp signUp, required SignOut signOut})
      : _login = login,
        _signUp = signUp,
        _signOut = signOut,
        super(const _AuthLoading()) {
    // on<AuthEvent>((event, emit) {});
    on<_AuthLoginEvent>(_onLoginEvent);
    on<_AuthSignUpEvent>(_onSignUpEvent);
    on<_AuthSignOutEvent>(_onSignOutEvent);
  }

  Future<void> _onSignUpEvent(
      _AuthSignUpEvent event, Emitter<AuthState> emit) async {
    final _user = await _signUp(
      AuthParams(
        username: event.username,
        email: event.email,
        password: event.password,
      ),
    );
    _user.fold(
      (failure) => emit(const AuthState.error()),
      (entry) => emit(AuthState.success(entry)),
    );
  }

  Future<void> _onLoginEvent(
      _AuthLoginEvent event, Emitter<AuthState> emit) async {
    final _user = await _login(
      AuthParams(
        username: event.username,
        password: event.password,
      ),
    );
    _user.fold(
      (failure) => emit(const AuthState.error()),
      (entry) => emit(AuthState.success(entry)),
    );
  }

  Future<void> _onSignOutEvent(
      _AuthSignOutEvent event, Emitter<AuthState> emit) async {
    final _result = await _signOut(NoParams());
    _result.fold(
      (failure) => emit(const AuthState.error()),
      (entry) => emit(const AuthState.isSignedOut()),
    );
  }
}
