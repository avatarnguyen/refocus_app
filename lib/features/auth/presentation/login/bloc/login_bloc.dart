import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/features/auth/domain/usecases/auth_params.dart';
import 'package:refocus_app/features/auth/domain/usecases/login.dart';
import 'package:refocus_app/features/auth/presentation/models/models.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login _login;

  // ignore: sort_constructors_first
  LoginBloc({required Login login})
      : _login = login,
        super(const _LoginStateCurrent()) {
    on<_LoginUsernameChanged>(_onLoginUsernameChanged);
    on<_LoginPasswordChanged>(_onLoginPasswordChanged);
    on<_LoginSubmitted>(_onLoginSubmitted);
  }

  void _onLoginUsernameChanged(
      _LoginUsernameChanged event, Emitter<LoginState> emit) {
    final _username = Username.dirty(event.username);
    emit(state.copyWith(
      username: _username,
      status: Formz.validate([
        state.password ?? const Password.pure(),
        _username,
      ]),
    ));
  }

  void _onLoginPasswordChanged(
      _LoginPasswordChanged event, Emitter<LoginState> emit) {
    final _password = Password.dirty(event.password);
    emit(state.copyWith(
      password: _password,
      status: Formz.validate([
        _password,
        state.username ?? const Username.pure(),
      ]),
    ));
  }

  Future<void> _onLoginSubmitted(
      _LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state.status?.isValid == true) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final result = await _login(AuthParams(
          username: state.username?.value,
          password: state.password?.value,
        ));
        result.fold(
            (failure) => (failure is AuthFailure)
                ? emit(state.copyWith(status: FormzStatus.submissionCanceled))
                : emit(state.copyWith(status: FormzStatus.submissionFailure)),
            (r) => emit(state.copyWith(status: FormzStatus.submissionSuccess)));
      } catch (e) {
        log('[Login_Bloc] $e');
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
